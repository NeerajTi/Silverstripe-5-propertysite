<?php 
namespace App\Helper;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Assets\File;
use SilverStripe\Assets\Upload;
use App\Helper\RestApiHelper;
use SilverStripe\Security\Security;
use SilverStripe\Security\SecurityToken;
use App\Model\MemberCompanyData;
use App\Model\RentalWorkerInformation;
use App\Model\PersonalInformation;
class FileHelper {
    private $restApiHelper;
    public function __construct()
    {
       
    }  
    
 
    public function uploadPreview($request): HTTPResponse
{
    if (!$request->isPOST() || !SecurityToken::inst()->checkRequest($request)) {
        return RestApiHelper::jsonError('Invalid request', 400);
    }

    $member = Security::getCurrentUser();
    if (!$member) {
        return RestApiHelper::jsonError('Unauthorized', 401);
    }

    // ✅ Only one field: Bilder
    if (empty($_FILES['Attachment'])) {
        return RestApiHelper::jsonError('No file uploaded', 400);
    }

    // Upload image (NOT attached to Apartment yet)
    $img = $this->attachImageFromFilesObjectPreview($_FILES['Attachment']);

    if (!$img) {
        return RestApiHelper::jsonError('File upload failed', 500);  
    }

    // Publish so preview URL works
    $img->publishSingle();

    // Optional: mark as temporary
    $img->IsTemporary = true;
    $img->write();

    return RestApiHelper::jsonOk([
        'ok'  => true,
        'id'  => (int) $img->ID,
        'url' => $img->getURL()
    ]);
}
public function attachImageFromFilesObjectPreview($files, string $folder = 'apartments')
{
    if (empty($files) || empty($files['tmp_name'])) {
        return null;
    }

    $upload = Upload::create();
    $upload->getValidator()->setAllowedExtensions([
        'jpg','jpeg','png','gif',
        'pdf','doc','docx',
        'avi','mov','mpg','mp4','mkv'
    ]);
    
    // Use generic File instead of Image
    if($files['type'] == 'image/jpeg' || $files['type'] == 'image/png' || $files['type'] == 'image/gif'){
        $file = Image::create();
    }else{
        $file = File::create();
    }
   

    if ($upload->loadIntoFile($files, $file, $folder)) {
        return $file; // published later if you want
    }

    // Debug: $upload->getErrors()
    return null;
}
public function uploadFile($request): HTTPResponse
{

    $member = Security::getCurrentUser();
    if (!$member) {
        return RestApiHelper::jsonError('Unauthorized', 401);
    }
   
    if($request->postVar('objectID') == 'NewContact')
    {
        if ($img = $this->attachImageFromFilesObject($_FILES[$request->postVar('field')], 'profiles')) {
      
            $img->publishSingle();
            return RestApiHelper::jsonOk([
                'ok'  => true,
                'id'  => (int)$img->ID,
                'url' => $img->getURL()
            ]);
       
    }
    }
    else {
    if($request->postVar('table') == 'MemberCompanyData')
    $object = MemberCompanyData::get()->filter('MemberID', $member->ID)->first();
    else if($request->postVar('table') == 'RentalWorkerInformation' && $request->postVar('objectID'))
    $object = RentalWorkerInformation::get()->byID($request->postVar('objectID'));
    else if($request->postVar('table') == 'PersonalInformation' && $request->postVar('objectID'))
    $object = PersonalInformation::get()->byID($request->postVar('objectID'));
    if (!$object) {
        return RestApiHelper::jsonError('Object not found or not yours', 404);
    }
    if ($img = $this->attachImageFromFilesObject($_FILES[$request->postVar('field')], 'profiles')) {
      
            $img->publishSingle();
            $object->{$request->postVar('field')}= $img->ID;
            $object->write();
            return RestApiHelper::jsonOk([
                'ok'  => true,
                'id'  => (int)$img->ID,
                'url' => $img->getURL()
            ]);
       
    }
}
    return RestApiHelper::jsonError('File upload failed', 500);   
}

private function attachImageFromFilesObject($files, string $folder = 'profiles'): ?File
{
    if (empty($files) || empty($files['tmp_name'])) {
        return null; // no file chosen
    }

   $upload = Upload::create();
$upload->getValidator()->setAllowedExtensions(['jpg','jpeg','png','webp']); // ✅

$file = Image::create();
    if ($upload->loadIntoFile($files, $file, $folder)) {
        return $file; 
    }
    // Optional: inspect $upload->getErrors()
    return null;
}
public function deleteFilePreview($request): HTTPResponse
{

$fileID = $request->postVar('fileID');
  $file = File::get()->byID($fileID);
    if (!$file) {
        return RestApiHelper::jsonError('File not found'.$fileID, 404);
    }

    // ✅ Safety: only delete temp / unowned files
    if ($file->hasField('IsTemporary') && !$file->IsTemporary) {
        return RestApiHelper::jsonError('File already attached', 403);
    }

    // delete DB record + physical file
    $file->delete();

    return RestApiHelper::jsonOk([
        'message' => 'Deleted'
    ]);
}
public function deleteFile($request): HTTPResponse
{
    
 
    // Must be logged in
    $member = Security::getCurrentUser();
    if (!$member) {
        return RestApiHelper::jsonError('Unauthorized', 401);
    }
    if($request->postVar('table') == 'RentalWorkerInformation')
    $object = RentalWorkerInformation::get()->byID($request->postVar('objectId'));
    else if($request->postVar('table') == 'MemberCompanyData')
    $object = MemberCompanyData::get()->filter('MemberID', $member->ID)->first();
    else if($request->postVar('table') == 'PersonalInformation')
    $object = PersonalInformation::get()->byID($request->postVar('objectId'));
    if (!$object) {
        return RestApiHelper::jsonError('Worker not found or not yours', 404);
    }

    // Only allow these fields to be cleared
    $field = $request->postVar('field');
    $allowedFields = ['ImageID','BilderID'];
    if (!in_array($field, $allowedFields, true)) {
        return RestApiHelper::jsonError('Invalid field', 422);
    }

    // Get current file id for this field
    $fileID = (int) $object->{$field};
    if (!$fileID) {
        return RestApiHelper::jsonOk(['message' => 'Nothing to delete', 'field' => $field]);
    }

    /** @var File|null $file */
    $file = File::get()->byID($fileID);

    // Clear relation first
    $object->{$field} = 0;
    $object->write();

    // If you also want to remove the underlying asset and DB record:
    if ($file) {
        // Unpublish if versioned
        if ($file->hasExtension(Versioned::class)) {
            try { $file->doUnpublish(); } catch (\Throwable $e) { /* ignore */ }
        }
        // Delete DB record and physical file
        try {
            $file->deleteFile(); // remove from filesystem
        } catch (\Throwable $e) { /* ignore */ }
        try {
            $file->delete(); // remove DB record
        } catch (\Throwable $e) { /* ignore */ }
    }

    return RestApiHelper::jsonOk([
        'message' => 'Deleted',
        'field'   => $field,
        'objectID' => $object->ID
    ]);
}

}