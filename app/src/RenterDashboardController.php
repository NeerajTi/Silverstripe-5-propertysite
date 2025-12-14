<?php
namespace App\Controller;
use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Control\Controller;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Security\Security;
use SilverStripe\Security\Member;
use SilverStripe\Security\SecurityToken;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\UrlField;
use SilverStripe\Forms\FileField;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\HiddenField;
use SilverStripe\Forms\PasswordField;
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\OptionsetField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Control\Email\Email;
use SilverStripe\Assets\Image;
use SilverStripe\Control\Session;
use SilverStripe\Assets\Upload;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Subsites\Model\Subsite;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\Assets\File;
use SilverStripe\View\ArrayData;
use App\Model\PersonalInformation;
use App\Helper\RestApiHelper;
use App\Helper\GlobalHelper;
use App\Helper\FileHelper;
use App\Model\ApartmentWishlist;
use App\Model\Apartment;
use App\Model\ApartmentApplication;
use App\Model\MemberBasicData;
use App\Model\MemberCompanyData;
use App\Model\RentalWorkerInformation;
use App\Model\MemberSearchSetting;
use SilverStripe\ORM\DB;
class RenterDashboardController extends ContentController {
    private static $allowed_actions = [
        'index','info','updateinfo','savenotificationalert','remove_saved_search','tips','remove_account','schufa','subscription','payment_method','payment_discount','doUpdateRenter','deleteFileImg','uploadFile','wishlist','applications','application_detail','saved_search','stop_subscription'
    ];
    protected function init()
    {
        parent::init();

        // Check login status
        if (!Security::getCurrentUser()) {
            return $this->redirect('/login');
        }
        if(GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'broker' || GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'owner' || GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'seller'){
            return $this->redirect('/dashboard');
        }
    }

    public function applications(HTTPRequest $request)
    {
        $member = GlobalHelper::getLoggedInUser();
        $applications = ApartmentApplication::get()->filter('MemberID', $member->ID)->sort('Created', 'DESC');
    
        return $this->customise([
            'Title' => 'anhängige Anträge',
            'Applications' => $applications,
        ])->renderWith(['Layout/Renter/Applications', 'Page']);
    }

    public function application_detail(HTTPRequest $request)
{

 $member=Security::getCurrentUser();
    $application = ApartmentApplication::get()->byID($request->param('ID'));
    if($application->IsRead == 0){
    $application->IsRead = 1;
    $application->write();
    }
    $companyData=[];
  if($application->MemberID != $member->ID){
    $session = $request->getSession();
    $session->set('FlashMessage', 'You do not have permission to view that application');
    
    return $this->redirect('/renter-dashboard/applications');
  }
  $contactor=MemberBasicData::get()->filter('MemberID', $application->MemberID)->first();
  if($contactor->InseriereAls=='renter' || $contactor->InseriereAls=='owner' || $contactor->InseriereAls=='seller')
  {
    $profile=PersonalInformation::get()->filter('MemberID', $application->MemberID)->first();
  
  }else
  {
    $profile=$contactor;
    $companyData=MemberCompanyData::get()->filter('MemberID', $application->MemberID)->first();
   
  }
  $apartment=Apartment::get()->byID($application->ApartmentID);
  $ContactID=$apartment->ContactId;
 
  $apartmentContact=RentalWorkerInformation::get()->byID($ContactID);

    return $this->customise([
        'Title' => 'es besteht Interesse',
        'Application' => $application,
        'Apartment'=>Apartment::get()->byID($application->ApartmentID),
        'Profile' => $profile,
        'Contactor'=>$contactor,
        'CompanyData'=>$companyData,
        'apartmentContact'=>$apartmentContact
    ])->renderWith(['Layout/Renter/ApplicationDetail', 'Page']);
}

    public function index(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');

        if ($member) {
            return $this->customise([
                'Title' => 'Dashboard',
                'Name' => $firstName.' '.$lastName,
                'User' => $member
            ])->renderWith(['Layout/Renter/Dashboard', 'Page']);
        }else{
            return $this->redirect('/login');
        }
    }
    public function info(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');
        $personalInformation=PersonalInformation::get()->filter('MemberID', $member->ID)->first();
        if ($member) {
            return $this->customise([
                'Title' => 'Informationen',
                'Name' => $firstName.' '.$lastName,
                'User' => $member,
                'PersonalInformation' => $personalInformation
            ])->renderWith(['Layout/Renter/Info', 'Page']);
        }else{
            return $this->redirect('/login');
        }
    }

