<?php

namespace App\Controller;

use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\FileField;
use SilverStripe\Forms\PasswordField;
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\OptionsetField;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\DateField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\Forms\HiddenField;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Control\Session;
use SilverStripe\Assets\Upload;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Subsites\Model\Subsite;
use SilverStripe\Security\Member;
use SilverStripe\Security\TemporaryHashStore;
use SilverStripe\Control\Director;
use SilverStripe\Control\Email\Email;
use App\Extensions\CustomMemberExtension;
use SilverStripe\View\Requirements;
use SilverStripe\Security\SecurityToken;
use SilverStripe\Security\MemberAuthenticator\MemberAuthenticator;
use SilverStripe\Security\MemberAuthenticator\SessionAuthenticationHandler;
use SilverStripe\Security\Security;
use SilverStripe\Core\Injector\Injector;
use SilverStripe\Security\IdentityStore;

use App\Model\Registration;
use App\Model\MemberBasicData;
use App\Model\MemberCompanyData;
use App\Model\PersonalInformation;
use App\Model\RentalWorkerInformation;
use App\Helper\GlobalHelper;


class RegistrationPageController extends ContentController {
    private static $allowed_actions = ['index','account_removed','uploadFile', 'step1', 'doStep1','Step1Form', 'step2', 'doStep2','Step2Form', 'step3', 'doStep3','Step3Form', 'step4', 'doStep4','Step4Form', 'step5', 'doStep5','Step5Form', 'thankyou', 'RegistrationForm', 'doRegister', 'checkemail', 'resendemail', 'emailVerificationTemplate', 'validateuser', 'getMemberFieldValue', 'getMemberIDByField', 'updateMemberFieldByID', 'step6', 'doStep6','Step6Form', 'step7', 'doStep7','Step7Form'];

    private static $url_segment = 'registration';

    protected function init(){
        parent::init();
    }

    public function index(HTTPRequest $request)
    {
        $member = Security::getCurrentUser();
        if ($member) {
            return $this->redirect('/dashboard');
        }
      
        $form = $this->RegistrationForm();

        $session = $this->getRequest()->getSession();
        $errorMessage = $session->get('FormError');
        
        // Clear the message after retrieving it
        $session->clear('FormError');

        return $this->customise([
            'Title' => 'Registrierung',
            'FormError' => $errorMessage,
            'Form' => $form,
            'UserType' => $form->Fields()->dataFieldByName('UserType'),
            'Email' => $form->Fields()->dataFieldByName('Email'),
            'Password' => $form->Fields()->dataFieldByName('Password'),
            'RePassword' => $form->Fields()->dataFieldByName('RePassword'),
            'Backurl'=>$request->getVar('backurl') ?? ''
        ])->renderWith(['Layout/RegistrationForm', 'Page']);
    }



  

    public function RegistrationForm() {
        $emailAdrs = $this->getRequest()->getSession()->get('emailAddress');
        $fields = FieldList::create(
             OptionsetField::create('UserType', '', [
                'renter' => 'Mieter',
                'landlord' => 'Vermieter',
            ])->addExtraClass('radio_group')->setAttribute('required', 'required')->setValue('renter'),
            EmailField::create('Email', 'Emailadresse')->addExtraClass('form-control')->setAttribute('placeholder', 'Emailadresse')->setValue($emailAdrs),
            PasswordField::create('Password', 'Passwort')->addExtraClass('form-control')->setAttribute('placeholder', 'Passwort')->setAttribute('minlength', 8)          // HTML5 check
            ->setAttribute('pattern', '.{8,}'),
            PasswordField::create('RePassword', 'Passwort wiederholen')->addExtraClass('form-control')->setAttribute('placeholder', 'Passwort wiederholen')->setAttribute('minlength', 8)          // HTML5 check
            ->setAttribute('pattern', '.{8,}')
        );

        $actions = FieldList::create(
            FormAction::create('doRegister', 'Registrieren')
                ->addExtraClass('btn btn-primary')
        );

        $validator = RequiredFields::create(['Email', 'Password', 'RePassword']);

        $form = Form::create($this, 'RegistrationForm', $fields, $actions, $validator);
        $form->addExtraClass('registration-form');
        Requirements::customScript(<<<'JS'
(function(){
  var f = document.querySelector('form.registration-form');
  if (!f) return;
  f.addEventListener('submit', function(e){
    var p = f.querySelector('input[name="Password"]');
    var r = f.querySelector('input[name="RePassword"]');
    if (!p || !r) return;

    // HTML5 will already enforce minlength, but double-check:
    if ((p.value || '').length < 8) {
      alert('Das Passwort muss mindestens 8 Zeichen lang sein.');
      e.preventDefault(); return;
    }
    if (p.value !== r.value) {
      alert('Passwort und Wiederholung stimmen nicht überein.');
      e.preventDefault(); return;
    }
  });
})();
JS);
        $form->setFormAction('/registration/doRegister');
        return $form;
    }

    public function doRegister(HTTPRequest $request) {

        $data = $request->postVars();

        $this->getRequest()->getSession()->set('emailAddress', $data['Email']);
        $this->getRequest()->getSession()->set('BackUrl',$data['Backurl']);
        // Validate passwords match
        if ($data['Password'] !== $data['RePassword']) {
            $this->getRequest()->getSession()->set('FormError', 'Die Passwörter stimmen nicht überein. Bitte gib dasselbe Passwort ein.');
            return $this->redirect('/registration');
        }
        if (strlen($data['Password']) < 8) {
            $session->set('FormError', 'Das Passwort muss mindestens 8 Zeichen lang sein.');
            return $this->redirect('/registration');
        }
        // Check if email already exists
        $existingMember = Member::get()->filter('Email', $data['Email'])->first();
        if ($existingMember) {
            $this->getRequest()->getSession()->set('FormError', 'E-Mail-Adresse bereits registriert.');
            return $this->redirect('/registration');
        }

        
        // Create Member for login
        $member = Member::create();
        $member->Email = $data['Email'];
        $member->UserType = $data['UserType'];
        $member->changePassword($data['Password']);
        $member->write();

        $member->regenerateTempID();

        $request->getSession()->set('userName', $data['Email']);
        $request->getSession()->set('userPsd', $data['Password']);
        $request->getSession()->set('userType', $data['UserType']);
        $tempIDHash = $this->getMemberFieldValue($member->ID, 'TempIDHash');

        $confirmationLink = Director::absoluteURL("/registration/validateuser/{$tempIDHash}/?backurl=".$data['Backurl']);

        $this->emailVerificationTemplate($confirmationLink, $data['Email']);
        
        return $this->redirect("/registration/checkemail/{$tempIDHash}");
    }

