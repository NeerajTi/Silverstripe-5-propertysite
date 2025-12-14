<?php 
namespace App\Controller;

use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Control\Controller;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use App\Model\Apartment;
use App\Model\ApartmentDetail;
use App\Model\ApartmentAddress;
use App\Model\ApartmentImage;
use App\Model\MemberBasicData;
use App\Model\MemberCompanyData;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\HiddenField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\OptionsetField;
use SilverStripe\Forms\TextareaField;
use App\Model\RentalWorkerInformation;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\ORM\DB;
use SilverStripe\View\ArrayData;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\Security\SecurityToken;
use SilverStripe\Core\Convert;
use SilverStripe\Security\Security;
use App\Helper\GlobalHelper;
use App\Helper\RestApiHelper;
use App\Model\PersonalInformation;
use App\Model\ApartmentWishlist;
use App\Model\ApartmentApplication;
use App\Model\MemberSearchSetting;
class FrontApartmentController extends ContentController
{
    protected bool $leafletEnabled = false;
    private static $allowed_actions = [
        'index','frontapartmentlist','maplocations','view','ajaxview','list','contact_apartment','addtowishlist','doContactProperty','previewapplicant','storesearch'
    ];
    protected function init()
    {
        parent::init();

        // Only include Leaflet for specific routes
        $currentSegment = $this->URLSegment;

        if (in_array($currentSegment, ['stadtteile-berlins', 'wohnungsuche'])) {
            $this->leafletEnabled = true;
        }
    }
    public function getLeafletEnabled(): bool
    {
        return $this->leafletEnabled;
    }
    public function CurrentUrl()
    {
        $url = $this->getRequest()->getURL();
    $parts = explode('/', $url);
    // Return only the first segment (wohnungsuche)
    return $parts[0] ?: '';
    }
    public function index(HTTPRequest $request)
    {
        $state='';

        if ($this->getRequest()->getURL() == 'stadtteile-berlins') {
            $state='Berlin';
        }
        return $this->frontapartmentlist($request,$state);
        // Only for /stadtteile-berlins — won’t affect other ApartmentController routes
       
    }
    
