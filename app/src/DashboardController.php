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
use SilverStripe\Forms\DateField;
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
use SilverStripe\Assets\Image;
use SilverStripe\Control\Session;
use SilverStripe\Assets\Upload;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Subsites\Model\Subsite;
use SilverStripe\Assets\File;
use App\Helper\GlobalHelper;
use App\Helper\RestApiHelper;
use App\Model\MemberCompanyData;
use App\Model\MemberBasicData;
use App\Model\RentalWorkerInformation;
use App\Model\Apartment;
use App\Model\ApartmentDetail;
use App\Model\ApartmentAddress;
use App\Model\ApartmentApplication;
use App\Model\PersonalInformation;
use SilverStripe\ORM\DB;
class DashboardController extends ContentController
{
    private static $allowed_actions = [
        'index', 'info','deleteFileImg','guide','uploadFile','subscription','payment_discount','payment_method', 'updateinfo', 'brokercontacts', 'UpdateCompanyForm', 'doUpdateCompany', 'Addworker', 'AddWorkerForm', 'doAddWorker', 'Addworkerimage', 'AddWorkerImageForm', 'doAddWorkerImage', 'Editworker', 'doSaveWorker', 'Brokerdata', 'Brokerapartments', 'Tips','applications','application_detail','doUpdateOwner','remove_apartment','change_apartment_status','anhalten','delete_account'
    ];

    private static $url_segment = 'dashboard';

    protected function init()
    {
        parent::init();

        // Check login status
        if (!Security::getCurrentUser()) {
            return $this->redirect('/login');
        }
        if(GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'renter'){
            return $this->redirect('/renter-dashboard');
        }
    }

    public function index(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $InseriereAls = $request->getSession()->get('UserType');
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');
        

        if ($member) {
            if($InseriereAls == 'broker' || $InseriereAls == 'owner' || $InseriereAls == 'seller'){
                return $this->customise([
                    'Title' => 'Dashboard',
                    'Name' => $firstName.' '.$lastName,
                    'User' => $member,
                ])->renderWith(['Layout/DashboardBroker', 'Page']);
            }else{
                return $this->redirect('/renter-dashboard');
            }
        }else{
            return $this->redirect('/login');
        }
    }

    public function info(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');
        $company=MemberCompanyData::get()->filter('MemberID', $member->ID)->first();
        $personalInformation=[];
        if(GlobalHelper::getCurrentUserSession($request)->get('UserType') == 'owner' || GlobalHelper::getCurrentUserSession($request)->get('UserType') == 'seller'){
            $personalInformation=PersonalInformation::get()->filter('MemberID', $member->ID)->first();
        }
        $memberBasicData=MemberBasicData::get()->filter(['MemberID' => $member->ID])->first();
        $brokerAptSlug=strtolower($memberBasicData->FirstName).'-'.strtolower($memberBasicData->LastName).'-'.$member->ID;
        if ($member) {
            return $this->customise([
                'Title' => 'Informationen',
                'Name' => $firstName.' '.$lastName,
                'User' => $member,
                'Company' => $company,
                'BrokerAptSlug'=>$brokerAptSlug,
                'userType'=>GlobalHelper::getCurrentUserSession($request)->get('UserType'),
                'PersonalInformation'=>$personalInformation,
            ])->renderWith(['Layout/Broker/Info', 'Page']);
        }else{
            return $this->redirect('/login');
        }
    }