    public function getMemberIDByField($fieldName, $value){
        $member = Member::get()->filter($fieldName, $value)->first();
        return $member ? $member->ID : null;
    }

    public function getMemberFieldValue($memberID, $fieldName){
        // Fetch member by ID
        $member = Member::get()->byID($memberID);

        // Check if member exists and field exists on member
        if ($member && $member->hasField($fieldName)) {
            return $member->{$fieldName};
        }

        // Return null if not found
        return null;
    }

    public function emailVerificationTemplate($confirmationLink, $emailAddress){

        $domain = Subsite::currentSubsite()->Domain();
        $emaildomain = str_replace('www.', '', $domain);

        $email = new Email(); 

        $email->setTo($emailAddress); 

        $email->setFrom('no-reply@'. $emaildomain); 
        $email->setReplyTo('no-reply@vdkwohnungmieten.de');             

        $email->setSubject("Email Verification"); 

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
        <a href='https://www.wmb.newsoftdemo.info/public'>
        <img src='https://www.wmb.newsoftdemo.info/themes/template/images/logo.png' alt='' style='vertical-align: middle; max-width: 28px; object-fit: cover;'>
        <span style='color: #D98209; font-size: clamp(16px, 1.25rem, 1.25rem); font-weight: 500; text-shadow: none; display: inline-block; padding-left: 4px;'>Wohnung mieten Berlin.de</span>
        </a>
        </td>
        </tr>

        <!-- Email Body -->
        <tr>
        <td style='padding: 50px 40px; color: #333333; min-height:800px;'>
        <h2 style='margin-top: 0;'>Verify your email</h2>
        <p style='font-size: 16px; line-height: 1.5;'>
        Thank you for signing up. Please confirm your email address by clicking the button below:
        </p>

        <!-- Yellow Button -->
        <p style='text-align: center; margin: 30px 0;'>
        <a href='{$confirmationLink}' style='background-color: #D98209; color: #FFF; padding: 14px 28px; text-decoration: none; font-weight: bold; border-radius: 4px; display: inline-block;'>
        Verify Email
        </a>
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
    }

    public function checkemail(HTTPRequest $request) {
        $hash = $request->param('ID');

        $session = $this->getRequest()->getSession();
        $errorMessage = $session->get('FormError');
        $sucessMessage = $session->get('FormSuccess');
        // Clear the message after retrieving it
        $session->clear('FormError');
        
        return $this->customise([
            'Title' => 'E-Mail verifizieren',
            'FormError' => $errorMessage,
            'FormSuccess' => $sucessMessage,
            'TempIDHash' => $hash
        ])->renderWith(['Layout/CheckEmailPage', 'Page']);
    }

    public function validateuser(HTTPRequest $request) {
        $hash = $request->param('ID');
        $memberID = $this->getMemberIDByField('TempIDHash', $hash);
        $this->getRequest()->getSession()->set('BackUrl',$request->getVar('backurl'));
        if(!empty($memberID)){
            $validUser = $this->updateMemberFieldByID($memberID, 'EmailValidate', 1);
            if(!empty($validUser)){
                $this->getRequest()->getSession()->set('FormSuccess', 'Deine E-Mail-Adresse wurde erfolgreich verifiziert. Bitte fahre fort und fülle alle Formulare aus.');
                return $this->redirect("/registration/step1/{$hash}");
            }else{
                $this->getRequest()->getSession()->set('FormError', 'Deine E-Mail-Adresse wurde nicht verifiziert. Bitte kontaktiere den Administrator.');
                return $this->redirect("/registration/checkemail/{$hash}");
            }
        }else{
            $this->getRequest()->getSession()->set('FormError', 'Deine E-Mail-Adresse wurde nicht verifiziert. Bitte kontaktiere den Administrator.');
            return $this->redirect("/registration/checkemail/{$hash}");
        }
    }

    public function updateMemberFieldByID($memberID, $fieldName, $newValue){
        $member = Member::get()->byID($memberID);
        if ($member) {
            $member->$fieldName = $newValue;
            $member->write();
            return true;
        }
        return false;
    }

    public function resendemail(HTTPRequest $request) {
        $hash = $request->param('ID');
        $memberID = $this->getMemberIDByField('TempIDHash', $hash);

        if(!empty($memberID)){
            $member = Member::get()->byID($memberID);

            $email = $member->Email;

            $confirmationLink = Director::absoluteURL("/registration/validateuser/{$hash}");

            $this->emailVerificationTemplate($confirmationLink, $email);

            $this->getRequest()->getSession()->set('FormSuccess', 'Die E-Mail wurde erfolgreich erneut gesendet.');

            return $this->redirect("/registration/checkemail/{$hash}");
        }else{
            $this->getRequest()->getSession()->set('FormError', 'Deine E-Mail-Adresse wurde nicht verifiziert. Bitte kontaktiere den Administrator.');
            return $this->redirect("/registration/checkemail/{$hash}");
        }
    }
    public function SecurityID(): string
    {
        return SecurityToken::inst()->getValue();
    }

    // Step 1: Inseriere als, Anrede, First/Last Name
    public function step1(HTTPRequest $request) {
        $this->getRequest()->getSession()->set('FormSuccess', '');
        $hash = $request->param('ID');
        $request->getSession()->set('HashValue', $hash);
$userType = Member::get()->byID($this->getMemberIDByField('TempIDHash', $hash))->UserType;
        $form = $this->Step1Form($userType);
        
        
        return $this->customise([
            'Title' => 'Übermittlung Ihrer Daten',
            'Form' => $form,
            'InseriereAls' => $form->Fields()->dataFieldByName('InseriereAls'),
            'Anrede' => $form->Fields()->dataFieldByName('Anrede'),
            'FirstName' => $form->Fields()->dataFieldByName('FirstName'),
            'LastName' => $form->Fields()->dataFieldByName('LastName'),
            'userType' => $userType
        ])->renderWith(['Layout/RegistrationStep1', 'Page']);
    }