    /**
 * Safely filter a DataList by a relation field in SilverStripe 5.
 * If no related records match, returns an empty DataList without throwing an error.
 *
 * @param DataList $list      The main DataList (e.g., Apartment::get())
 * @param string   $relation  The relation name (e.g., 'Details')
 * @param string   $filter    The field filter (e.g., 'Kaltmiete:LessThanOrEqual')
 * @param mixed    $value     The value to filter by
 *
 * @return DataList
 */
function safeRelationFilter($list, $relation, $filter, $value) {
    // Step 1: Get related class name
    $relationClass = $list->dataClass()::get()->first()->getRelationClass($relation);

    if (!$relationClass) {
        // Relation does not exist
        return $list->filter('ID', 0);
    }

    // Step 2: Get matching related IDs
    $matchingIDs = $relationClass::get()->filter($filter, $value)->column('ID');

    // Step 3: Return safely filtered list
    if (!empty($matchingIDs)) {
        return $list->filter($relation . 'ID', $matchingIDs);
    } else {
        // No matches → return empty list safely
        return $list->filter('ID', 0);
    }
}
public function ApartmentsWithCoords()
{
    return Apartment::get()
        ->filter([
            'Status' => 'published',
            'Address.Lat:not' => null,
            'Address.Lng:not' => null,
        ])
        ->exclude([
            'Address.Lat' => '',
            'Address.Lng' => '',
        ])
        ->sort('PaymentType', 'DESC')
        ->sort('Created', 'DESC');
}
public function maplocations(HTTPRequest $request)
{
    
    return $this->customise([
        'Title' => 'Stadtteile Berlins',
    ])->renderWith(['Layout/FrontApartmentMapLocations', 'Page']);
              
}
    public function frontapartmentlist(HTTPRequest $request,$state=''){
      
        $request = $this->getRequest();
        $apartments = Apartment::get()->filter('Status', 'published');

        // Apply Berlin filter only if state is provided and not empty
        if ($state && !empty(trim($state))) {
            $apartments = $apartments->filter([
                'Address.Stadt' => $state
            ]);
        }
        
        $apartments = $apartments->sort('PaymentType', 'DESC')->sort('Created', 'DESC');
           $apartmentsPaginated = PaginatedList::create(
            $apartments,
            $request
        )->setPageLength(15);
           $detailIDs = $apartments->column('DetailsID');
           $addressIDs = $apartments->column('AddressID');

           // Step 3: Query ApartmentDetail for max values among those IDs
        
       $maxRoomspace = ApartmentDetail::get()->filter(['ID' => $detailIDs
              ])->max('Wohnflache');
              $minRoomspace = ApartmentDetail::get()->filter(['ID' => $detailIDs
              ])->min('Wohnflache');
   
         $maxPrice = ApartmentDetail::get()->filter(['ID' => $detailIDs])->max('Kaltmiete');
         $minPrice = ApartmentDetail::get()->filter(['ID' => $detailIDs])->min('Kaltmiete');
         $sql = "SELECT Zimmer, COUNT(*) as Count 
         FROM ApartmentDetail
         WHERE ID IN (" . implode(',', $detailIDs) . ")
         GROUP BY Zimmer
         ORDER BY Zimmer";
         $results = DB::query($sql);
         $roomCounts = [];
         foreach ($results as $row) {
            $roomCounts[$row['Zimmer']] = $row['Count'];
        }

       $cityPartssql = "SELECT Stadtteil, COUNT(*) as Count 
         FROM ApartmentAddress
         WHERE ID IN (" . implode(',', $addressIDs) . ")
         GROUP BY Stadtteil
         ORDER BY Stadtteil";
       
         $cityPartssqlResults = DB::query($cityPartssql);
         $cityPartCounts = [];
         foreach ($cityPartssqlResults as $row) {
            $cityPartCounts[$row['Stadtteil']] = $row['Count'];
        }

        // Assume $apartmentDetails is a list of ApartmentDetail DataObjects
        $allOptions = [];
        $apartmentDetails = ApartmentDetail::get()->filter(['ID' => $detailIDs]);
        
        foreach ($apartmentDetails as $detail) {
            // Loop through has_many DetailOptions relation
            foreach ($detail->DetailOptions() as $opt) {
                // Use Label and Value fields
                $allOptions[$opt->Label] = $opt->Label;
            }
        }
      
// Count occurrences of each distinct value
$optionCounts = array_count_values($allOptions);

           return $this->customise([
            'Title' => $state!='' ? 'Stadtteile Berlins':'Wohnungsuche',
            'Apartments' => $apartmentsPaginated,
            'totalApartments'=>$apartments->count(),
            'MaxRoomspace'=>$maxRoomspace,
            'MinRoomspace'=>$minRoomspace,
            'MaxPrice'=>$maxPrice,
            'MinPrice'=>$minPrice,
            'RoomCounts'=>$this->ssArray($roomCounts),
            'TotalRooms'=>array_sum($roomCounts),
            'CityPartCounts'=>$this->ssArray($cityPartCounts),
            'TotalCityParts'=>array_sum($cityPartCounts),
            'OptionCounts'=>$this->ssArray($optionCounts),
            'isLoggedIn'=>GlobalHelper::isloggedin(),
            'TotalOptions'=>array_sum($optionCounts),
            'state'=>$state,
            'userType'=>GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType')
        ])->renderWith(['Layout/FrontApartmentList', 'Page']);
    }
    public function view(HTTPRequest $request){
       
        
    $apartment = Apartment::get()->byID($request->param('ID'));
    $detailOptions=$apartment->Details->DetailsOptions;
    $detailIDs=$apartment->Details->ID;
    // Normalize: make each value into ArrayData
    $allOptions = [];
    $apartmentDetails = ApartmentDetail::get()->filter(['ID' => $detailIDs]);
    $memberBasicData=MemberBasicData::get()->filter(['MemberID' => $apartment->MemberID])->first();
    if($memberBasicData->InseriereAls=='broker')
    $company=MemberCompanyData::get()->filter(['MemberID' => $apartment->MemberID])->first();
    else
    $company=PersonalInformation::get()->filter(['MemberID' => $apartment->MemberID])->first();
    $brokerAptSlug=strtolower($memberBasicData->FirstName).'-'.strtolower($memberBasicData->LastName).'-'.$apartment->MemberID;
    foreach ($apartmentDetails as $detail) {
        // Loop through has_many DetailOptions relation
        foreach ($detail->DetailOptions() as $opt) {
            // Use Label and Value fields
            $allOptions[$opt->Label] = $opt->Label;
        }
    }
    $optionCounts = array_count_values($allOptions);
    $apartment->ViewCount = $apartment->ViewCount + 1;
    $apartment->write();
    $loginUser=[];
   if(GlobalHelper::isloggedin())
   {
    $loginUser=MemberBasicData::get()->filter(['MemberID' => GlobalHelper::getLoggedInUser()->ID])->first();
   }
    return $this->customise([
            'Title' => $apartment->Address->Street.', '.$apartment->Address->Stadt,
            'Apartment' => $apartment,
            'BrokerAptSlug'=>$brokerAptSlug,
            'DetailOptions'=>$this->ssArray($optionCounts),
            'isLoggedIn'=>GlobalHelper::isloggedin(),
            'LoginUser'=>$loginUser,
            'aptUserType'=>$memberBasicData->InseriereAls,
            'membershipData'=>$memberBasicData,
            'LoggedINSubscrptionStatus'=>GlobalHelper::getSubscriptionStatus(),
            'userType'=>GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType'),
            'company'=>$company
        ])->renderWith(['Layout/FrontApartmentView', 'Page']);
    }

