<?php
namespace App\Controller;

use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\PasswordField;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\Security\Member;
use SilverStripe\Security\AuthenticationHandler;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Control\Email\Email;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\Controller;
use SilverStripe\Security\MemberAuthenticator\MemberAuthenticator;
use SilverStripe\Security\MemberAuthenticator\SessionAuthenticationHandler;
use SilverStripe\Security\Security;
use SilverStripe\Core\Injector\Injector;
use SilverStripe\Security\IdentityStore;

use App\Model\MemberBasicData;


class UserAuthController extends ContentController {
    private static $allowed_actions = [
        'index', 'LoginForm', 'doLogin', 'forgotPassword', 'ForgotPasswordForm', 'doSendOtp', 'verifyOtp', 'VerifyOtpForm', 'changePassword', 'ChangePasswordForm'
    ];

    private static $url_segment = 'login';

    protected function init(){
        parent::init();
    }

    public function index() {
        $member = Security::getCurrentUser();
        if ($member) {
            return $this->redirect('/dashboard');
        }

        $form = $this->LoginForm();

        $session = $this->getRequest()->getSession();
        $errorMessage = $session->get('FormError');
        
        // Clear the message after retrieving it
        $session->clear('FormError');

        return $this->customise([
            'Title' => 'Anmelden',
            'FormError' => $errorMessage,
            'Form' => $form,
            'Email' => $form->Fields()->dataFieldByName('Email'),
            'Password' => $form->Fields()->dataFieldByName('Password'),
            'Backurl'=>$this->getRequest()->getVar('backurl') ?? ''
        ])->renderWith(['Layout/Login', 'Page']);
    }

    public function LoginForm() {
        $loginEmail = $this->getRequest()->getSession()->get('loginEmail');

        $fields = FieldList::create([
            EmailField::create('Email', 'Email')->addExtraClass('form-control')->setAttribute('placeholder', 'Emailadresse')->setValue($loginEmail),
            PasswordField::create('Password', 'Passwort')->addExtraClass('form-control')->setAttribute('placeholder', 'Passwort'),
        ]);
        $actions = FieldList::create([
            FormAction::create('doLogin', 'Versenden')
        ]);
        $validator = RequiredFields::create(['Email', 'Password']);
        $form = Form::create($this, 'LoginForm', $fields, $actions, $validator);
        $form->setFormAction('/login/doLogin');
        return $form;
    }

    public function doLogin(HTTPRequest $request){
        $data = $request->postVars();

        $this->getRequest()->getSession()->set('loginEmail', $data['Email']);

        $authenticator = new MemberAuthenticator();
        $member = $authenticator->authenticate([
            'Email' => $data['Email'],
            'Password' => $data['Password']
        ], $request);

        if ($member && $member->exists()) {

            if($member->EmailValidate == 1){
                $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();

                if ($memberBasicData) {
                    $InseriereAls = $memberBasicData->InseriereAls;
                    $firstName = $memberBasicData->FirstName;
                    $lastName = $memberBasicData->LastName;

                    $request->getSession()->set('UserType', $InseriereAls);
                    $request->getSession()->set('CUFirstName', $firstName);
                    $request->getSession()->set('CULastName', $lastName);

                    $identityStore = Injector::inst()->get(IdentityStore::class);
                    $identityStore->logIn($member, false, $request); // false = don't "remember me"
                } else {
                    $this->getRequest()->getSession()->set('FormError', 'Du hast nicht alle Schritte des Formulars abgeschlossen. Bitte vervollständige sie und melde dich erneut an.');
                    return $this->redirect('/login');
                }
                
                $request->getSession()->clear('loginEmail');
                 $request->getSession()->clear('BackUrl');
                if(!empty($data['Backurl']))
                    return $this->redirect($data['Backurl']);
                  else  
                return $this->redirect('/dashboard');
            }else{
                $this->getRequest()->getSession()->set('FormError', 'Deine E-Mail-Adresse ist nicht verifiziert. Bitte verifiziere deine E-Mail.');
                //return $this->redirect('/login');
            }
            
        }

        // Login failed
        $this->getRequest()->getSession()->set('FormError', 'Ungültige E-Mail-Adresse oder falsches Passwort. Bitte versuche es erneut.');
        return $this->redirect('/login');
    }