    public function updateinfo(HTTPRequest $request){
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');

        $form = $this->UpdateCompanyForm();

        $session = $this->getRequest()->getSession();
        $formSuccess = $session->get('FormSuccess');
        $errorMessage = $session->get('FormError');
        
        $session->clear('FormError');
        $session->clear('FormSuccess');
        $member = Security::getCurrentUser();
        $personalInformation = PersonalInformation::get()
            ->filter('MemberID', $member->ID)
            ->first();
        return $this->customise([
            'Title' => 'Personliche Angaben',
            'Name' => $firstName.' '.$lastName,
            'FormError' => $errorMessage,
            'FormSuccess' => $formSuccess,
            'Form' => $form,
            'Anrede' => $form->Fields()->dataFieldByName('Anrede'),
            'FirstName' => $form->Fields()->dataFieldByName('FirstName'),
            'LastName' => $form->Fields()->dataFieldByName('LastName'),
            'Geburtsdatum' => $form->Fields()->dataFieldByName('Geburtsdatum'),
            'MemberID' => $form->Fields()->dataFieldByName('MemberID'),
            'Strabe' => $form->Fields()->dataFieldByName('Strabe'),
            'Bilder' => $form->Fields()->dataFieldByName('Bilder'),
            'Nr' => $form->Fields()->dataFieldByName('Nr'),
            'Plz' => $form->Fields()->dataFieldByName('Plz'),
            'Ort' => $form->Fields()->dataFieldByName('Ort'),
            'Land' => $form->Fields()->dataFieldByName('Land'),
            'CountryCode' => $form->Fields()->dataFieldByName('CountryCode'),
            'Telefon' => $form->Fields()->dataFieldByName('Telefon'),
            'Email' => $form->Fields()->dataFieldByName('Email'),
            'Fax' => $form->Fields()->dataFieldByName('Fax'),
            'Description' => $form->Fields()->dataFieldByName('Description'),
            'PersonalInformation'     => $personalInformation,
        ])->renderWith(['Layout/Renter/UpdateInfo', 'Page']);
    }