    public function ssArray($roomCounts) {
        $output = ArrayList::create();
        foreach ($roomCounts as $rooms => $count) {
            $output->push(ArrayData::create([
                'Key' => $rooms,
                'Value' => $count
            ]));
        }
        return $output;
    }

    public function SecurityID(): string
    {
        return SecurityToken::inst()->getValue();
    }


    public function ajaxview(HTTPRequest $request)
    {
        // read filters (use your keys from data-name)
        $price = (int) $request->postVar('price');     // example
        $space = (int) $request->postVar('space');     // example
        $view = $request->postVar('view') ?: 'list'; // default
       // Checkbox array (Rooms[])
         $rooms = $request->postVar('Rooms');
         $locations = $request->postVar('Location'); // array of selected labels
         $equipment = $request->postVar('equipment'); // array of selected labels
// Get current page for pagination (default to 1)
$currentPage = max(1, (int) $request->postVar('page'));
        /** @var DataList $list */
        $list = Apartment::get()->filter('Status', 'published')->orderBy('Created', 'DESC');

        if ($price) {
            $priceInt = (int) $price;
        $upper    = number_format($priceInt + 0.99, 2, '.', ''); // "1847.99"
            // adapt to your schema (Price, Rent, etc.)
            $list = $list->filter('Details.Kaltmiete:LessThanOrEqual', $upper);
        }
        if ($space) {
            $list = $list->filter('Details.Wohnflache:LessThanOrEqual', $space);
        }
            // Rooms — when user picked specifics: IN (...) ; when "Egal": skip (no restriction)
    if (is_array($rooms) && !empty($rooms)) {
        // Adjust column name if needed; this assumes Details has field "Zimmer"
        $list = $list->filter('Details.Zimmer', array_map('intval', $rooms));
    }
    
    if (is_array($locations)) {
        // trim and remove empties (in case "Alle" sneaks in)
        $locations = array_values(array_filter(array_map('trim', $locations), fn($v) => $v !== ''));
        if ($locations) {
            // IN (…) with exact match across selected names
            $list = $list->filter('Address.Stadtteil', $locations);
        }
    }
    if (is_array($equipment)) {
        // trim and remove empties (in case "Alle" sneaks in)
        $equipment = array_values(array_filter(array_map('trim', $equipment), fn($v) => $v !== ''));
        if ($equipment) {
            // IN (…) with exact match across selected names
            $list = $list->filter('Details.DetailOptions.Label', $equipment);
        }
    }
$apartmentsPaginated = PaginatedList::create(
            $list,
            $request
        )->setPageLength(15)->setCurrentPage($currentPage);
        $hasMore = $apartmentsPaginated->TotalPages() > $apartmentsPaginated->CurrentPage();
        $response = $this->getResponse();

        // Set the content type header to JSON
        $response->addHeader('Content-Type', 'application/json');
        if ($view == 'map') {
            $softCap = 1000;
            $apartmentsForMap = $list
                ->exclude(['Address.Lat' => '', 'Address.Lng' => ''])
                ->limit($softCap);
    
            $html = $this->customise(['ApartmentsMap' => $apartmentsForMap])
                ->renderWith('Includes/PropertyListMap');
    
            return $response->setBody(json_encode([
                'html' => trim((string)$html),
                'hasMore' => false
            ]));
        } else {
            $html = $this->customise(['Apartments' => $apartmentsPaginated])
                ->renderWith('Includes/PropertyList');
    
            return $response->setBody(json_encode([
                'html' => trim((string)$html),
                'hasMore' => $hasMore
            ]));
        }
        // Render ONLY the include, pass Items param
       
    }

public function list(HTTPRequest $request){
  $brokerAptSlug=$request->param('ID');
  $isLoggedin=GlobalHelper::isloggedin();
 $memberLogin = GlobalHelper::getLoggedInUser();
  $MemberId=explode("-",$brokerAptSlug)[2];
  $apartments=Apartment::get()->filter('Status', 'published')->filter('MemberID',$MemberId);
  $showEdit='No';
  if($isLoggedin){
    if(in_array(GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType'),['broker','owner','seller']) && $memberLogin->ID == $MemberId){
      $showEdit='Yes';
    }
  }
  $contactIds=$apartments->column('ContactId');
   $contacts=RentalWorkerInformation::get()->filter('ID',$contactIds);
  $memberBasicData=MemberBasicData::get()->filter(['MemberID' => $MemberId])->first();
  if($memberBasicData->InseriereAls == 'broker'){
    $memberCompanyData=MemberCompanyData::get()->filter(['MemberID' => $MemberId])->first();
  }else{
    $memberCompanyData=PersonalInformation::get()->filter(['MemberID' => $MemberId])->first();
  }
  return $this->customise([
    'Title'=>$memberBasicData->FirstName.'-'.$memberBasicData->LastName.' - Wohnung',
    'Apartments' => $apartments,
    'MemberBasicData'=>$memberBasicData,
    'Company'=>$memberCompanyData,
    'Contacts'=>$contacts,
    'isLoggedin'=>$isLoggedin,
    'showEdit'=>$showEdit,
    'userType'=>GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType'),
    'listusertype'=>$memberBasicData->InseriereAls
  ])->renderWith('Layout/FrontApartmentListByBroker');
}
public function contact_apartment(HTTPRequest $request){
    if(!GlobalHelper::isloggedin()){
        return $this->redirect('/login');
    }
    if(GlobalHelper::getSubscriptionStatus()=='Inactive'){
        return $this->redirect('/renter-dashboard/subscription');
    }
 
    
  
    $loggedInUser=GlobalHelper::getLoggedInUser();
    $apartment=Apartment::get()->byID($request->param('ID'));
    $form = $this->profileForm($request,$apartment);
    $session = $this->getRequest()->getSession();
    $formSuccess = $session->get('FormSuccess');
    $errorMessage = $session->get('FormError');
    $session->clear('FormError');
    $session->clear('FormSuccess');
    $memberBasicData=MemberBasicData::get()->filter(['MemberID' => $apartment->MemberID])->first();
    if($memberBasicData->InseriereAls == 'broker'){
        $company=MemberCompanyData::get()->filter(['MemberID' => $apartment->MemberID])->first();
    }else{
        $company=PersonalInformation::get()->filter(['MemberID' => $apartment->MemberID])->first();
    }
    
    $contacts=RentalWorkerInformation::get()->filter('ID',$apartment->ContactId);
    return $this->customise([
        'Title'=>'Contact Apartment',
        'FormError' => $errorMessage,
            'FormSuccess' => $formSuccess,
            'Form' => $form,
        'Apartment' => $apartment,
        'Contacts'=>$contacts,
        'Company'=>$company,
        'MemberBasicData'=>$memberBasicData,
        'MemberID'=>$form->Fields()->dataFieldByName('MemberID'),
        'ApartmentID'=>$form->Fields()->dataFieldByName('ApartmentID'),
        'FirstName' => $form->Fields()->dataFieldByName('FirstName'),
        'LastName' => $form->Fields()->dataFieldByName('LastName'),
        'CountryCode' => $form->Fields()->dataFieldByName('CountryCode'),
        'Telefon' => $form->Fields()->dataFieldByName('Telefon'),
        'Email' => $form->Fields()->dataFieldByName('Email'),
        'Description' => $form->Fields()->dataFieldByName('Description'),
        'Stadtteil' => $form->Fields()->dataFieldByName('Stadtteil'),
        'CreditCheck' => $form->Fields()->dataFieldByName('CreditCheck'),
        'Preis' => $form->Fields()->dataFieldByName('Preis'),
        'Wohnungflache' => $form->Fields()->dataFieldByName('Wohnungflache'),
        'lookingfor' => $form->Fields()->dataFieldByName('lookingfor'),
        'Wohnberechtigungsschein' => $form->Fields()->dataFieldByName('Wohnberechtigungsschein'),
        'Heizungsart' => $form->Fields()->dataFieldByName('Heizungsart'),
        'Erwachsene'=>$form->Fields()->dataFieldByName('Erwachsene'),
        'Kinder'=>$form->Fields()->dataFieldByName('Kinder'),
        'HouseholdIncome'=>$form->Fields()->dataFieldByName('HouseholdIncome'),
        'Zimmer'=>$form->Fields()->dataFieldByName('Zimmer'),
    ])->renderWith('Layout/Broker/Apartment/Contact');

}

public function profileForm($request,$apartment){
   
    $loggedInUser=GlobalHelper::getLoggedInUser();
    if(GlobalHelper::getCurrentUserSession($request)->get('UserType') == 'broker' || GlobalHelper::getCurrentUserSession($request)->get('UserType') == 'owner' || GlobalHelper::getCurrentUserSession($request)->get('UserType') == 'seller'){
        $profile=MemberBasicData::get()->filter(['MemberID' => $loggedInUser->ID])->first();
      
       }else{
           $profile=PersonalInformation::get()->filter(['MemberID' => $loggedInUser->ID])->first();
       }
       if ($profile) {
        $profileData = $profile->toMap();
        
    }
    $fields = FieldList::create(
        HiddenField::create('MemberID', 'MemberID')->setValue($loggedInUser->ID),
        HiddenField::create('ApartmentID', 'ApartmentID')->setValue($request->param('ID')),
        TextField::create('FirstName', 'Name*')->setValue($profileData['FirstName'] ?? '')->setAttribute('readonly', 'readonly'),
        TextField::create('LastName', 'Nachname*')->setValue($profileData['LastName'] ?? '')->setAttribute('readonly', 'readonly'),
        DropdownField::create('CountryCode', 'Country Code', [
            '+49' => 'Deutschland (+49)',
            '+43' => 'Österreich (+43)',
            '+41' => 'Schweiz (+41)'
        ])->setValue('+49')->setEmptyString('Ländervorwahl auswählen*')->setValue($profileData['CountryCode'])->setAttribute('disabled', 'disabled'),
        TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setValue($profileData['Telefon'])->setAttribute('readonly', 'readonly'),
        EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*')->setValue($profileData['Email'])->setAttribute('readonly', 'readonly'),
        TextareaField::create('Description', 'Company Description')->setAttribute('placeholder', '')->setAttribute('class', 'char-count')->setAttribute('maxlength', 2000)->setAttribute('data-maxlength', 2000),
        DropdownField::create('Stadtteil', 'Stadtteil',[
            'Spandau' => 'Spandau',
            'Neukölln' => 'Neukölln',
            'Zehlendorf' => 'Zehlendorf',
            'Charlottenburg' => 'Charlottenburg',
            'Berlin Mitte' => 'Berlin Mitte',
            'Pankow' => 'Pankow',
            'Prenzlauer Berg' => 'Prenzlauer Berg',
            'Steglitz' => 'Steglitz',
            'Lichtenrade' => 'Lichtenrade',
            'Tegel' => 'Tegel',
            'Kreuzberg' => 'Kreuzberg',
            'Blankenburg' => 'Blankenburg',
            'Kladow' => 'Kladow',
            'Frohnau' => 'Frohnau',
        ])->setTitle('Stadtteil')->setValue($apartment->Address->Stadtteil)->setEmptyString('Stadtteil'),
        OptionsetField::create('CreditCheck', 'SCHUFA - BonitätsCheck', [
            'Ja' => 'Ja',
            'Nein' => 'Nein',
        ])->addExtraClass('radio_group'),
        TextField::create('Preis', 'Preis')->setValue($apartment->Details->Kaltmiete ?? '')->setTitle('Preis'),
        TextField::create('Wohnungflache', 'Wohnungfläche')->setValue($apartment->Details->Wohnflache ?? '')->setTitle('Wohnungfläche'),
        TextField::create('lookingfor', 'Was suchen sie?')->setTitle('Was suchen sie?'),
        TextField::create('Wohnberechtigungsschein', 'Wohnberechtigungsschein')->setValue($apartment->Details->Wohnberechtigungsschein ?? '')->setTitle('Wohnberechtigungsschein'),
        TextField::create('Heizungsart', 'Heizungsart')->setValue($apartment->Details->Heizungsart ?? '')->setTitle('Heizungsart'),
        TextField::create('Erwachsene', 'Erwachsene')->setValue($apartment->Details->Erwachsene ?? '')->setTitle('Erwachsene'),
        TextField::create('Kinder', 'Kinder')->setValue($apartment->Details->Kinder ?? '')->setTitle('Kinder'),
        TextField::create('HouseholdIncome', 'Netto Haushaltseinkommen')->setTitle('Netto Haushaltseinkommen'),
        DropdownField::create('Zimmer', 'Zimmer',[1,2,3,4,'5 und mehr'])->setValue($apartment->Details->Zimmer ?? '')->setTitle('Zimmer')->setEmptyString('Zimmer auswählen'),
    );
    $actions = FieldList::create(
        FormAction::create('doContactProperty', 'Steuern')
    );
    $validator = RequiredFields::create(['FirstName', 'LastName', 'CountryCode', 'Telefon', 'Email','Description','HouseholdIncome','Stadtteil']);
    $form = Form::create($this, 'ContactPropertyForm', $fields, $actions, $validator);
    $form->setFormAction('/front-apartment/doContactProperty');
    return $form;
}

public function doContactProperty(HTTPRequest $request){
    $data = $request->postVars();
    if (!$member = Security::getCurrentUser()) {
        return $this->redirect('/login');
    }
    $session = $request->getSession();
    $session->set('PropertyApplication', $data);
    $apartment = Apartment::get()->byID($data['ApartmentID']);
    $application = ApartmentApplication::create();
   
    $application->MemberID = $member->ID;
    $application->ListerID = $apartment->MemberID;
    $application->ApartmentID = $data['ApartmentID'];
    $application->Description = $data['Description'];
    $application->Stadtteil = $data['Stadtteil'];
    $application->CreditCheck = $data['CreditCheck'];
    $application->Price = $data['Preis'];
    $application->Wohnungflache = $data['Wohnungflache'];
    $application->Zimmer = $data['Zimmer'];
    $application->lookingfor = $data['lookingfor'];
    $application->Wohnberechtigungsschein = $data['Wohnberechtigungsschein'];
    $application->Heizungsart = $data['Heizungsart'];
    $application->Erwachsene = $data['Erwachsene'];
    $application->Kinder = $data['Kinder'];
    $application->HouseholdIncome = $data['HouseholdIncome'];
    $application->write();
    return $this->redirect('/front-apartment/previewapplicant');
}

public function addtowishlist(HTTPRequest $request){
    $objectID = $request->postVar('objectID');
    $securityID = $request->postVar('SecurityID');
    $memberID=GlobalHelper::getLoggedInUser()->ID;
    $wishlist = ApartmentWishlist::get()->filter('MemberID', $memberID)->filter('ApartmentID', $objectID)->first();
    if (!$wishlist) {
        $wishlist = ApartmentWishlist::create();
        $wishlist->MemberID = $memberID;
        $wishlist->ApartmentID = $objectID;
        $wishlist->write();

        return RestApiHelper::jsonOk([
            'ok' => true,
            'message' => 'Apartment added to wishlist',
            'action'=>'add'
            ]);
    }else
    {
        $wishlist->delete();
        return RestApiHelper::jsonOk([
            'ok' => true,
            'message' => 'Apartment removed from wishlist',
            'action'=>'remove'
            ]);
    }
   
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Apartment already in wishlist',
    ]);
}
public function previewapplicant(){
    if(!GlobalHelper::isloggedin()){
        return $this->redirect('/login');
    }
    $session = $this->getRequest()->getSession();
    $loggedInUser=GlobalHelper::getLoggedInUser();
    if(!$session->get('PropertyApplication')){
        return $this->redirect('/stadtteile-berlins');
    }
    $data = $session->get('PropertyApplication');
    $dataObject = ArrayData::create($data);
    $dashboard='/dashboard';
    if(GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'renter'){
        $dashboard='/renter-dashboard';
    }
    $session->clear('PropertyApplication');
    return $this->renderWith('Layout/Broker/Apartment/PreviewApplicant', ['data' => $dataObject,'dashboardurl'=>$dashboard]);
}

