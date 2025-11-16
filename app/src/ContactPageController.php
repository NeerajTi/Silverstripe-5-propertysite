<?php

namespace {

    use SilverStripe\Forms\FieldList;
    use SilverStripe\Forms\TextField;
    use SilverStripe\Forms\EmailField;
    use SilverStripe\Forms\TextareaField;
    use SilverStripe\Forms\FormAction;
    use SilverStripe\Forms\Form;
    use SilverStripe\Forms\RequiredFields;
    use SilverStripe\Forms\CompositeField;
    use SilverStripe\Control\Email\Email;
    use SilverStripe\CMS\Controllers\ContentController;
    use SilverStripe\Control\Controller;    
    use SilverStripe\Subsites\Model\Subsite;

    class ContactPageController extends PageController
    {
        private static $allowed_actions = ['FormContact'];

        public function FormContact() 
        {
            // Create fields without label text and with placeholders
            $nameField = (new TextField('Naam', ''))
                ->setAttribute('placeholder', 'Name');

            $phoneField = (new TextField('Telefoon', ''))
                ->setAttribute('placeholder', 'Telefonnummer');

            $emailField = (new EmailField('Email', ''))
                ->setAttribute('placeholder', 'Emailadresse');

            // If you want to enable Onderwerp uncomment below and add placeholder
            // $onderwerpField = (new TextField('Onderwerp', ''))
            //    ->setAttribute('placeholder', 'Thema');

            $berichtField = (new TextareaField('Bericht', ''))
                ->setAttribute('placeholder', 'Bericht');

            // Wrap Name and Phone fields together in one div if needed
            $namePhoneGroup = CompositeField::create($nameField, $phoneField)
                ->addExtraClass('name-phone-wrapper');

            $fields = new FieldList( 
                $namePhoneGroup,
                $emailField, 
                // $onderwerpField,
                $berichtField
            ); 

            $actions = new FieldList( 
                new FormAction('submit', 'Versenden')
            ); 

            $validator = new RequiredFields([
                'Naam',
                'Telefoon',
                'Email',
                // 'Onderwerp',
                'Bericht'
            ]);        

            $form = new Form($this, 'FormContact', $fields, $actions, $validator);

            $form->enableSpamProtection()->fields()->fieldByName('Captcha');

            return $form;
        }

        public function submit($data, $form) 
        { 
            $domain = Subsite::currentSubsite()->Domain();
            $emaildomain = str_replace('www.', '', $domain);

            $email = new Email(); 

            $email->setTo('info@vdkwohnungmieten.de'); 

            $email->setFrom('no-reply@'. $emaildomain); 
            $email->setReplyTo($data['Email']);             

            $email->setSubject("Contact bericht - {$data["Onderwerp"]} - vanaf: {$domain}"); 

            $messageBody = "
                <b>Kontaktnachricht von - {$data["Naam"]}</b>
                </br></br>            
                <p><strong>Emailadresse:</strong> {$data['Email']}</p> 
                <p><strong>Telefonnummer:</strong> {$data['Telefoon']}</p> 
                </br></br>
                <p><strong>Thema:</strong> {$data['Onderwerp']}</p> 
                </br></br>
                <p><strong>Nachricht:</strong> {$data['Bericht']}</p> 
            "; 

            $email->setBody($messageBody); 
            $email->send(); 

            $form->sessionMessage('Ihre Nachricht wurde gesendet, wir werden uns so schnell wie möglich mit Ihnen in Verbindung setzen.', 'success');

            Controller::curr()->redirect($this->Link("#bedankt"));                    
        }
    }
}
