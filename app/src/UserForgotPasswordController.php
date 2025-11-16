<?php
namespace App\Controller;

use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Control\Controller;
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
use SilverStripe\Security\MemberAuthenticator\MemberAuthenticator;
use SilverStripe\Security\Security;

class UserForgotPasswordController extends ContentController {
    private static $allowed_actions = [
        'index', 'ForgotPasswordForm', 'doSendOtp', 'verifyotp', 'VerifyOtpForm', 'doVerifyOtp', 'changepassword', 'ChangePasswordForm', 'doChangePassword'
    ];

    private static $url_segment = 'forgot-password';

    public function index() {
        $form = $this->ForgotPasswordForm();

        $session = $this->getRequest()->getSession();
        $errorMessage = $session->get('FormError');
        
        // Clear the message after retrieving it
        $session->clear('FormError');

        return $this->customise([
            'Title' => 'Passwort vergessen',
            'Form' => $form,
            'FormError' => $errorMessage,
            'Email' => $form->Fields()->dataFieldByName('Email')
        ])->renderWith(['Layout/ForgotPassword', 'Page']);
    }

    public function ForgotPasswordForm() {
        $session = $this->getRequest()->getSession();
        $fields = FieldList::create([
            EmailField::create('Email', 'Emailadresse')->addExtraClass('form-control')->setAttribute('placeholder', 'Emailadresse')->setValue($session->get('OTPEmail'))
        ]);

        $actions = FieldList::create([
            FormAction::create('doSendOtp', 'Versenden')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Email']);
        $form = Form::create($this, 'ForgotPasswordForm', $fields, $actions, $validator);
        $form->setFormAction('/forgot-password/doSendOtp');
        return $form;
    }

    public function doSendOtp(HTTPRequest $request) {
        $data = $request->postVars();
        $member = Member::get()->filter('Email', $data['Email'])->first();
        
        if ($member) {
            $otp = rand(100000, 999999);
            $this->getRequest()->getSession()->set('OTP', $otp);
            $this->getRequest()->getSession()->set('OTPEmail', $data['Email']);
            
            // Send email with OTP
            $email = new Email();
            $email->setTo($data['Email']);
            $email->setSubject('Passwort-Zurücksetzungs-OTP');
            $email->setBody("Your OTP is: $otp");
            $email->send();
            
            return $this->redirect('/forgot-password/verifyotp');
        } else {
            $this->getRequest()->getSession()->set('FormError', 'Deine E-Mail-Adresse ist nicht registriert. Bitte versuche es mit einer anderen E-Mail-Adresse.');
            return $this->redirect('/forgot-password');
        }
    }

    public function verifyotp() {
        $form = $this->VerifyOtpForm();

        $session = $this->getRequest()->getSession();
        $errorMessage = $session->get('FormError');
        
        // Clear the message after retrieving it
        $session->clear('FormError');

        return $this->customise([
            'Title' => 'E-Mail verifizieren',
            'Form' => $form,
            'FormError' => $errorMessage,
            'Otp1' => $form->Fields()->dataFieldByName('Otp1'),
            'Otp2' => $form->Fields()->dataFieldByName('Otp2'),
            'Otp3' => $form->Fields()->dataFieldByName('Otp3'),
            'Otp4' => $form->Fields()->dataFieldByName('Otp4'),
            'Otp5' => $form->Fields()->dataFieldByName('Otp5'),
            'Otp6' => $form->Fields()->dataFieldByName('Otp6')
        ])->renderWith(['Layout/VerifyOtp', 'Page']);
    }

    public function VerifyOtpForm() {
        $fields = FieldList::create([
            TextField::create('Otp1', 'Otp1')->addExtraClass('form-control otpCls')->setAttribute('maxlength', 1),
            TextField::create('Otp2', 'Otp2')->addExtraClass('form-control otpCls')->setAttribute('maxlength', 1),
            TextField::create('Otp3', 'Otp3')->addExtraClass('form-control otpCls')->setAttribute('maxlength', 1),
            TextField::create('Otp4', 'Otp4')->addExtraClass('form-control otpCls')->setAttribute('maxlength', 1),
            TextField::create('Otp5', 'Otp5')->addExtraClass('form-control otpCls')->setAttribute('maxlength', 1),
            TextField::create('Otp6', 'Otp6')->addExtraClass('form-control otpCls')->setAttribute('maxlength', 1),

        ]);

        $actions = FieldList::create([
            FormAction::create('doVerifyOtp', 'Code bestatigen')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['Otp1', 'Otp2', 'Otp3', 'Otp4', 'Otp5', 'Otp6']);

        $form = Form::create($this, 'VerifyOtpForm', $fields, $actions, $validator);
        $form->setFormAction('/forgot-password/doVerifyOtp');
        return $form;
    }

    public function doVerifyOtp(HTTPRequest $request) {
        $data = $request->postVars();
        $session = $this->getRequest()->getSession();

        $optVal = $data['Otp1'].''.$data['Otp2'].''.$data['Otp3'].''.$data['Otp4'].''.$data['Otp5'].''.$data['Otp6'];
        
        if ($optVal == $session->get('OTP')) {
            return $this->redirect('/forgot-password/changepassword');
        } else {
            $session->set('FormError', 'Der OTP ist ungültig. Bitte versuche es erneut.');
            return $this->redirect('/forgot-password/verifyotp');
        }
    }

    public function changepassword() {
        $form = $this->ChangePasswordForm();

        $session = $this->getRequest()->getSession();
        $errorMessage = $session->get('FormError');
        
        // Clear the message after retrieving it
        $session->clear('FormError');

        return $this->customise([
            'Title' => 'Passwort ändern',
            'FormError' => $errorMessage,
            'Form' => $form,
            'NewPassword' => $form->Fields()->dataFieldByName('NewPassword'),
            'ConfirmPassword' => $form->Fields()->dataFieldByName('ConfirmPassword')
        ])->renderWith(['Layout/ChangePassword', 'Page']);
    }

    public function ChangePasswordForm() {
        $fields = FieldList::create([
            PasswordField::create('NewPassword', '')->addExtraClass('form-control')->setAttribute('placeholder', 'Neues passwort'),
            PasswordField::create('ConfirmPassword', '')->addExtraClass('form-control')->setAttribute('placeholder', 'Neues passwort wiederholen'),
        ]);

        $actions = FieldList::create([
            FormAction::create('doChangePassword', 'zur Bestatigung')->addExtraClass('btn btn-primary')
        ]);

        $validator = RequiredFields::create(['NewPassword', 'ConfirmPassword']);
        $form = Form::create($this, 'ChangePasswordForm', $fields, $actions, $validator);
        $form->setFormAction('/forgot-password/doChangePassword');
        return $form;
    }

    public function doChangePassword(HTTPRequest $request) {
        $data = $request->postVars();
        $session = $this->getRequest()->getSession();
        
        if ($data['NewPassword'] !== $data['ConfirmPassword']) {
            $session->set('FormError', 'Die Passwörter stimmen nicht überein. Bitte gib dasselbe Passwort ein.');
            return $this->redirect('/forgot-password/changepassword');
        }
        
        $member = Member::get()->filter('Email', $session->get('OTPEmail'))->first();
        // if ($member) {
        //     $member->Password = $data['NewPassword'];
        //     $member->write();
        //     //$member->logIn();
            
        //     $session->clear('OTP');
        //     $session->clear('OTPEmail');
            
        //     //return $this->redirect('/dashboard');
        // }
        if ($member) {
            try {
                // This will run the built-in validator
                $member->changePassword($data['NewPassword']);
    
                // Clear OTP session
                $session->clear('OTP');
                $session->clear('OTPEmail');
    
                return $this->redirect('/login');
            } catch (ValidationException $e) {
                // Catch "already used password" or other validation errors
                $session->set('FormError', $e->getResult()->getMessages()[0]['message'] ?? 'Fehler beim Ändern des Passworts.');
                return $this->redirect('/forgot-password/changepassword');
            }
        }
        
        return $this->redirect('/login');
    }
}