    public function UpdateCompanyForm(){
        
        $member = Security::getCurrentUser();

        $records = PersonalInformation::get()
            ->filter('MemberID', $member->ID)
            ->first();

        if ($records) {
            $companyData = $records->toMap();
        }

        $fields = FieldList::create(
            HiddenField::create('MemberID', 'MemberID')->setValue($member->ID),
            FileField::create('Bilder', 'Upload Image')
                ->setAllowedExtensions(['jpg', 'jpeg', 'png'])
                ->setAttribute('id', 'BilderIDInput')
                ->setAttribute('class','inputFileHidden')
                ->setAttribute('accept', 'image/jpeg, image/png'),
            OptionsetField::create('Anrede', 'Anrede*', [
                'Herr' => 'Herr',
                'Frau' => 'Frau',
                'Ansonsten' => 'Ansonsten',
            ])->addExtraClass('radio_group')->setValue($companyData['Anrede'] ?? ''),
            TextField::create('Strabe', 'Strabe*')->setValue($companyData['Strabe'] ?? ''),
            TextField::create('FirstName', 'Vorname*')->setValue($companyData['FirstName'] ?? ''),
            TextField::create('LastName', 'Nachname*')->setValue($companyData['LastName'] ?? ''),
            TextField::create('Nr', 'Nr')->setValue($companyData['Nr'] ?? ''),
            TextField::create('Geburtsdatum', 'Geburtsdatum')->setValue($companyData['Geburtsdatum'] ?? ''),
            TextField::create('Plz', 'PLZ')->setValue($companyData['Plz'] ?? '')->setAttribute('pattern', '^[0-9]{5}$')
    ->setAttribute('maxlength', '5')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')"),
            TextField::create('Ort', 'Ort')->setValue($companyData['Ort'] ?? ''),
            DropdownField::create('Land', 'Land', [
                'Deutschland' => 'Deutschland',
                'Österreich' => 'Österreich',
                'Schweiz' => 'Schweiz',
                'Germany'=>'Germany'
            ])->setValue($companyData['Land']),
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setValue('+49')->setEmptyString('Ländervorwahl auswählen*')->setValue($companyData['CountryCode'] ?? ''),
            TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setValue($companyData['Telefon'] ?? '')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*')->setValue($companyData['Email'] ?? ''),
            TextField::create('Fax', 'Fax')->setValue($companyData['Fax'] ?? ''),
            TextareaField::create('Description', 'Company Description')->setAttribute('placeholder', '')->addExtraClass('short_content')->setValue($companyData['Description'] ?? ''),
        );

        $actions = FieldList::create(
            FormAction::create('doUpdateRenter', 'zur Bestätigung')
        );

        $validator = RequiredFields::create(['FirstName', 'LastName', 'Strabe', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'UpdateRenterForm', $fields, $actions, $validator);
        $form->setFormAction('/renter-dashboard/doUpdateRenter');
        return $form;
    }
    public function doUpdateRenter(HTTPRequest $request){
        $data = $request->postVars();

        $companyData = PersonalInformation::get()
            ->filter('MemberID', $data['MemberID'])
            ->first();

        if (!$companyData) {
            $companyData = new PersonalInformation();
            $companyData->MemberID = $data['MemberID'];
        }

        foreach ($data as $key => $value) {
            if ($companyData->hasField($key)) {
                $companyData->$key = $value;
            }
        }
        
        $companyData->write();

        $this->getRequest()->getSession()->set('FormSuccess', 'Ihre Daten wurden erfolgreich aktualisiert.');
        return $this->redirect('/renter-dashboard/updateinfo');
    }
    public function deleteFileImg(HTTPRequest $request): HTTPResponse
{
    if (!$request->isPOST() || !SecurityToken::inst()->checkRequest($request)) {
        return $this->jsonError('Invalid request', 400);
    }
    $fileHelper = new FileHelper();
    return $fileHelper->deleteFile($request);
}
public function uploadFile(HTTPRequest $request): HTTPResponse
{
    if (!$request->isPOST() || !SecurityToken::inst()->checkRequest($request)) {
        return $this->jsonError('Invalid request', 400);
    }
   // return $this->jsonOk($_FILES[$request->postVar('field')]);
    $member = Security::getCurrentUser();
    if (!$member) {
        return $this->jsonError('Unauthorized', 401);
    }
    $fileHelper = new FileHelper();
    return $fileHelper->uploadFile($request);
}
public function wishlist(HTTPRequest $request){
    $member = Security::getCurrentUser();
    $wishlist = ApartmentWishlist::get()->filter('MemberID', $member->ID);
    $apartmentIDs = $wishlist->column('ApartmentID') ?? [];
    $apartments = [];

    if (!empty($apartmentIDs)) {
        $apartments = Apartment::get()
            ->filter('ID', $apartmentIDs)
            ->sort('PaymentType', 'DESC')
            ->sort('Created', 'DESC');
    }
    return $this->customise([
        'Title' => 'Deine favoriten Wohnungen',
        'Wishlist' => $wishlist,
        'Apartments' => $apartments,
        'Name' => $member->FirstName.' '.$member->LastName,
    ])->renderWith(['Layout/Renter/Wishlist', 'Page']);
}

public function saved_search(HTTPRequest $request){
    $member = Security::getCurrentUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    $savedSearch = MemberSearchSetting::get()->filter('MemberID', $member->ID)->first();
   
   if($savedSearch){
      // read filters (use your keys from data-name)
     $price_min = (int) $savedSearch->Price_Min;     // example
      $space_min = (int) $savedSearch->Space_Min ;     // example

        $price_max = (int) $savedSearch->Price_Max;     // example
      $space_max = (int) $savedSearch->Space_Max ;     // example
     // Checkbox array (Rooms[])
       $rooms = json_decode($savedSearch->Rooms,true);
       $locations = json_decode($savedSearch->Locations,true); // array of selected labels
       $equipment = json_decode($savedSearch->Equipment,true); // array of selected labels
   }
        /** @var DataList $list */
        if($savedSearch)
        $list = Apartment::get()->filter('Status', 'published')->orderBy('Created', 'DESC');

        if ($savedSearch && $price_min) {
            $priceInt = (int) $price_max;
            $lower=$price_min;
        $upper    = number_format($priceInt + 0.99, 2, '.', ''); // "1847.99"
            // adapt to your schema (Price, Rent, etc.)
            $list = $list
    ->filter('Details.Kaltmiete:GreaterThanOrEqual', $lower)
    ->filter('Details.Kaltmiete:LessThanOrEqual', $upper);
        }
        if ($savedSearch && $space_min) {
            $list = $list
    ->filter('Details.Wohnflache:GreaterThanOrEqual', $space_min)
    ->filter('Details.Wohnflache:LessThanOrEqual', $space_max);
        }
            // Rooms — when user picked specifics: IN (...) ; when "Egal": skip (no restriction)
    if ($savedSearch && is_array($rooms) && !empty($rooms)) {
        // Adjust column name if needed; this assumes Details has field "Zimmer"
        $list = $list->filter('Details.Zimmer', array_map('intval', $rooms));
    }
    
    if ($savedSearch && is_array($locations)) {
        // trim and remove empties (in case "Alle" sneaks in)
        $locations = array_values(array_filter(array_map('trim', $locations), fn($v) => $v !== ''));
        if ($locations) {
            // IN (…) with exact match across selected names
            $list = $list->filter('Address.Stadtteil', $locations);
        }
    }
    if ($savedSearch && is_array($equipment)) {
        // trim and remove empties (in case "Alle" sneaks in)
        $equipment = array_values(array_filter(array_map('trim', $equipment), fn($v) => $v !== ''));
        if ($equipment) {
            // IN (…) with exact match across selected names
            $list = $list->filter('Details.DetailOptions.Label', $equipment);
        }
    }
    if($savedSearch){
$searchApartmentsPaginated = PaginatedList::create(
            $list,
            $request
        )->setPageLength(20);
    }
        $priceNotification = 1400;     // example
        $spaceNotification = 60;  
        $equipmentNotification=['Haustiere erlaubt']; 
        $Notificationlist1 = Apartment::get()->filter('Status', 'published');
        if ($priceNotification) {
            $priceInt = (int) $priceNotification;
        $upper    = number_format($priceInt + 0.99, 2, '.', ''); // "1847.99"
            // adapt to your schema (Price, Rent, etc.)
            $Notificationlist1 = $Notificationlist1->filter('Details.Kaltmiete:LessThanOrEqual', $upper);
        }
        if ($spaceNotification) {
            $Notificationlist1 = $Notificationlist1->filter('Details.Wohnflache:LessThanOrEqual', $spaceNotification);
        }
        $countNotification1=$Notificationlist1->count();
        if (is_array($equipmentNotification)) {
            // trim and remove empties (in case "Alle" sneaks in)
            $equipmentNotification = array_values(array_filter(array_map('trim', $equipmentNotification), fn($v) => $v !== ''));
            if ($equipmentNotification) {
                // IN (…) with exact match across selected names
                $Notificationlist1 = $Notificationlist1->filter('Details.DetailOptions.Label', $equipmentNotification);
            }
        }
        $countNotification2=$Notificationlist1->count();
    return $this->customise([
        'Title' => 'Deine gespeicherten Suchanfragen',
        'SavedSearch' => $savedSearch,
        'MemberBasicData'=>MemberBasicData::get()->filter('MemberID', $member->ID)->first(),
        'Name' => $member->FirstName.' '.$member->LastName,
        'Apartments' => $searchApartmentsPaginated ?? null,
        'countNotification1'=>$countNotification1 ?? null,
        'countNotification2'=>$countNotification2 ?? null,
        'isLoggedIn'=>GlobalHelper::isloggedin()
    ])->renderWith(['Layout/Renter/SavedSearch', 'Page']);
}

public function subscription(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    $plans=GlobalHelper::getSubscriptionPlans('renter',10);
    return $this->customise([
        'Title' => 'Mietenprofi',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
        'plans'=>$plans
    ])->renderWith(['Layout/Renter/Subscription', 'Page']);
}
public function payment_discount(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    $plans=GlobalHelper::getSubscriptionPlans('renter',25);
    return $this->customise([
        'Title' => 'Mietenprofi+',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
        'PaymentType'=>$request->postVar('PaymentType'),
        'plans'=>$plans
    ])->renderWith(['Layout/Renter/PaymentDiscount', 'Page']);
}
public function payment_method(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    $plans=GlobalHelper::getSubscriptionPlans('renter',25);
    return $this->customise([
        'Title' => 'Mietenprofi+',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
        'PaymentType'=>$request->postVar('PaymentType'),
        'plans'=>$plans,
        'planDetails'=>GlobalHelper::SelectedPlan($request->postVar('PaymentType'),'renter',25)
    ])->renderWith(['Layout/Payments/PaymentMethod', 'Page']);
}

public function schufa(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    return $this->customise([
        'Title' => 'SCHUFA - BonitätsCheck',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
    ])->renderWith(['Layout/Renter/Schufa', 'Page']);
}
public function tips(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    return $this->customise([
        'Title' => 'Tips',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
    ])->renderWith(['Layout/Renter/Tips', 'Page']);
}

public function remove_account(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $emailAddress = $member->Email;
   
    
    
$member = Member::get()->byID($member->ID);

if ($member) {
    $member->delete(); 
    $member->destroy(); 
}

    $domain = Subsite::currentSubsite()->Domain();
    $emaildomain = str_replace('www.', '', $domain);

    $email = new Email(); 

    $email->setTo($emailAddress); 

    $email->setFrom('no-reply@'. $emaildomain); 
    $email->setReplyTo('no-reply@vdkwohnungmieten.de');             

    $email->setSubject("Account Removed"); 

    $messageBody = "<!DOCTYPE html>
    <html>
    <body style='margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f4f4f4;'>
    <table width='100%' cellpadding='0' cellspacing='0' style='background-color: #f4f4f4; padding: 20px 0;'>
    <tr>
    <td align='center'>
    <table width='1000' cellpadding='0' cellspacing='0' style='background-color: #ffffff; border-radius: 6px; overflow: hidden;'>
    <!-- Top Login Link -->
    <tr>
    <td style='padding: 30px 20px; text-align: center; background-color: #ffffff;'>
    <a href='https://wmb.newsoftdemo.info'>
    <img src='https://www.wmb.newsoftdemo.info/themes/template/images/logo.png' alt='' style='vertical-align: middle; max-width: 28px; object-fit: cover;'>
    <span style='color: #D98209; font-size: clamp(16px, 1.25rem, 1.25rem); font-weight: 500; text-shadow: none; display: inline-block; padding-left: 4px;'>Wohnung mieten Berlin.de</span>
    </a>
    </td>
    </tr>

    <!-- Email Body -->
    <tr>
    <td style='padding: 50px 40px; color: #333333; min-height:800px;'>
    <h2 style='margin-top: 0;'>Account Removed</h2>
    <p style='font-size: 16px; line-height: 1.5;'>
    Your account has been removed successfully.
    </p>

    </td>
    </tr>

    <!-- Footer -->
    <tr>
    <td style='padding: 20px 40px; font-size: 12px; color: #FFF; text-align: center; background-color: #D98209;'>
    © 2025 Wohnung mieten Berlin.de. All rights reserved.
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    </body>
    </html>"; 

    $email->setBody($messageBody); 
    $email->send();
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Account removed successfully',
        'action'=>'remove'
        ]);

}