    /*public function forgotPassword() {
        return $this->customise(['Form' => $this->ForgotPasswordForm()])->renderWith('Layout/ForgotPassword');
    }

    public function ForgotPasswordForm() {
        $fields = FieldList::create([
            EmailField::create('Email', 'Email'),
        ]);
        $actions = FieldList::create([
            FormAction::create('doSendOtp', 'Versenden')
        ]);
        $validator = RequiredFields::create(['Email']);
        return Form::create($this, 'ForgotPasswordForm', $fields, $actions, $validator);
    }

    public function doSendOtp($data, $form) {
        $otp = rand(100000, 999999);
        $this->getRequest()->getSession()->set('UserForgotOtp', $otp);
        $this->getRequest()->getSession()->set('UserForgotEmail', $data['Email']);
        $email = new Email();
        $email->setTo($data['Email']);
        $email->setFrom('no-reply@' . $_SERVER['HTTP_HOST']);
        $email->setSubject('Your OTP Code for Password Reset');
        $email->setBody('<p>Your OTP code is: <strong>' . $otp . '</strong></p><p>This code is valid for a short time. Please enter it to continue your password reset process.</p>');
        $email->send();
        $form->sessionMessage('OTP sent to your email address.', 'good');
        return $this->redirect('verifyOtp');
    }

    public function verifyOtp() {
        return $this->customise([
            'Title' => 'E-Mail verifizieren',
            'Form' => $this->VerifyOtpForm()
        ])->renderWith('Layout/VerifyOtp');
    }

    public function VerifyOtpForm() {
        $fields = FieldList::create([
            TextField::create('Otp', 'Enter OTP'),
        ]);
        $actions = FieldList::create([
            FormAction::create('doVerifyOtp', 'Code bestätigen')
        ]);
        $validator = RequiredFields::create(['Otp']);
        return Form::create($this, 'VerifyOtpForm', $fields, $actions, $validator);
    }

    public function doVerifyOtp($data, $form) {
        $session = $this->getRequest()->getSession();
        $otp = $session->get('UserForgotOtp');
        if ($data['Otp'] == $otp) {
            $form->sessionMessage('OTP verifiziert. Du kannst jetzt dein Passwort zurücksetzen.', 'good');
            return $this->redirect('changePassword');
        } else {
            $form->sessionMessage('Ungültiger OTP. Bitte versuche es erneut.', 'bad');
            return $this->redirectBack();
        }
    }

    public function changePassword() {
        return $this->customise([
            'Title' => 'Passwort ändern',
            'Form' => $this->ChangePasswordForm()
        ])->renderWith('Layout/ChangePassword');
    }

    public function ChangePasswordForm() {
        $fields = FieldList::create([
            PasswordField::create('NewPassword', 'New Password'),
            PasswordField::create('ConfirmPassword', 'Confirm Password'),
        ]);
        $actions = FieldList::create([
            FormAction::create('doChangePassword', 'zur Bestätigung')
        ]);
        $validator = RequiredFields::create(['NewPassword', 'ConfirmPassword']);
        return Form::create($this, 'ChangePasswordForm', $fields, $actions, $validator);
    }

    public function doChangePassword($data, $form) {
        $session = $this->getRequest()->getSession();
        $email = $session->get('UserForgotEmail');
        $member = Member::get()->filter('Email', $email)->first();
        if ($member && $data['NewPassword'] === $data['ConfirmPassword']) {
            $member->changePassword($data['NewPassword']);
            $form->sessionMessage('Passwort wurde erfolgreich geändert.', 'good');
            return $this->redirect('login');
        } else {
            $form->sessionMessage('Passwörter stimmen nicht überein oder Benutzer nicht gefunden.', 'bad');
            return $this->redirectBack();
        }
    }*/
}