public function storesearch(HTTPRequest $request){
    
    $isLoggedin=GlobalHelper::isloggedin();
    if(!$isLoggedin){
        return RestApiHelper::jsonOk([
            'ok' => true,
            'message' => 'Login to save search',
        ]);
    }
   // read filters (use your keys from data-name)
   $price = (int) $request->postVar('price');     // example
   $space = (int) $request->postVar('space');     // example
  // Checkbox array (Rooms[])
    $rooms = $request->postVar('Rooms');
    $locations = $request->postVar('Location'); // array of selected labels
    $equipment = $request->postVar('equipment'); // array of selected labels
    $memberSearchSettings=MemberSearchSetting::get()->filter('MemberID', GlobalHelper::getLoggedInUser()->ID)->first();
    if($memberSearchSettings){
        $memberSearchSettings->Price=$price;
        $memberSearchSettings->Space=$space;
        $memberSearchSettings->Rooms=json_encode($rooms);
        $memberSearchSettings->Locations=json_encode($locations);
        $memberSearchSettings->Equipment=json_encode($equipment);
        $memberSearchSettings->write();
    }else{
        $memberSearchSettings=MemberSearchSetting::create();
        $memberSearchSettings->MemberID=GlobalHelper::getLoggedInUser()->ID;
        $memberSearchSettings->Price=$price;
        $memberSearchSettings->Space=$space;
        $memberSearchSettings->Rooms=json_encode($rooms);
        $memberSearchSettings->Locations=json_encode($locations);
        $memberSearchSettings->Equipment=json_encode($equipment);
        $memberSearchSettings->write();
    }
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Search saved',
    ]);
}

}