    public function updateinfo(HTTPRequest $request){
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');

        

        $session = $this->getRequest()->getSession();
        $formSuccess = $session->get('FormSuccess');
        $errorMessage = $session->get('FormError');
        
        $session->clear('FormError');
        $session->clear('FormSuccess');
        $member = Security::getCurrentUser();
        if(GlobalHelper::getCurrentUserSession($request)->get('UserType') == 'broker'){
            $form = $this->UpdateCompanyForm();
        $company = MemberCompanyData::get()
            ->filter('MemberID', $member->ID)
            ->first();
        return $this->customise([
            'Title' => 'Broker-Informationen',
            'Name' => $firstName.' '.$lastName,
            'FormError' => $errorMessage,
            'FormSuccess' => $formSuccess,
            'Form' => $form,
            'MemberID' => $form->Fields()->dataFieldByName('MemberID'),
            'Firmaname' => $form->Fields()->dataFieldByName('Firmaname'),
            'HRBHRA' => $form->Fields()->dataFieldByName('HRBHRA'),
            'Strabe' => $form->Fields()->dataFieldByName('Strabe'),
            'Bilder' => $form->Fields()->dataFieldByName('Bilder'),
            'Nr' => $form->Fields()->dataFieldByName('Nr'),
            'Plz' => $form->Fields()->dataFieldByName('Plz'),
            'Ort' => $form->Fields()->dataFieldByName('Ort'),
            'Land' => $form->Fields()->dataFieldByName('Land'),
            'CountryCode' => $form->Fields()->dataFieldByName('CountryCode'),
            'Telefon' => $form->Fields()->dataFieldByName('Telefon'),
            'Email' => $form->Fields()->dataFieldByName('Email'),
            'Website' => $form->Fields()->dataFieldByName('Website'),
            'Fax' => $form->Fields()->dataFieldByName('Fax'),
            'Description' => $form->Fields()->dataFieldByName('Description'),
            'Company'     => $company,
        ])->renderWith(['Layout/Broker/UpdateInfo', 'Page']);
        }else if(GlobalHelper::getCurrentUserSession($request)->get('UserType') == 'owner' || GlobalHelper::getCurrentUserSession($request)->get('UserType') == 'seller'){
            $form = $this->UpdateOwnerForm();
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
        ])->renderWith(['Layout/Owner/UpdateInfo', 'Page']);
        }
    }

    public function UpdateOwnerForm()
    {
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
            DateField::create('Geburtsdatum', 'Geburtsdatum')->setValue($companyData['Geburtsdatum'] ?? '')->setHTML5(true),
            TextField::create('Plz', 'PLZ')->setValue($companyData['Plz'] ?? '')->setAttribute('pattern', '^[0-9]{5}$')
    ->setAttribute('maxlength', '5')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')"),
            TextField::create('Ort', 'Ort')->setValue($companyData['Ort'] ?? ''),
            DropdownField::create('Land', 'Land', [
                'Deutschland' => 'Deutschland',
                'Österreich' => 'Österreich',
                'Schweiz' => 'Schweiz',
                'Germany'=>'Germany'
            ])->setValue($companyData['Land'] ?? ''),
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
            FormAction::create('doUpdateOwner', 'zur Bestätigung')
        );

        $validator = RequiredFields::create(['FirstName', 'LastName', 'Strabe', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'UpdateOwnerForm', $fields, $actions, $validator);
        $form->setFormAction('/dashboard/doUpdateOwner');
        return $form;
    }

    public function UpdateCompanyForm(){
        
        $member = Security::getCurrentUser();

        $records = MemberCompanyData::get()
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
            TextField::create('Firmaname', 'Firmaname')->setAttribute('placeholder', 'Firmaname*')->setValue($companyData['Firmaname'] ?? ''),
            TextField::create('HRBHRA', 'HRB / HRA')->setAttribute('placeholder', 'HRB / HRA*')->setValue($companyData['HRBHRA'] ?? ''),
            TextField::create('Strabe', 'Strabe*')->setValue($companyData['Strabe'] ?? ''),
            TextField::create('Nr', 'Nr')->setValue($companyData['Nr'] ?? ''),
            TextField::create('Plz', 'PLZ')->setValue($companyData['Plz'] ?? '')->setAttribute('pattern', '^[0-9]{5}$')
    ->setAttribute('maxlength', '5')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')"),
            TextField::create('Ort', 'Ort')->setValue($companyData['Ort'] ?? ''),
            DropdownField::create('Land', 'Land', [
                'Deutschland' => 'Deutschland',
                'Österreich' => 'Österreich',
                'Schweiz' => 'Schweiz',
                'Germany'=>'Germany'
            ])->setValue($companyData['Land'] ?? ''),
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setValue('+49')->setEmptyString('Ländervorwahl auswählen*')->setValue($companyData['CountryCode'] ?? ''),
            TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setValue($companyData['Telefon'] ?? '')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*')->setValue($companyData['Email'] ?? ''),
            UrlField::create('Website', 'Website')->setAttribute('placeholder', 'Website')->setValue($companyData['Website'] ?? '')->setAttribute('type', 'url')               // HTML5 browser validation
            ->setAttribute('inputmode', 'url')
            ->setAttribute('pattern', 'https?://.*'),
            TextField::create('Fax', 'Fax')->setValue($companyData['Fax'] ?? ''),
            TextareaField::create('Description', 'Company Description')->setAttribute('maxlength', 500)->setAttribute('data-maxlength', 500)->setAttribute('class', 'char-count')->setAttribute('placeholder', '')->addExtraClass('short_content')->setValue($companyData['Description'] ?? ''),
        );

        $actions = FieldList::create(
            FormAction::create('doUpdateCompany', 'zur Bestätigung')
        );

        $validator = RequiredFields::create(['Firmaname', 'HRBHRA', 'Address', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'UpdateCompanyForm', $fields, $actions, $validator);
        $form->setFormAction('/dashboard/doUpdateCompany');
        return $form;
    }

    public function doUpdateOwner(HTTPRequest $request){
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
        return $this->redirect('/dashboard/updateinfo');
    }
        

    public function doUpdateCompany(HTTPRequest $request){
        $data = $request->postVars();

        $companyData = MemberCompanyData::get()
            ->filter('MemberID', $data['MemberID'])
            ->first();

        if (!$companyData) {
            $companyData = new MemberCompanyData();
            $companyData->MemberID = $data['MemberID'];
        }

        foreach ($data as $key => $value) {
            if ($companyData->hasField($key)) {
                $companyData->$key = $value;
            }
        }
        if ($img = $this->attachImageFromFiles('Bilder', 'profiles')) {
            $img->publishSingle();
            // set the correct relation column you have:
            if ($companyData->hasField('ImageID'))  $companyData->ImageID  = $img->ID;
           
        }
        $companyData->write();

        $this->getRequest()->getSession()->set('FormSuccess', 'Ihre Daten wurden erfolgreich aktualisiert.');
        return $this->redirect('/dashboard/updateinfo');
    }

    public function brokercontacts(HTTPRequest $request){
        if(GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'owner' || GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'seller'){
            return $this->redirect('/dashboard');
        }
        $session = $this->getRequest()->getSession();
        $formSuccess = $session->get('FormSuccess');
        $errorMessage = $session->get('FormError');
        $form=$this->AddWorkerFormModal();
        $session->clear('FormError');
        $session->clear('FormSuccess');

        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');
     
        return $this->customise([
            'Title' => 'Selbstauskunft',
            'FormError' => $errorMessage,
            'FormSuccess' => $formSuccess,
            'Name' => $firstName.' '.$lastName,
            'Form' => $form,
            'WorkerID' => $form->Fields()->dataFieldByName('WorkerID'),
            'Anrede' => $form->Fields()->dataFieldByName('Anrede'),
            'Titel' => $form->Fields()->dataFieldByName('Titel'),
            'Vorname' => $form->Fields()->dataFieldByName('FirstName'),
            'Nachname' => $form->Fields()->dataFieldByName('LastName'),
            'CountryCode' => $form->Fields()->dataFieldByName('CountryCode'),
            'Telefon' => $form->Fields()->dataFieldByName('Telefon'),
            'Email' => $form->Fields()->dataFieldByName('Email'),
            'ZusaEmail' => $form->Fields()->dataFieldByName('ZusaEmail'),
            'PositionUnterneehmen' => $form->Fields()->dataFieldByName('PositionUnterneehmen'),
            'Mobile' => $form->Fields()->dataFieldByName('Mobile'),
            'Fax' => $form->Fields()->dataFieldByName('Fax'),
            'StandaardContact' => $form->Fields()->dataFieldByName('StandaardContact'),
            'Description' => $form->Fields()->dataFieldByName('Description'),
            'Image' => $form->Fields()->dataFieldByName('Image')
        ])->renderWith(['Layout/Broker/Contacts', 'Page']);
    }

    public function Addworker(HTTPRequest $request){
        $form = $this->AddWorkerForm();
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');

        return $this->customise([
            'Title' => 'Miet arbeiter angaben',
            'Name' => $firstName.' '.$lastName,
            'Form' => $form,
            'WorkerID' => $form->Fields()->dataFieldByName('WorkerID'),
            'Anrede' => $form->Fields()->dataFieldByName('Anrede'),
            'Titel' => $form->Fields()->dataFieldByName('Titel'),
            'Vorname' => $form->Fields()->dataFieldByName('FirstName'),
            'Nachname' => $form->Fields()->dataFieldByName('LastName'),
            'CountryCode' => $form->Fields()->dataFieldByName('CountryCode'),
            'Telefon' => $form->Fields()->dataFieldByName('Telefon'),
            'Email' => $form->Fields()->dataFieldByName('Email'),
            'ZusaEmail' => $form->Fields()->dataFieldByName('ZusaEmail'),
            'PositionUnterneehmen' => $form->Fields()->dataFieldByName('PositionUnterneehmen'),
            'Mobile' => $form->Fields()->dataFieldByName('Mobile'),
            'Fax' => $form->Fields()->dataFieldByName('Fax'),
            'StandaardContact' => $form->Fields()->dataFieldByName('StandaardContact')
        ])->renderWith(['Layout/Broker/Addworker', 'Page']);
    }

    public function AddWorkerForm(){
        $id = $this->getRequest()->param('ID');
        $worker = RentalWorkerInformation::get()->byID($id);
        $fields = FieldList::create([
            HiddenField::create('WorkerID', 'WorkerID')->setValue($id),
            OptionsetField::create('Anrede', 'Anrede*', [
                    'Herr' => 'Herr',
                    'Frau' => 'Frau',
                    'Ansonsten' => 'Ansonsten',
                ]
            )->addExtraClass('radio_group'),

            TextField::create('Titel', 'Titel')->setAttribute('placeholder', 'Titel*'),
            TextField::create('FirstName', 'Vorname')->setAttribute('placeholder', 'Vorname*'),
            TextField::create('LastName', 'Nachname')->setAttribute('placeholder', 'Nachname'),
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setEmptyString('Ländervorwahl auswählen*'),
            TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*'),
            EmailField::create('ZusaEmail', 'Zusatizliche mailadresse')->setAttribute('placeholder', 'Zusatizliche mailadresse'),
            TextField::create('PositionUnterneehmen', 'Position Unterneehmen')->setAttribute('placeholder', 'Position Unterneehmen'),
            TextField::create('Mobile', 'Mobiel')->setAttribute('placeholder', 'Mobiel')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            TextField::create('Fax', 'Fax')->setAttribute('placeholder', 'Fax'),
            OptionsetField::create('StandaardContact', '', [
                '1' => 'Standaard Contact'
            ])->addExtraClass('radio_group'),
        ]);

        $actions = FieldList::create([
            FormAction::create('doSaveWorker', 'Speichern')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Anrede', 'Titel', 'FirstName', 'LastName', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'AddWorkerForm', $fields, $actions, $validator);

        $form->setFormAction('/dashboard/doSaveWorker');

        return $form;
    }

    public function AddWorkerFormModal(){
      
        $fields = FieldList::create([
            HiddenField::create('WorkerID', 'WorkerID')->setValue(0),
            OptionsetField::create('Anrede', 'Anrede*', [
                    'Herr' => 'Herr',
                    'Frau' => 'Frau',
                    'Ansonsten' => 'Ansonsten',
                ]
            )->addExtraClass('radio_group'),

            TextField::create('Titel', 'Titel')->setAttribute('placeholder', 'Titel*'),
            TextField::create('FirstName', 'Vorname')->setAttribute('placeholder', 'Vorname*'),
            TextField::create('LastName', 'Nachname')->setAttribute('placeholder', 'Nachname'),
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setEmptyString('Ländervorwahl auswählen*'),
            TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*'),
            EmailField::create('ZusaEmail', 'Zusatizliche mailadresse')->setAttribute('placeholder', 'Zusatizliche mailadresse'),
            TextField::create('PositionUnterneehmen', 'Position Unterneehmen')->setAttribute('placeholder', 'Position Unterneehmen'),
            TextField::create('Mobile', 'Mobiel')->setAttribute('placeholder', 'Mobiel')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            TextField::create('Fax', 'Fax')->setAttribute('placeholder', 'Fax'),
            FileField::create('Image', 'Upload Image')
                ->setAllowedExtensions(['jpg', 'jpeg', 'png'])
                ->setAttribute('id', 'ImageIDInput')
                ->setAttribute('class','inputFileHidden')
                ->setAttribute('accept', 'image/jpeg, image/png'),
            OptionsetField::create('StandaardContact', '', [
                '1' => 'Standaard Contact'
            ])->addExtraClass('radio_group'),
            TextareaField::create('Description', 'Company Description')->setAttribute('placeholder', '')->addExtraClass('short_content'),
        ]);

        $actions = FieldList::create([
            FormAction::create('doSaveWorker', 'Speichern')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Anrede', 'Titel', 'FirstName', 'LastName', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'AddWorkerForm', $fields, $actions, $validator);

        $form->setFormAction('/dashboard/doSaveWorker');

        return $form;
    }

    public function doAddWorker(HTTPRequest $request){
        $data = $request->postVars();
        $this->getRequest()->getSession()->set('WorkerData', array_merge(
            $this->getRequest()->getSession()->get('WorkerData') ?: [],
            $data
        ));
        return $this->redirect('/dashboard/addworkerimage');
    }

    public function Addworkerimage(){
        $form = $this->AddWorkerImageForm();

        return $this->customise([
            'Title' => 'Miet arbeiter Angaben',
            'Form' => $form,
            'Foto' => $form->Fields()->dataFieldByName('Foto'),
            'Description' => $form->Fields()->dataFieldByName('Description')
        ])->renderWith(['Layout/Broker/AddWorkerImageForm', 'Page']);
    }

    public function AddWorkerImageForm(){
        $fields = FieldList::create(
            UploadField::create('Foto', 'Upload Image')
                ->setAllowedExtensions(['jpg', 'jpeg', 'png'])
                ->setAttribute('id', 'fileUpload')
                ->setAttribute('accept', 'image/jpeg, image/png')
                ->setAttribute('style', 'display:none;'),
            TextareaField::create('Description', 'Description')->setAttribute('maxlength', 2000)->setAttribute('data-maxlength', 2000)->setAttribute('class', 'char-count')
        );

        $actions = FieldList::create(
            FormAction::create('doAddWorkerImage', 'zur Bestatigung')->addExtraClass('btn btn-primary')
        );

        $validator = RequiredFields::create(['Image', 'Description']);

        $form = Form::create($this, 'AddWorkerImageForm', $fields, $actions, $validator);

        $form->setFormAction('/dashboard/doAddWorkerImage');

        return $form;
    }

    public function doAddWorkerImage(HTTPRequest $request){
        $data = $request->postVars();
        $session = $this->getRequest()->getSession();

        $allData = array_merge(
            $session->get('WorkerData') ?: [],
            $data
        );

        $member = Security::getCurrentUser();
        $memberID = $member->ID;

        if ($memberID) {

            $rentalInfo = new RentalWorkerInformation();
            $rentalInfo->MemberID = $memberID;
            
            foreach ($allData as $key => $value) {
                if ($rentalInfo->hasField($key)) {
                    $rentalInfo->$key = $value;
                }
            }

            if (!empty($data['Image'])) {
                $rentalInfo->ImageID = $data['Image'];
            }

            $rentalInfo->write();
        }

        $session->clear('WorkerData');
        $this->getRequest()->getSession()->set('FormSuccess', 'Details zum Leiharbeiter wurden erfolgreich hinzugefügt.');
        return $this->redirect('/dashboard/brokercontacts/');
    }

    public function getWorkerInformationByMember(){
        $member = Security::getCurrentUser();
        $memberID = $member->ID;

        return RentalWorkerInformation::get()
            ->filter('MemberID', $memberID)
            ->sort('ID', 'ASC');
    }

    public function Editworker(HTTPRequest $request){
        $id = (int)$request->param('ID');
        $worker = RentalWorkerInformation::get()->byID($id);

        if (!$worker) {
            return $this->httpError(404, 'Worker not found');
        }

        $form = $this->AddWorkerForm()->loadDataFrom($worker);

        return $this->customise([
            'Title' => 'Miet arbeiter bearbeiten',
            'Form' => $form,
            'WorkerID' => $form->Fields()->dataFieldByName('WorkerID'),
            'Anrede' => $form->Fields()->dataFieldByName('Anrede'),
            'Titel' => $form->Fields()->dataFieldByName('Titel'),
            'Vorname' => $form->Fields()->dataFieldByName('FirstName'),
            'Nachname' => $form->Fields()->dataFieldByName('LastName'),
            'CountryCode' => $form->Fields()->dataFieldByName('CountryCode'),
            'Telefon' => $form->Fields()->dataFieldByName('Telefon'),
            'Email' => $form->Fields()->dataFieldByName('Email'),
            'ZusaEmail' => $form->Fields()->dataFieldByName('ZusaEmail'),
            'PositionUnterneehmen' => $form->Fields()->dataFieldByName('PositionUnterneehmen'),
            'Mobile' => $form->Fields()->dataFieldByName('Mobile'),
            'Fax' => $form->Fields()->dataFieldByName('Fax'),
            'StandaardContact' => $form->Fields()->dataFieldByName('StandaardContact')
        ])->renderWith(['Layout/Broker/Addworker', 'Page']);
    }

    public function doSaveWorker(HTTPRequest $request){
        $data = $request->postVars();
        $member = Security::getCurrentUser();

        if (!$member) {
            return $this->redirectBack();
        }

        if (!empty($data['WorkerID']) && is_numeric($data['WorkerID']) && $data['WorkerID']>0) {
            $worker = RentalWorkerInformation::get()->byID($data['WorkerID']);
            if (!$worker) {
                return $this->httpError(404, 'Worker not found');
            }
        } else {
            $worker = RentalWorkerInformation::create();
            $worker->MemberID = $member->ID;
        }

        foreach ($data as $key => $value) {
            if ($worker->hasField($key)) {
                $worker->$key = $value;
            }
        }
        if($data['AjaxFileUploadId'] && is_numeric($data['AjaxFileUploadId']) && $data['AjaxFileUploadId']>0)
        {
            if ($worker->hasField('ImageID'))  $worker->ImageID  = $data['AjaxFileUploadId'];
        }
        else
        {
         if ($img = $this->attachImageFromFiles('Image', 'profiles')) {
            $img->publishSingle();
            // set the correct relation column you have:
            if ($worker->hasField('ImageID'))  $worker->ImageID  = $img->ID;
           
        }
        }
        $worker->write();

        $this->getRequest()->getSession()->set('FormSuccess', 'Details zum Leiharbeiter wurden erfolgreich aktualisiert.');
        return $this->redirect('/dashboard/brokercontacts/');
    }

    public function Brokerdata(HTTPRequest $request){

        $member = Security::getCurrentUser();

        $records = MemberCompanyData::get()
            ->filter('MemberID', $member->ID)
            ->first();

        if ($records) {
            $companyData = $records->toMap();
        }
        
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');

        return $this->customise([
            'Title' => 'Broker Data',
            'Name' => $firstName.' '.$lastName,
            'Email' => $companyData['Email'],
            'Telefon' => $companyData['CountryCode'].' '.$companyData['Telefon'],
            'Adresse' => $companyData['Strabe'] . ' ' . $companyData['Nr'] . ' ' . $companyData['Plz'] . ' ' . $companyData['Ort'] . ' ' . $companyData['Land'],
            'Description' => $companyData['Description'],
        ])->renderWith(['Layout/Broker/BrokerData', 'Page']);
    }

    public function Brokerapartments(HTTPRequest $request){
        $ApartmentFlashMessage = $request->getSession()->get('ApartmentFlashMessage');
        $request->getSession()->clear('ApartmentFlashMessage');
        $member = Security::getCurrentUser();

        $records = MemberCompanyData::get()
            ->filter('MemberID', $member->ID)
            ->first();

        if ($records) {
            $companyData = $records->toMap();
        }
        $sort=$request->getVar('Sort') ? $request->getVar('Sort') : '';
        $search=$request->getVar('s') ? $request->getVar('s') : '';
        $apartments=Apartment::get()->filter('MemberID', $member->ID);
        if ($search && !empty($search)) {
            // Create an OR filter group to search multiple fields
            $filters = [
                'Uberschrift:PartialMatch' => $search,
                'Mietwohnung:PartialMatch' => $search,
                'Dieumgebung:PartialMatch' => $search,
                'Address.Street:PartialMatch' => $search,
                'Address.StrasseundHausnummer:PartialMatch' => $search,
                'Address.Stadt:PartialMatch' => $search,
                'Address.Stadtteil:PartialMatch' => $search,
                'Address.Nr:PartialMatch' => $search,
                'Address.Plz:PartialMatch' => $search,
                'Address.Ort:PartialMatch' => $search,
            ];
        
            $apartments = $apartments->filterAny($filters);
        }
        if($sort && !empty($sort)){
            if($sort=='Popularity'){
                $apartments=$apartments->sort('ViewCount', 'DESC');
            }else if($sort=='PriceLowToHigh'){
                $apartments=$apartments->sort('Details.Kaltmiete', 'ASC');
            }else if($sort=='PriceHighToLow'){
                $apartments=$apartments->sort('Details.Kaltmiete', 'DESC');
            }else if($sort=='Date'){
                $apartments=$apartments->sort('Created', 'DESC');
            }else if($sort=='Size'){
                $apartments=$apartments->sort('Details.Wohnflache', 'DESC');
            }
        }else{
            $apartments=$apartments->sort('Created', 'DESC');
        }
        $firstName = $request->getSession()->get('CUFirstName');
        $lastName = $request->getSession()->get('CULastName');

        return $this->customise([
            'Title' => 'Alle Ihre wohnungen',
            'Name' => $firstName.' '.$lastName,
            'ApartmentFlashMessage' => $ApartmentFlashMessage,
            'Apartments' => $apartments,
            'Sort' => $sort,
            'Search' => $search,
        ])->renderWith(['Layout/Broker/BrokerApartments', 'Page']);
    }

    public function Tips(HTTPRequest $request){

            $member = Security::getCurrentUser();

            $records = MemberCompanyData::get()
                ->filter('MemberID', $member->ID)
                ->first();

            if ($records) {
                $companyData = $records->toMap();
            }
            
            $firstName = $request->getSession()->get('CUFirstName');
            $lastName = $request->getSession()->get('CULastName');

            return $this->customise([
                'Title' => 'Tips',
                'Name' => $firstName.' '.$lastName,
            ])->renderWith(['Layout/Broker/BrokerTips', 'Page']);
        }
private function attachImageFromFiles(string $field = 'Bilder', string $folder = 'profiles'): ?Image
{
    if (empty($_FILES[$field]) || empty($_FILES[$field]['tmp_name'])) {
        return null; // no file chosen
    }

   $upload = Upload::create();
$upload->getValidator()->setAllowedExtensions(['jpg','jpeg','png','webp']); // ✅

    $image = Image::create();
    if ($upload->loadIntoFile($_FILES[$field], $image, $folder)) {
        return $image; // not published yet
    }
    // Optional: inspect $upload->getErrors()
    return null;
}
public function SecurityID(): string
{
    return SecurityToken::inst()->getValue();
}
public function deleteFileImg(HTTPRequest $request): HTTPResponse
{
    
    if (!$request->isPOST() || !SecurityToken::inst()->checkRequest($request)) {
        return $this->jsonError('Invalid request', 400);
    }

    // Must be logged in
    $member = Security::getCurrentUser();
    if (!$member) {
        return $this->jsonError('Unauthorized', 401);
    }
    if($request->postVar('table') == 'RentalWorkerInformation')
    $object = RentalWorkerInformation::get()->byID($request->postVar('objectId'));
    else if($request->postVar('table') == 'MemberCompanyData')
    $object = MemberCompanyData::get()->filter('MemberID', $member->ID)->first();
    if (!$object) {
        return $this->jsonError('Worker not found or not yours', 404);
    }

    // Only allow these fields to be cleared
    $field = $request->postVar('field');
    $allowedFields = ['ImageID'];
    if (!in_array($field, $allowedFields, true)) {
        return $this->jsonError('Invalid field', 422);
    }

    // Get current file id for this field
    $fileID = (int) $object->{$field};
    if (!$fileID) {
        return $this->jsonOk(['message' => 'Nothing to delete', 'field' => $field]);
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

    return $this->jsonOk([
        'message' => 'Deleted',
        'field'   => $field,
        'objectID' => $object->ID
    ]);
}
private function jsonOk(array $payload = []): HTTPResponse
{
    $resp = HTTPResponse::create(json_encode(['ok' => true] + $payload));
    $resp->addHeader('Content-Type', 'application/json');
    return $resp;
}

private function jsonError(string $msg, int $code = 400): HTTPResponse
{
    $resp = HTTPResponse::create(json_encode(['ok' => false, 'error' => $msg]));
    $resp->addHeader('Content-Type', 'application/json');
    $resp->setStatusCode($code);
    return $resp;
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
    if($request->postVar('objectID') == 'NewContact')
    {
        if ($img = $this->attachImageFromFilesObject($_FILES[$request->postVar('field')], 'profiles')) {
      
            $img->publishSingle();
            return $this->jsonOk([
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
    if (!$object) {
        return $this->jsonError('Worker not found or not yours', 404);
    }
    if ($img = $this->attachImageFromFilesObject($_FILES[$request->postVar('field')], 'profiles')) {
      
            $img->publishSingle();
            $object->{$request->postVar('field')}= $img->ID;
            $object->write();
            return $this->jsonOk([
                'ok'  => true,
                'id'  => (int)$img->ID,
                'url' => $img->getURL()
            ]);
       
    }
}
    return $this->jsonError('File upload failed', 500);   
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
public function applications(HTTPRequest $request)
{
    $member = Security::getCurrentUser();
    $apartments = Apartment::get()->filter('MemberID', $member->ID);
    $applications = ApartmentApplication::get()->filter('ListerID', $member->ID);

    return $this->customise([
        'Title' => 'anhängige Anträge',
        'Applications' => $applications,
    ])->renderWith(['Layout/Broker/Applications', 'Page']);
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
  if($application->ListerID != $member->ID){
    $session = $request->getSession();
    $session->set('FlashMessage', 'You do not have permission to view that application');
    
    return $this->redirect('/dashboard/applications');
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
    ])->renderWith(['Layout/Broker/ApplicationDetail', 'Page']);
}
public function subscription(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    
    $plans=GlobalHelper::getSubscriptionPlans('owner',0);
    return $this->customise([
        'Title' => 'Mietenprofi',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
        'plans'=>$plans
    ])->renderWith(['Layout/Broker/Subscription', 'Page']);
}
public function guide(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    return $this->customise([
        'Title' => 'Mietenprofi',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
    ])->renderWith(['Layout/Broker/Guide', 'Page']);
}
public function payment_discount(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
   
    $plans=GlobalHelper::getSubscriptionPlans('broker',$new);
    return $this->customise([
        'Title' => 'Mietenprofi+',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
        'PaymentType'=>$request->postVar('PaymentType'),
        'plans'=>$plans
    ])->renderWith(['Layout/Broker/PaymentDiscount', 'Page']);
}
public function payment_method(HTTPRequest $request){
    if(!$request->postVar('PaymentType'))
    {
        return $this->redirect('/dashboard/subscription');
    }
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    $plans=GlobalHelper::getSubscriptionPlans('broker',0);
    if($request->postVar('PaymentType')=='Kostenfrei vermieten'){
        DB::query("UPDATE Apartment SET PaymentType = 0 WHERE MemberID = " . GlobalHelper::getLoggedInUser()->ID); 
        $memberBasicData->PlanId=$request->postVar('PaymentType');
        $memberBasicData->SubscriptionStatus='NotComplete';
        $memberBasicData->write();
        return $this->redirect('/payment/payment-thankyou');
        exit;
    }
    return $this->customise([
        'Title' => 'Mietenprofi+',
        'Name' => $member->FirstName.' '.$member->LastName,
        'MemberBasicData' => $memberBasicData,
        'PaymentType'=>$request->postVar('PaymentType'),
        'plans'=>$plans,
        'planDetails'=>GlobalHelper::SelectedPlan($request->postVar('PaymentType'),'broker',0)
    ])->renderWith(['Layout/Payments/PaymentMethod', 'Page']);
}
public function anhalten(HTTPRequest $request){
       DB::query("UPDATE Apartment SET PaymentType = 0 WHERE MemberID = " . GlobalHelper::getLoggedInUser()->ID); 
       $memberBasicData=MemberBasicData::get()->filter('MemberID', GlobalHelper::getLoggedInUser()->ID)->first();
        $memberBasicData->PlanId='Kostenfrei vermieten';
        $memberBasicData->SubscriptionStatus='NotComplete';
        $memberBasicData->write();
        return $this->redirect('/payment/payment-thankyou');
        exit;
}
public function remove_apartment(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
    $apartmentID = $request->postVar('apartmentID');
    $apartment = Apartment::get()->filter('ID', $apartmentID)->first();
    $apartment->delete();
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Property removed successfully',
        'action'=>'remove'
        ]);
}
public function change_apartment_status(HTTPRequest $request){
  
    $apartmentID = $request->postVar('apartmentID');
    $apartment = Apartment::get()->filter('ID', $apartmentID)->first();
    $apartment->Status = $request->postVar('status');
    $apartment->write();
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => 'Property status changed successfully',
        'action'=>'change'
        ]);
}
public function delete_account(HTTPRequest $request){
    $member = GlobalHelper::getLoggedInUser();
    
    
$member = Member::get()->byID($member->ID);

if ($member) {
    $member->delete(); 
    $member->destroy(); 
}
    return RestApiHelper::jsonOk([
        'ok' => true,
        'message' => _t('DashboardController.DeleteAccountSuccess', 'Account has been deleted successfully'),
        'action'=>'delete'
        ]);
}

}