    public function Step1Form($userType) {

        if($userType == 'renter')
        {
             $fieldUtype=OptionsetField::create('InseriereAls', 'Inseriere als*', [
                'renter' => 'Mieter',
            ])->addExtraClass('radio_group')->setAttribute('required', 'required')->setValue('renter');
        }else
        {
          $fieldUtype=OptionsetField::create('InseriereAls', 'Inseriere als*', [
                'broker' => 'Profi (makler)',
                'owner' => 'Eigentumer',
                'seller' => 'Mieter dieses wohnung',
            ])->addExtraClass('radio_group')->setAttribute('required', 'required')->setValue($this->getSessionData('MBData','InseriereAls'));
        }
        $fields = FieldList::create([
            $fieldUtype,

            OptionsetField::create('Anrede', 'Anrede*', [
                'Herr' => 'Herr',
                'Frau' => 'Frau',
                'Ansonsten' => 'Ansonsten',
            ])->addExtraClass('radio_group')->setAttribute('required', 'required')->setValue($this->getSessionData('MBData','Anrede')),

            TextField::create('FirstName', 'Vorname*')->setAttribute('placeholder', 'Vorname*')->setValue($this->getSessionData('MBData','FirstName')),
            TextField::create('LastName', 'Nachname*')->setAttribute('placeholder', 'Nachname*')->setValue($this->getSessionData('MBData','LastName')),
        ]);

        $actions = FieldList::create([
            FormAction::create('doStep1', 'Weiter')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['InseriereAls', 'Anrede', 'FirstName', 'LastName']);

        $form = Form::create($this, 'Step1Form', $fields, $actions, $validator);

        $form->setFormAction('/registration/doStep1');

        return $form;
    }

    public function doStep1(HTTPRequest $request) {
        $data = $request->postVars();
       //Setting global session to get data in every step
        $this->getRequest()->getSession()->set('MBData', array_merge(
            $this->getRequest()->getSession()->get('MBData') ?: [],
            $data
        ));
        return $this->redirect('/registration/step2');
    }

    // Step 2: Country code, phone, email
    public function step2() {

        $sessionData = $this->getRequest()->getSession()->get('MBData');
        $hash = $this->getRequest()->getSession()->get('HashValue');
        $memberID = $this->getMemberIDByField('TempIDHash', $hash);
        $emailField=$this->getMemberFieldValue($memberID,'Email');
        if($sessionData['InseriereAls'] == 'broker'){
            $form = $this->BrokerStep2Form();

            return $this->customise([
                'Title' => 'Übermittlung Ihrer Daten',
                'Form' => $form,
                'Firmaname' => $form->Fields()->dataFieldByName('Firmaname'),
                'HRBHRA' => $form->Fields()->dataFieldByName('HRBHRA'),
                'CountryCode' => $form->Fields()->dataFieldByName('CountryCode'),
                'Telefon' => $form->Fields()->dataFieldByName('Telefon'),
                'Email' => $form->Fields()->dataFieldByName('Email')->setValue($emailField)
            ])->renderWith(['Layout/RegistrationBrokerStep2', 'Page']);
        }else{
            $form=$this->Step4Form();
   return $this->customise([
                    'Title' => 'Personaliche Angaben',
                    'Form' => $form,
                    'Anrede' => $form->Fields()->dataFieldByName('Anrede')->setValue($this->getSessionData('PersonalInfo','Anrede') ?: $sessionData['Anrede']),
                    'Vorname' => $form->Fields()->dataFieldByName('FirstName')->setValue($this->getSessionData('PersonalInfo','FirstName') ?: $sessionData['FirstName']),
                    'Nachname' => $form->Fields()->dataFieldByName('LastName')->setValue($this->getSessionData('PersonalInfo','LastName') ?: $sessionData['LastName']),
                    'Geburtsdatum' => $form->Fields()->dataFieldByName('Geburtsdatum')->setValue($this->getSessionData('PersonalInfo','Geburtsdatum')),
                    'Strabe' => $form->Fields()->dataFieldByName('Strabe')->setValue($this->getSessionData('PersonalInfo','Strabe')),
                    'Nr' => $form->Fields()->dataFieldByName('Nr')->setValue($this->getSessionData('PersonalInfo','Nr')),
                    'Plz' => $form->Fields()->dataFieldByName('Plz')->setValue($this->getSessionData('PersonalInfo','Plz')),
                    'Ort' => $form->Fields()->dataFieldByName('Ort')->setValue($this->getSessionData('PersonalInfo','Ort')),
                    'Land' => $form->Fields()->dataFieldByName('Land')->setValue($this->getSessionData('PersonalInfo','Land')),
                    'CountryCode' => $form->Fields()->dataFieldByName('CountryCode')->setValue($this->getSessionData('PersonalInfo','CountryCode')),
                    'Telefon' => $form->Fields()->dataFieldByName('Telefon')->setValue($this->getSessionData('PersonalInfo','Telefon')),
                    'Email' => $form->Fields()->dataFieldByName('Email')->setValue($emailField),
                    'Fax' => $form->Fields()->dataFieldByName('Fax')->setValue($this->getSessionData('PersonalInfo','Fax'))
                ])->renderWith(['Layout/RegistrationStep4', 'Page']);
        }
    }

    public function BrokerStep2Form() {
        $fields = FieldList::create([
            TextField::create('Firmaname', 'Firmaname')->setAttribute('placeholder', 'Firmaname*')->setValue($this->getSessionData('MBData','Firmaname')),
            TextField::create('HRBHRA', 'HRB / HRA')->setAttribute('placeholder', 'HRB / HRA*')->setValue($this->getSessionData('MBData','HRBHRA')),
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setValue($this->getSessionData('MBData','CountryCode'))->setEmptyString('Ländervorwahl auswählen*'),
            TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.')->setValue($this->getSessionData('MBData','Telefon')),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*')->setValue($this->getSessionData('MBData','Email')),
        ]);

        $actions = FieldList::create([
            FormAction::create('doStep2', 'Weiter')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Firmaname', 'HRBHRA', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'BrokerStep2Form', $fields, $actions, $validator);

        $form->setFormAction('/registration/doStep2');

        return $form;
    }

    public function Step2Form() {
        $fields = FieldList::create([
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setValue('+49')->setEmptyString('Ländervorwahl auswählen*')->setValue($this->getSessionData('MBData','CountryCode')),
            TextField::create('Telefon', 'Telefon')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.')->setAttribute('placeholder', 'Telefon*')->setValue($this->getSessionData('MBData','Telefon')),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*')->setValue($this->getSessionData('MBData','Email')),
        ]);

        $actions = FieldList::create([
            FormAction::create('doStep2', 'Weiter')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Firmaname', 'HRBHRA', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'Step2Form', $fields, $actions, $validator);

        $form->setFormAction('/registration/doStep2');

        return $form;
    }

    public function doStep2(HTTPRequest $request) {
        $data = $request->postVars();
        $sessionData = $this->getRequest()->getSession()->get('MBData');
        $this->getRequest()->getSession()->set('MBData', array_merge(
            $this->getRequest()->getSession()->get('MBData') ?: [],
            $data
        ));
          
        if($sessionData['InseriereAls'] == 'broker'){
           
        }else{
            $this->getRequest()->getSession()->set('PersonalInfo', array_merge(
                $this->getRequest()->getSession()->get('PersonalInfo') ?: [],
                $data
            ));
        }
        return $this->redirect('/registration/step3');
    }

    // Step 3: Type radio
    public function step3() {

        $form = $this->Step3Form();

        return $this->customise([
            'Title' => 'Übermittlung Ihrer Daten',
            'Form' => $form,
            'Type' => $form->Fields()->dataFieldByName('Type')
        ])->renderWith(['Layout/RegistrationStep3', 'Page']);
    }

    public function Step3Form() {
        $fields = FieldList::create([
            OptionsetField::create('Type', '', [
                'Private' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet. Turpis egestas maecenas pharetra convallis. Eget egestas purus viverra accumsan in nisl nisi. Amet mauris commodo quis imperdiet massa tincidunt nunc.',
                'Company' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet. Turpis egestas maecenas pharetra convallis. Eget egestas purus viverra accumsan in nisl nisi. Amet mauris commodo quis imperdiet massa tincidunt nunc.',
            ])->setValue($this->getSessionData('MBData','Type')),
        ]);

        $actions = FieldList::create([
            FormAction::create('doStep3', 'Weiter')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Type']);

        $form = Form::create($this, 'Step3Form', $fields, $actions, $validator);
        $form->setFormAction('/registration/doStep3');

        return $form;
    }

    public function doStep3(HTTPRequest $request) {
        $data = $request->postVars();
        $sessionData = $this->getRequest()->getSession()->get('MBData');
        $session = $this->getRequest()->getSession();

        $allData = array_merge(
            $session->get('MBData') ?: [],
            $data
        );
        $session->set('MBData', $allData);
        $hash = $request->getSession()->get('HashValue');
        $memberID = $this->getMemberIDByField('TempIDHash', $hash);

        if ($memberID) {
            $member = Member::get()->byID($memberID);
            $member->FirstName = $allData['FirstName'];
            $member->Surname = $allData['LastName'];
            $member->write();
        }
         $memberbasicdata=MemberBasicData::get()->filter(['MemberID' => $memberID])->first();
        if (empty($memberbasicdata) || !$memberbasicdata->exists()) {
            $memberbasicdata = new MemberBasicData();
            $memberbasicdata->MemberID = $memberID;
        }

        foreach ($allData as $key => $value) {
            if ($memberbasicdata->hasField($key)) {
                $memberbasicdata->$key = $value;
            }
        }

        $memberbasicdata->write();
        if($sessionData['InseriereAls'] == 'broker'){
            return $this->redirect('/registration/step4');
        }else{
            return $this->redirect('/registration/step5');
        }
    }

    // Step 4: Personal info
    public function step4() {
        $sessionData = $this->getRequest()->getSession()->get('MBData');
        
        if($sessionData){
            if($sessionData['InseriereAls'] == 'broker'){
                $form = $this->BrokerStep4Form();

                return $this->customise([
                    'Title' => 'Firma',
                    'Form' => $form,
                    'Firmaname' => $form->Fields()->dataFieldByName('Firmaname')->setValue($this->getSessionData('BrokerCompanyData','Firmaname') ?: $sessionData['Firmaname']),
                    'HRBHRA' => $form->Fields()->dataFieldByName('HRBHRA')->setValue($this->getSessionData('BrokerCompanyData','HRBHRA') ?: $sessionData['HRBHRA']),
                    'Strabe' => $form->Fields()->dataFieldByName('Strabe')->setValue($this->getSessionData('BrokerCompanyData','Strabe') ?: $sessionData['Strabe']),
                    'Nr' => $form->Fields()->dataFieldByName('Nr')->setValue($this->getSessionData('BrokerCompanyData','Nr')),
                    'Plz' => $form->Fields()->dataFieldByName('Plz')->setValue($this->getSessionData('BrokerCompanyData','Plz')),
                    'Ort' => $form->Fields()->dataFieldByName('Ort')->setValue($this->getSessionData('BrokerCompanyData','Ort')),
                    'Land' => $form->Fields()->dataFieldByName('Land')->setValue($this->getSessionData('BrokerCompanyData','Land')),
                    'CountryCode' => $form->Fields()->dataFieldByName('CountryCode')->setValue($this->getSessionData('BrokerCompanyData','CountryCode') ?: $sessionData['CountryCode']),
                    'Telefon' => $form->Fields()->dataFieldByName('Telefon')->setValue($this->getSessionData('BrokerCompanyData','Telefon') ?: $sessionData['Telefon']),
                    'Email' => $form->Fields()->dataFieldByName('Email')->setValue($this->getSessionData('BrokerCompanyData','Email') ?: $sessionData['Email']),
                    'Website' => $form->Fields()->dataFieldByName('Website')->setValue($this->getSessionData('BrokerCompanyData','Website')),
                    'Fax' => $form->Fields()->dataFieldByName('Fax')->setValue($this->getSessionData('BrokerCompanyData','Fax'))
                ])->renderWith(['Layout/RegistrationBrokerStep4', 'Page']);
            }else{
                $form = $this->Step4Form();

                return $this->customise([
                    'Title' => 'Personaliche Angaben',
                    'Form' => $form,
                    'Anrede' => $form->Fields()->dataFieldByName('Anrede')->setValue($this->getSessionData('PersonalInfo','Anrede') ?: $sessionData['Anrede']),
                    'Vorname' => $form->Fields()->dataFieldByName('FirstName')->setValue($this->getSessionData('PersonalInfo','FirstName') ?: $sessionData['FirstName']),
                    'Nachname' => $form->Fields()->dataFieldByName('LastName')->setValue($this->getSessionData('PersonalInfo','LastName') ?: $sessionData['LastName']),
                    'Geburtsdatum' => $form->Fields()->dataFieldByName('Geburtsdatum')->setValue($this->getSessionData('PersonalInfo','Geburtsdatum')),
                    'Strabe' => $form->Fields()->dataFieldByName('Strabe')->setValue($this->getSessionData('PersonalInfo','Strabe')),
                    'Nr' => $form->Fields()->dataFieldByName('Nr')->setValue($this->getSessionData('PersonalInfo','Nr')),
                    'Plz' => $form->Fields()->dataFieldByName('Plz')->setValue($this->getSessionData('PersonalInfo','Plz')),
                    'Ort' => $form->Fields()->dataFieldByName('Ort')->setValue($this->getSessionData('PersonalInfo','Ort')),
                    'Land' => $form->Fields()->dataFieldByName('Land')->setValue($this->getSessionData('PersonalInfo','Land')),
                    'CountryCode' => $form->Fields()->dataFieldByName('CountryCode')->setValue($this->getSessionData('PersonalInfo','CountryCode') ?: $sessionData['CountryCode']),
                    'Telefon' => $form->Fields()->dataFieldByName('Telefon')->setValue($this->getSessionData('PersonalInfo','Telefon') ?: $sessionData['Telefon']),
                    'Email' => $form->Fields()->dataFieldByName('Email')->setValue($this->getSessionData('PersonalInfo','Email') ?: $sessionData['Email']),
                    'Fax' => $form->Fields()->dataFieldByName('Fax')->setValue($this->getSessionData('PersonalInfo','Fax'))
                ])->renderWith(['Layout/RegistrationStep4', 'Page']);
            }
        }else{
            $this->getRequest()->getSession()->set('FormError', 'Ihre E-Mail-Adresse wurde nicht bestätigt. Bitte überprüfen Sie Ihre E-Mails und bestätigen Sie sie erneut.');
            return $this->redirect('/registration/'); 
        }
    }

    public function BrokerStep4Form() {
        $fields = FieldList::create([
            TextField::create('Firmaname', 'Firmaname')->setAttribute('placeholder', 'Firmaname*'),
            TextField::create('HRBHRA', 'HRB / HRA')->setAttribute('placeholder', 'HRB / HRA*'),
            TextField::create('Strabe', 'Straße')->setAttribute('placeholder', 'Straße*'),
            TextField::create('Nr', 'Nr')->setAttribute('placeholder', 'Nr.*'),
            TextField::create('Plz', 'PLZ')->setAttribute('placeholder', 'PLZ.*')->setAttribute('pattern', '^[0-9]{5}$')
    ->setAttribute('maxlength', '5')
    ->setAttribute('title', 'Bitte geben Sie eine 5-stellige PLZ ein.'),
            TextField::create('Ort', 'Ort')->setAttribute('placeholder', 'Ort.*'),
            TextField::create('Land', 'Land')->setAttribute('placeholder', 'Land.*'),
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setValue('+49')->setEmptyString('Ländervorwahl auswählen*'),
            TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*'),
            TextField::create('Website', 'Website')->setAttribute('placeholder', 'Website'),
            TextField::create('Fax', 'Fax')->setAttribute('placeholder', 'Fax'),
        ]);

        $actions = FieldList::create([
            FormAction::create('doStep4', 'Weiter')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Firmaname', 'HRBHRA', 'Strabe', 'Nr', 'Plz', 'Ort', 'Land', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'BrokerStep4Form', $fields, $actions, $validator);

        $form->setFormAction('/registration/doStep4');

        return $form;
    }

    public function Step4Form() {
        $fields = FieldList::create([
            OptionsetField::create('Anrede', 'Anrede*', [
                'Herr' => 'Herr',
                'Frau' => 'Frau',
                'Ansonsten' => 'Ansonsten',
            ])->addExtraClass('radio_group'),
            TextField::create('FirstName', 'Vorname')->setAttribute('placeholder', 'Vorname*'),
            TextField::create('LastName', 'Nachname')->setAttribute('placeholder', 'Nachname'),
            DateField::create('Geburtsdatum', 'Geburtsdatum')->setAttribute('placeholder', 'Geburtsdatum')->setHTML5(true),
            TextField::create('Strabe', 'Straße')->setAttribute('placeholder', 'Straße*'),
            TextField::create('Nr', 'Nr')->setAttribute('placeholder', 'Nr.*'),
            TextField::create('Plz', 'PLZ')->setAttribute('placeholder', 'PLZ.*')->setAttribute('pattern', '^[0-9]{5}$')
    ->setAttribute('maxlength', '5')
    ->setAttribute('title', 'Bitte geben Sie eine 5-stellige PLZ ein.'),
            TextField::create('Ort', 'Ort')->setAttribute('placeholder', 'Ort.*'),
            TextField::create('Land', 'Land')->setAttribute('placeholder', 'Land.*'),
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setValue('+49')->setEmptyString('Ländervorwahl auswählen*'),
            TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*'),
            TextField::create('Fax', 'Fax')->setAttribute('placeholder', 'Fax'),
        ]);

        $actions = FieldList::create([
            FormAction::create('doStep2', 'zur Bestatigung')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Anrede', 'Vorname', 'Nachname', 'Strabe', 'Nr', 'Plz', 'Ort', 'Land', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'Step4Form', $fields, $actions, $validator);

        $form->setFormAction('/registration/doStep2');

        return $form;
    }

    public function doStep4(HTTPRequest $request) {
        $data = $request->postVars();
        $sessionData = $this->getRequest()->getSession()->get('MBData');
        if($sessionData['InseriereAls'] == 'broker'){
            $this->getRequest()->getSession()->set('BrokerCompanyData', array_merge(
                $this->getRequest()->getSession()->get('BrokerCompanyData') ?: [],
                $data
            ));
        }else{
            $this->getRequest()->getSession()->set('PersonalInfo', array_merge(
                $this->getRequest()->getSession()->get('PersonalInfo') ?: [],
                $data
            ));
        }
        return $this->redirect('/registration/step5');
    }

    // Step 5: Image, Description
    public function step5() {
        $form = $this->Step5Form();
        $sessionData = $this->getRequest()->getSession()->get('MBData');
       
        if($sessionData['InseriereAls'] == 'broker'){
            $title = 'Firma omschrijving';
        }else{
            $title = 'Personaliche Angaben';
        }

        return $this->customise([
            'Form' => $form,
            'Title' => $title,
            'Bilder' => $form->Fields()->dataFieldByName('Bilder'),
            'Description' => $form->Fields()->dataFieldByName('Description')->setValue($this->getSessionData('BrokerCompanyData','Description') ?: $this->getSessionData('PersonalInfo','Description'))
        ])->renderWith(['Layout/RegistrationStep5', 'Page']);
    }

    public function Step5Form(){
        $fields = FieldList::create(
            FileField::create('Bilder','Upload Image')
                ->setAllowedExtensions(['jpg', 'jpeg', 'png'])
                ->setAttribute('id', 'BilderIDInput')
                ->setAttribute('class','inputFileHidden')
                ->setAttribute('accept', 'image/jpeg, image/png'),
            TextareaField::create('Description', 'Description')->setAttribute('maxlength', 2000)->setAttribute('data-maxlength', 2000)->setAttribute('class', 'char-count')
        );

        $actions = FieldList::create(
            FormAction::create('doStep5', 'Weiter')->addExtraClass('btn btn-primary')
        );

        $validator = RequiredFields::create([]);

        $form = Form::create($this, 'Step5Form', $fields, $actions, $validator);

        $form->setFormAction('/registration/doStep5');
if (method_exists($form, 'setEncType')) {
        $form->setEncType('multipart/form-data');           // SS4/SS5
    } else {
        $form->setAttribute('enctype', 'multipart/form-data');
    }
        return $form;
    }

    public function doStep5(HTTPRequest $request) {
        $data = $request->postVars();

        $sessionData = $this->getRequest()->getSession()->get('MBData');
        if($sessionData['InseriereAls'] == 'broker'){
            $session = $this->getRequest()->getSession();

            $allData = array_merge(
                $session->get('BrokerCompanyData') ?: [],
                $data
            );
$session->set('BrokerCompanyData', $allData);
              $hash = $request->getSession()->get('HashValue');
            $memberID = $this->getMemberIDByField('TempIDHash', $hash);

            if ($memberID) {
                $companyData = MemberCompanyData::get()->filter('MemberID', $memberID)->first();
            }

            if (empty($companyData) || !$companyData->exists()) {
                $companyData = new MemberCompanyData();
                $companyData->MemberID = $memberID;
            }

            foreach ($allData as $key => $value) {
                if ($companyData->hasField($key)) {
                    $companyData->$key = $value;
                }
            }

            // if (!empty($data['Bilder'])) {
            //     $companyData->ImageID = $data['Bilder'];
            // }
              // Map form field "Bilder" -> relation "BilderID" and publish
             // print_r($_FILES);
              
    //$files = $request->getFiles();
   // print_r($_FILES['Bilder']);
 // die;
// broker branch
if($data['AjaxFileUploadId']>0)
{
    if ($companyData->hasField('ImageID'))  $companyData->ImageID  = $data['AjaxFileUploadId'];
    if ($companyData->hasField('BilderID')) $companyData->BilderID = $data['AjaxFileUploadId'];
}else
{
if ($img = $this->attachImageFromFiles('Bilder', 'profiles')) {
    $img->publishSingle();
    // set the correct relation column you have:
    if ($companyData->hasField('ImageID'))  $companyData->ImageID  = $img->ID;
    if ($companyData->hasField('BilderID')) $companyData->BilderID = $img->ID;
   
}
}
$companyData->write();
            
            //$session->clear('BrokerCompanyData');

            return $this->redirect('/registration/step6');
        }else{
            $session = $this->getRequest()->getSession();

            $allData = array_merge(
                $session->get('PersonalInfo') ?: [],
                $data
            );
$session->set('PersonalInfo', $allData);
            $hash = $request->getSession()->get('HashValue');
            $memberID = $this->getMemberIDByField('TempIDHash', $hash);

            if ($memberID) {
                $personalInfo = PersonalInformation::get()->filter('MemberID', $memberID)->first();
            }

            if (empty($personalInfo) || !$personalInfo->exists()) {
                $personalInfo = new PersonalInformation();
                $personalInfo->MemberID = $memberID;
            }

            //var_dump($data);

            // if (!empty($data['Bilder'])) {
            //     $personalInfo->ImageID = $data['Bilder'];
            // }
            
                // Map "Bilder" -> "BilderID" and publish
     if ($img = $this->attachImageFromFiles('Bilder', 'profiles')) {
    $img->publishSingle();
    // set the correct relation column you have:
    if ($personalInfo->hasField('ImageID'))  $personalInfo->ImageID  = $img->ID;
    if ($personalInfo->hasField('BilderID')) $personalInfo->BilderID = $img->ID;
   
}

            foreach ($allData as $key => $value) {
                if ($personalInfo->hasField($key)) {
                    $personalInfo->$key = $value;
                }
            }

            $personalInfo->write();
            //$session->clear('PersonalInfo');


            // Login script start //
            $authenticator = new MemberAuthenticator();

            $userName = $request->getSession()->get('userName');
            $userPsd = $request->getSession()->get('userPsd');
            $member = $authenticator->authenticate([
                'Email' => $userName,
                'Password' => $userPsd
            ], $request);

            if ($member && $member->exists()) {
                $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();

                if ($memberBasicData) {
                    $InseriereAls = $memberBasicData->InseriereAls;
                    $firstName = $memberBasicData->FirstName;
                    $lastName = $memberBasicData->LastName;

                    $request->getSession()->set('UserType', $InseriereAls);
                    $request->getSession()->set('CUFirstName', $firstName);
                    $request->getSession()->set('CULastName', $lastName);

                    $identityStore = Injector::inst()->get(IdentityStore::class);
                    $identityStore->logIn($member, false, $request);
                }          
            }
            // Login script end //

            return $this->redirect('/registration/thankyou');
        }
    }

    // Step 4: Personal info
    public function step6() {
        $form = $this->Step6Form();

        return $this->customise([
            'Title' => 'Miet arbeiter Angaben',
            'Form' => $form,
            'Anrede' => $form->Fields()->dataFieldByName('Anrede')->setValue($this->getSessionData('WorkerData','Anrede')),
            'Titel' => $form->Fields()->dataFieldByName('Titel')->setValue($this->getSessionData('WorkerData','Titel')),
            'Vorname' => $form->Fields()->dataFieldByName('FirstName')->setValue($this->getSessionData('WorkerData','FirstName')),
            'Nachname' => $form->Fields()->dataFieldByName('LastName')->setValue($this->getSessionData('WorkerData','LastName')),
            'CountryCode' => $form->Fields()->dataFieldByName('CountryCode')->setValue($this->getSessionData('WorkerData','CountryCode')),
            'Telefon' => $form->Fields()->dataFieldByName('Telefon')->setValue($this->getSessionData('WorkerData','Telefon')),
            'Email' => $form->Fields()->dataFieldByName('Email')->setValue($this->getSessionData('WorkerData','Email')),
            'PositionUnterneehmen' => $form->Fields()->dataFieldByName('PositionUnterneehmen')->setValue($this->getSessionData('WorkerData','PositionUnterneehmen')),
            'Mobile' => $form->Fields()->dataFieldByName('Mobile')->setValue($this->getSessionData('WorkerData','Mobile')),
            'Fax' => $form->Fields()->dataFieldByName('Fax')->setValue($this->getSessionData('WorkerData','Fax')),
            'StandaardContact' => $form->Fields()->dataFieldByName('StandaardContact')->setValue($this->getSessionData('WorkerData','StandaardContact'))
        ])->renderWith(['Layout/RegistrationStep6', 'Page']);
    }

    public function Step6Form() {
        $fields = FieldList::create([
            OptionsetField::create('Anrede', 'Anrede*', [
                'Herr' => 'Herr',
                'Frau' => 'Frau',
                'Ansonsten' => 'Ansonsten',
            ])->addExtraClass('radio_group'),

            TextField::create('Titel', 'Titel')->setAttribute('placeholder', 'Titel'),
            TextField::create('FirstName', 'Vorname')->setAttribute('placeholder', 'Vorname*'),
            TextField::create('LastName', 'Nachname')->setAttribute('placeholder', 'Nachname'),
            DropdownField::create('CountryCode', 'Country Code',GlobalHelper::getPhoneCodeCountry())->setValue('+49')->setEmptyString('Ländervorwahl auswählen*'),
            TextField::create('Telefon', 'Telefon')->setAttribute('placeholder', 'Telefon*')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            EmailField::create('Email', 'Emailadresse')->setAttribute('placeholder', 'Emailadresse*'),
            EmailField::create('ZusaEmail', 'Emailadresse')->setAttribute('placeholder', 'Zusatizliche mailadresse'),
            TextField::create('PositionUnterneehmen', 'Position Unterneehmen')->setAttribute('placeholder', 'Position im Unterneehmen'),
            TextField::create('Mobile', 'Mobiel')->setAttribute('placeholder', 'Mobiel')->setAttribute('pattern', '^[0-9]{10}$')
    ->setAttribute('maxlength', '10')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')")
    ->setAttribute('title', 'Bitte geben Sie eine 10-stellige Telefonnummer ein.'),
            TextField::create('Fax', 'Fax')->setAttribute('placeholder', 'Fax'),
            OptionsetField::create('StandaardContact', '', [
                '1' => 'Standaard Contact'
            ])->addExtraClass('radio_group')->setTemplate('OptionsetFieldListNonRequired'),
        ]);

        $actions = FieldList::create([
            FormAction::create('doStep6', 'Weiter')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Anrede','Vorname', 'Nachname', 'CountryCode', 'Telefon', 'Email']);

        $form = Form::create($this, 'Step6Form', $fields, $actions, $validator);

        $form->setFormAction('/registration/doStep6');

        return $form;
    }

    public function doStep6(HTTPRequest $request) {
        $data = $request->postVars();
        $this->getRequest()->getSession()->set('WorkerData', array_merge(
            $this->getRequest()->getSession()->get('WorkerData') ?: [],
            $data
        ));
        return $this->redirect('/registration/step7');
    }

    // Step 7: Image, Description
    public function step7() {
        $form = $this->Step7Form();

        return $this->customise([
            'Title' => 'Miet arbeiter Angaben',
            'Form' => $form,
            'Foto' => $form->Fields()->dataFieldByName('Foto'),
            'Description' => $form->Fields()->dataFieldByName('Description')->setValue($this->getSessionData('WorkerData','Description'))
        ])->renderWith(['Layout/RegistrationStep7', 'Page']);
    }

    public function Step7Form(){
        $fields = FieldList::create(
            FileField::create('Foto', 'Upload Image')
                ->setAllowedExtensions(['jpg', 'jpeg', 'png'])
                ->setAttribute('id', 'FotoIDInput')
                ->setAttribute('class','inputFileHidden')
                ->setAttribute('accept', 'image/jpeg, image/png'),
                // ->setAttribute('style', 'display:none;'),
            TextareaField::create('Description', 'Description')->setAttribute('maxlength', 2000)->setAttribute('data-maxlength', 2000)->setAttribute('class', 'char-count')
        );

        $actions = FieldList::create(
            FormAction::create('doStep7', 'zur Bestatigung')->addExtraClass('btn btn-primary')
        );

        $validator = RequiredFields::create(['Image', 'Description']);

        $form = Form::create($this, 'Step7Form', $fields, $actions, $validator);

        $form->setFormAction('/registration/doStep7');
if (method_exists($form, 'setEncType')) {
        $form->setEncType('multipart/form-data');           // SS4/SS5
    } else {
        $form->setAttribute('enctype', 'multipart/form-data');
    }
        return $form;
    }

    public function doStep7(HTTPRequest $request){
        $data = $request->postVars();
        $session = $this->getRequest()->getSession();

        $allData = array_merge(
            $session->get('WorkerData') ?: [],
            $data
        );
     $session->set('WorkerData', $allData);
        $hash = $request->getSession()->get('HashValue');
        $memberID = $this->getMemberIDByField('TempIDHash', $hash);

        if ($memberID) {
            $rentalInfo = RentalWorkerInformation::get()->filter('MemberID', $memberID)->first();
        }

        if (empty($rentalInfo) || !$rentalInfo->exists()) {
            $rentalInfo = new RentalWorkerInformation();
            $rentalInfo->MemberID = $memberID;
        }

        foreach ($allData as $key => $value) {
            if ($rentalInfo->hasField($key)) {
                $rentalInfo->$key = $value;
            }
        }

        // if (!empty($data['Image'])) {
        //     $rentalInfo->ImageID = $data['Image'];
        // }
        if($data['AjaxFileUploadId']>0)
        {
            if ($rentalInfo->hasField('ImageID'))  $rentalInfo->ImageID  = $data['AjaxFileUploadId'];
        }
        else
        {
        if ($img = $this->attachImageFromFiles('Foto', 'profiles')) {
    $img->publishSingle();
    // set the correct relation column you have:
    if ($rentalInfo->hasField('ImageID'))  $rentalInfo->ImageID  = $img->ID;
   // if ($companyData->hasField('BilderID')) $companyData->BilderID = $img->ID;
   
}
    }

        $rentalInfo->write();


        // Login script start //
        $authenticator = new MemberAuthenticator();

        $userName = $request->getSession()->get('userName');
        $userPsd = $request->getSession()->get('userPsd');
        $member = $authenticator->authenticate([
            'Email' => $userName,
            'Password' => $userPsd
        ], $request);

        if ($member && $member->exists()) {
            $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();

            if ($memberBasicData) {
                $InseriereAls = $memberBasicData->InseriereAls;
                $firstName = $memberBasicData->FirstName;
                $lastName = $memberBasicData->LastName;

                $request->getSession()->set('UserType', $InseriereAls);
                $request->getSession()->set('CUFirstName', $firstName);
                $request->getSession()->set('CULastName', $lastName);

                $identityStore = Injector::inst()->get(IdentityStore::class);
                $identityStore->logIn($member, false, $request);
            }          
        }
        // Login script end //

        $session->clear('WorkerData');
        return $this->redirect('/registration/thankyou');
    }

    // Step 6: Thank you
    public function thankyou() {
        $sessionData = $this->getRequest()->getSession()->get('MBData');
        $session = $this->getRequest()->getSession();
        
        if($sessionData && ($sessionData['InseriereAls'] == 'broker' || $sessionData['InseriereAls'] == 'owner' || $sessionData['InseriereAls'] == 'seller')){
            $session->clear('MBData');
            $session->clear('HashValue');
            $session->clear('emailAdrs');
            $session->clear('BrokerCompanyData');
            return $this->customise([
                'Title' => 'Thank You',
                'InseriereAls' => $sessionData['InseriereAls']
            ])->renderWith(['Layout/ThankYouBrokerPage', 'Page']);
        }else{
            $BackUrl=$session->get('BackUrl');
            $session->clear('BackUrl');
            $session->clear('MBData');
            $session->clear('HashValue');
            $session->clear('emailAdrs');
            $session->clear('PersonalInfo');
           

            return $this->customise([
                'Title' => 'Thank You',
                'BackUrl'=>$BackUrl
            ])->renderWith(['Layout/ThankYouPage', 'Page']);
        }
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
public function uploadFile(HTTPRequest $request): HTTPResponse
{
    if (!$request->isPOST() || !SecurityToken::inst()->checkRequest($request)) {
        return $this->jsonError('Invalid request', 400);
    }

    $fieldName = $request->postVar('field');
    $files = $_FILES[$fieldName] ?? null;

    if (!$files) {
        return $this->jsonError('No file found in request', 400);
    }

    // Call method and get both result and errors
    [$img, $errors] = $this->attachImageFromFilesObject($files, 'profiles');

    if ($img) {
        return $this->jsonOk([
            'ok'  => true,
            'id'  => (int)$img->ID,
            'url' => $img->getURL()
        ]);
    }
// Get only the first error message
$firstError = is_array($errors) && count($errors) > 0 ? $errors[0] : 'Unknown error';
    return $this->jsonError($firstError, 500);   
}
protected function jsonErrora($message, int $statusCode = 400): HTTPResponse
{
    // If the message is an array (e.g. ['message' => ..., 'errors' => ...]), use it directly
    $payload = is_array($message)
        ? ['error' => $message]
        : ['error' => ['message' => $message]];

    $response = HTTPResponse::create(json_encode($payload), $statusCode);
    $response->addHeader('Content-Type', 'application/json');
    return $response;
}
private function attachImageFromFilesObject($files, string $folder = 'profiles'): array
{
    if (empty($files) || empty($files['tmp_name'])) {
        return [null, ['No file chosen']];
    }

    $upload = Upload::create();
    $upload->getValidator()->setAllowedExtensions(['jpg', 'jpeg', 'png', 'webp']);

    $file = Image::create();
    if ($upload->loadIntoFile($files, $file, $folder)) {
        return [$file, []]; // Successful upload
    }

    // Return the file as null and errors from the validator
    return [null, $upload->getErrors()];
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
public function account_removed(){
    return $this->customise([
        'Title' => 'Account Removed'
    ])->renderWith(['Layout/AccountRemoved', 'Page']);
}
public function getSessionData($sessionKey='MBData',$dataKey='FirstName'){
    return $this->getRequest()->getSession()->get($sessionKey)[$dataKey] ?? '';
}
}
