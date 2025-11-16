<?php 
namespace App\Helper;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Assets\File;
use SilverStripe\Assets\Upload;
use App\Helper\RestApiHelper;
use SilverStripe\Security\Security;
use App\Model\MemberCompanyData;
use App\Model\RentalWorkerInformation;
use App\Model\PersonalInformation;
class FileHelper {
    private $restApiHelper;
    public function __construct()
    {
       
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