public function savenotificationalert(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $data = json_decode($request->getBody(), true);
    $notificationNum = $data['notificationNum'] ?? null;
    $isChecked = $data['isChecked'] ?? null;
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    if($notificationNum=="1")
    $memberBasicData->Notification1 = $isChecked;
    else
    $memberBasicData->Notification2 = $isChecked;
    $memberBasicData->write();
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Notification alert saved successfully',
        'action'=>'save'
        ]);
}
public function stop_subscription(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    $memberBasicData->AutoSubscription = 1;
    $memberBasicData->write();
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Subscription stopped successfully',
        'action'=>'stop'
        ]);
}
public function start_subscription(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    $memberBasicData->AutoSubscription = 0;
    $memberBasicData->write();
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Subscription started successfully',
        'action'=>'start'
        ]);
}

public function remove_saved_search()
{
     $member = Security::getCurrentUser();
    $savedSearch = MemberSearchSetting::get()->filter('MemberID', $member->ID)->first();
    if($savedSearch)
    {
        $savedSearch->delete();
    $savedSearch->destroy();
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Successfully deleted',
        'action'=>'remove'
        ]);
    }else{
     return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'You have no saved search',
        'action'=>'remove'
        ]);   
    }
    
}
// public function payment_thankyou(HTTPRequest $request){
//     $member = GlobalHelper::getLoggedInUser();
//     $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
//     return $this->customise([
//         'Title' => 'Zahlung erfolgreich',
//         'Name' => $member->FirstName.' '.$member->LastName,
//         'MemberBasicData' => $memberBasicData,
//     ])->renderWith(['Layout/Renter/PaymentThankyou', 'Page']);
// }
}