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
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\FileField;
use SilverStripe\Forms\DateField;
use SilverStripe\Forms\HiddenField;
use SilverStripe\Forms\PasswordField;
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\OptionsetField;
use App\Forms\ContactOptionsetField;
use SilverStripe\View\ArrayData;
use SilverStripe\Forms\CheckboxSetField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Assets\File;
use SilverStripe\Control\Session;
use SilverStripe\Assets\Upload;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Subsites\Model\Subsite;
use SilverStripe\ORM\ArrayList;
use App\Model\Apartment;
use App\Model\ApartmentDetail;
use App\Model\ApartmentAddress;
use App\Model\ApartmentImage;
use App\Model\RentalWorkerInformation;
use App\Model\ApartmentDetailOption;
use App\Helper\GlobalHelper;
use App\Model\MemberBasicData;
class ApartmentController extends ContentController
{
    private static $allowed_actions = [
        'index','step1','step1Form','uploadFile','doStep1','step2','step2Form','doStep2','step3','step3Form','doStep3','step4','step4Form','doStep4','step5','step5Form','doStep5','step6','step6Form','doStep6','step7','step7Form','doStep7','step8','step8Form','doStep8','step9','step9Form','doStep9','deleteFile','step10','step10Form','doStep10','step11','step11Form','doStep11','step12','step12Form','doStep12','step13','step13Form','doStep13','notfound',
        'preview','payment','doPayment','paymentmethod','listingcreated','getDistrictbyCityAjax','subscription'
    ];

    private static $url_segment = 'apartment';
   
    protected function init()
    {
        parent::init();
        $request = $this->getRequest();
        // Check login status
        if (!Security::getCurrentUser()) {
            return $this->redirect('/login');
        }
        $id = (int) $request->getVar('apartmentID');
        if($id){
            $apt = Apartment::get()->byID($id);
            if (!$apt || (int)$apt->MemberID !== (int)Security::getCurrentUser()->ID) {
                return $this->redirect('/apartment/notfound');
            }
        }
       
    }
    public function SecurityID(): string
    {
        return SecurityToken::inst()->getValue();
    }
    public function index(HTTPRequest $request){
        return $this->redirect('/dashboard/brokerapartments');
    }
    public function notfound(HTTPRequest $request){
        return $this->renderWith(['Layout/Broker/Apartment/notfound', 'Page']);
    }
    public function step1(HTTPRequest $request){
        $member = Security::getCurrentUser();
         
          // Prefill on edit
          $apartment = $this->getApartmentFromRequest($request);
          $form=$this->step1Form($apartment);
    if ($apartment){
        $form->loadDataFrom($apartment);
    }
        if ($member) {
            return $this->customise([
                'Form' => $form,
                'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
                'ObjectNumber'=>$form->Fields()->dataFieldByName('ObjectNumber'),
                'GroupNumber'=>$form->Fields()->dataFieldByName('GroupNumber'),
                'WohnungType'=>$form->Fields()->dataFieldByName('WohnungType'),

            ])->renderWith(['Layout/Broker/Apartment/step1', 'Page']);
        }else{
            return $this->redirect('/login');
        }
    }

    public function step1Form($apartment = null){
       $fields = FieldList::create(  
            TextField::create('ObjectNumber', 'Referenznummer')->setTitle('Referenznummer')->setValue(GlobalHelper::generateUniqueCode()),
            TextField::create('GroupNumber', 'Projekt')->setTitle('Projekt'),
            OptionsetField::create('WohnungType', 'Wohnung Type*', [
                'Wohnung' => 'Wohnung',
                'WG Zimmer' => 'WG Zimmer',
                'Haus' => 'Haus',
                'Wohnung auf Zeit' => 'Wohnung auf Zeit',
                'Grage oder stellplatz'=>'Grage oder stellplatz'
            ]
        )->addExtraClass('radio_group'),
        );
        $actions = FieldList::create(
            FormAction::create('doStep1', 'Weiter')->addExtraClass('btn btn-primary')
        );
        $validator = RequiredFields::create(['ObjectNumber','WohnungType']);
        $form = Form::create($this, 'step1Form', $fields, $actions, $validator);
        if($apartment){
            $form->setFormAction('/apartment/doStep1/?apartmentID='.$apartment->ID);
        }else{
            $form->setFormAction('/apartment/doStep1');
        }
         // Pre-fill when editing
   
        return $form;
    }

    public function doStep1(HTTPRequest $request){
        $data = $request->postVars();
        // $this->getRequest()->getSession()->set('ObjectNumber', $data['ObjectNumber']);
        // $this->getRequest()->getSession()->set('GroupNumber', $data['GroupNumber']);
        // $this->getRequest()->getSession()->set('WohnungType', $data['WohnungType']);
        if (!$member = Security::getCurrentUser()) {
            return $this->redirect('/login');
        }
    
        $data = $request->postVars();
    
        $apartment = $this->getApartmentFromRequest($request) ?: Apartment::create();
        if (!$apartment->ID) {
            $apartment->MemberID = $member->ID; // only on create
        }
     
    
        // Update fields (same form for add/edit)
        $apartment->ObjectNumber = $data['ObjectNumber'] ?? $apartment->ObjectNumber;
        $apartment->GroupNumber  = $data['GroupNumber']  ?? $apartment->GroupNumber;
        $apartment->WohnungType  = $data['WohnungType']  ?? $apartment->WohnungType;
    
        $apartment->write();
        return $this->redirect('/apartment/step2/?apartmentID='.$apartment->ID);
    }
    public function step2(HTTPRequest $request){
        $apartment = $this->getApartmentFromRequest($request);
        $form=$this->step2Form($apartment);
        if($apartment){
            $apartmentAddress = ApartmentAddress::get()->byID($apartment->AddressID);
            if($apartmentAddress){
                $form->loadDataFrom($apartmentAddress);
            }
        }
        return $this->customise([
            'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
            'Form'=>$form,
             'Street'=>$form->Fields()->dataFieldByName('Street'),
             'Nr'=>$form->Fields()->dataFieldByName('Nr'),
             'Plz'=>$form->Fields()->dataFieldByName('Plz'),
             'Ort'=>$form->Fields()->dataFieldByName('Ort'),
             'Stadt'=>$form->Fields()->dataFieldByName('Stadt'),
             'Stadtteil'=>$form->Fields()->dataFieldByName('Stadtteil'),
             'StrasseundHausnummer'=>$form->Fields()->dataFieldByName('StrasseundHausnummer'),
        ])->renderWith(['Layout/Broker/Apartment/step2', 'Page']);
    }

    public function step2Form($apartment = null){
        $fields = FieldList::create(
            TextField::create('Street', 'Strasse*')->setTitle('Strasse*'),
            TextField::create('Nr', 'Nr*')->setTitle('Nr*'),
            TextField::create('Plz', 'PLZ*')->setTitle('PLZ*')->setAttribute('pattern', '^[0-9]{5}$')
    ->setAttribute('maxlength', '5')
    ->setAttribute('oninput', "this.value = this.value.replace(/[^0-9]/g, '')"),
           
            DropdownField::create('Stadt', 'Stadt*',GlobalHelper::getCities())->setTitle('Stadt*')->setEmptyString('Stadt auswählen*')->setAttribute('onchange', "getDistrictAjax(this.value,'Form_step2Form_Stadtteil')"),
            DropdownField::create('Stadtteil', 'Stadtteil*',GlobalHelper::formatArrayKeyValueSame(GlobalHelper::getDistrictbycity($apartment->Address->Stadt?: '')))->setTitle('Stadtteil*')->setEmptyString('Stadtteil auswählen*')->setValue($apartment->Address->Stadtteil ?: ''),
            OptionsetField::create('StrasseundHausnummer', 'Strasse und Hausnummer anzeigen', [
                'Ja' => 'Ja',
                'Nein' => 'Nein',
            ])->addExtraClass('radio_group')->setTemplate('OptionsetFieldLeft'),
        );
        $actions = FieldList::create(
            FormAction::create('doStep2', 'Weiter')->addExtraClass('btn btn-primary')
        );
        $validator = RequiredFields::create(['Street','Nr','Plz','Stadt','Stadtteil']);
        $form = Form::create($this, 'step2Form', $fields, $actions, $validator);
        if($apartment){
            $form->setFormAction('/apartment/doStep2/?apartmentID='.$apartment->ID);
        }else{
            $form->setFormAction('/apartment/doStep2');
        }
        return $form;
    }
    public function doStep2(HTTPRequest $request){
        $data = $request->postVars();
        $apartmentAddress = new ApartmentAddress();
        if($apartment = $this->getApartmentFromRequest($request)){
            $apartmentAddress = ApartmentAddress::get()->byID($apartment->AddressID);
            if(!$apartmentAddress){
                $apartmentAddress = new ApartmentAddress();
            }

        }
        $latlong=GlobalHelper::getLatLng($data['Street'], $data['Stadt'], $data['Plz'], 'Germany', 'DE',$data['Nr']);
       
        if($latlong['success']){
            $apartmentAddress->Lat = $latlong['latitude'];
            $apartmentAddress->Lng = $latlong['longitude'];
        }
        $apartmentAddress->Street = $data['Street'];
        $apartmentAddress->Nr = $data['Nr'];
        $apartmentAddress->Plz = $data['Plz'];
        $apartmentAddress->Ort = '';
        $apartmentAddress->Stadt = $data['Stadt'];
        $apartmentAddress->Stadtteil = $data['Stadtteil'];
        $apartmentAddress->StrasseundHausnummer = $data['StrasseundHausnummer'];
        
        $apartmentAddress->write();
        $addressID=$apartmentAddress->ID;
        $member = Security::getCurrentUser();
if ($member) {
    $apartment = Apartment::get()->byID($apartment->ID);
    $apartment->AddressID = $addressID;
    $apartment->write();
}
        return $this->redirect('/apartment/step3?apartmentID='.$apartment->ID);
    }

    public function step3(HTTPRequest $request){
        $apartment = $this->getApartmentFromRequest($request);
        $form=$this->step3Form($apartment);
        if($apartment){
            $apartmentDetail = ApartmentDetail::get()->byID($apartment->DetailsID);
            if($apartmentDetail){
                $form->loadDataFrom($apartmentDetail);
            }
        }
        return $this->customise([
            'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
            'Form'=>$form,
            'Wohnflache'=>$form->Fields()->dataFieldByName('Wohnflache'),
            'Zimmer'=>$form->Fields()->dataFieldByName('Zimmer'),
            'Kaltmiete'=>$form->Fields()->dataFieldByName('Kaltmiete'),
            'FloorVerfugbarAb'=>$form->Fields()->dataFieldByName('FloorVerfugbarAb'),
            'Nebenkosten'=>$form->Fields()->dataFieldByName('Nebenkosten'),
            'Kaution'=>$form->Fields()->dataFieldByName('Kaution'),
            'Gesamtmiete'=>$form->Fields()->dataFieldByName('Gesamtmiete'),
        ])->renderWith(['Layout/Broker/Apartment/step3', 'Page']);
    }
    public function step3Form($apartment = null){
        $fields = FieldList::create(
            TextField::create('Wohnflache', 'Wohnflache*')->setTitle('Wohnflache*')->setAttribute('pattern', '^\d+(\.\d{1,2})?$'),
            DropdownField::create('Zimmer', 'Zimmer*',GlobalHelper::Zimmers())->setTitle('Zimmer*')->setEmptyString('Zimmer auswählen*'),
            TextField::create('Kaltmiete', 'Kaltmiete*')->setTitle('Kaltmiete*')->setAttribute('pattern', '^\d+(\.\d{1,2})?$')->setAttribute('class', 'sumarg'),
            DateField::create('FloorVerfugbarAb', 'Verfugbar Ab*')->setHTML5(true),
            TextField::create('Nebenkosten', 'Nebenkosten*')->setTitle('Nebenkosten')->setAttribute('pattern', '^\d+(\.\d{1,2})?$')->setAttribute('class', 'sumarg'),
            TextField::create('Kaution', 'Kaution*')->setTitle('Kaution')->setAttribute('pattern', '\d*')->setAttribute('inputmode', 'numeric'),
            TextField::create('Gesamtmiete', 'Gesamtmiete*')->setTitle('Gesamtmiete*')->setAttribute('pattern', '^\d+(\.\d{1,2})?$')->setAttribute('type', 'number')->setAttribute('class', 'totalsum')->setAttribute('readonly', true),
        );
        $actions = FieldList::create(
            FormAction::create('doStep3', 'Weiter')->addExtraClass('btn btn-primary')
        );
        $validator = RequiredFields::create(['Wohnflache','Zimmer','Kaltmiete','Gesamtmiete','FloorVerfugbarAb']);
        $form = Form::create($this, 'step3Form', $fields, $actions, $validator);
        if($apartment){
            $form->setFormAction('/apartment/doStep3/?apartmentID='.$apartment->ID);
        }else{
            $form->setFormAction('/apartment/doStep3');
        }
        return $form;
    }
    public function doStep3(HTTPRequest $request){
        $data = $request->postVars();
        $apartmentDetails = new ApartmentDetail();
        if($apartment = $this->getApartmentFromRequest($request)){
            $apartmentDetails = ApartmentDetail::get()->byID($apartment->DetailsID);
            if(!$apartmentDetails){
                $apartmentDetails = new ApartmentDetail();
            }

        }
        $apartmentDetails->Wohnflache = $data['Wohnflache'];
        $apartmentDetails->Zimmer = $data['Zimmer'];
        $apartmentDetails->Kaltmiete = $data['Kaltmiete'];
        $apartmentDetails->FloorVerfugbarAb = $data['FloorVerfugbarAb'];
        $apartmentDetails->Nebenkosten = $data['Nebenkosten'];
        $apartmentDetails->Kaution = $data['Kaution'];
        $apartmentDetails->Gesamtmiete = $data['Gesamtmiete'];
        $apartmentDetails->write();
        $detailID=$apartmentDetails->ID;
        $member = Security::getCurrentUser();
if ($member) {
    $apartment = Apartment::get()->byID($apartment->ID);
    $apartment->DetailsID = $detailID;
    $apartment->write();
}
        return $this->redirect('/apartment/step4?apartmentID='.$apartment->ID);
    }

    public function step4(HTTPRequest $request){
        $apartment = $this->getApartmentFromRequest($request);
        $form=$this->step4Form($apartment);
        if($apartment){
            $apartmentDetails = ApartmentDetail::get()->byID($apartment->DetailsID);
            if($apartmentDetails){
                $form->loadDataFrom($apartmentDetails);
                 // ✅ Populate the checkbox with selected options (we used Label as value)
            $selected = $apartmentDetails->DetailOptions()->column('Label'); // or 'Code' if you have one
            $form->loadDataFrom(['DetailOptionsIDs' => $selected]);
            }
        }
        return $this->customise([
            'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
            'Form'=>$form,
            'DetailsOptions'=>$form->Fields()->dataFieldByName('DetailOptionsIDs'),
            'Services'=>$form->Fields()->dataFieldByName('Services'),
            'QualitatDerWohnung'=>$form->Fields()->dataFieldByName('QualitatDerWohnung'),
        ])->renderWith(['Layout/Broker/Apartment/step4', 'Page']);
    }
    public function doStep4(HTTPRequest $request){
        $data = $request->postVars();
        $apartmentDetails = new ApartmentDetail();
        if($apartment = $this->getApartmentFromRequest($request)){
            $apartmentDetails = ApartmentDetail::get()->byID($apartment->DetailsID);
          
            if($apartmentDetails){
            // Save DetailOptions
    $selectedOptions = $data['DetailOptionsIDs'] ?? [];
     // Remove all previous
     $apartmentDetails->DetailOptions()->removeAll();

     foreach ($selectedOptions as $label) {
         $opt = ApartmentDetailOption::create();
         $opt->Label   = $label;
         $opt->Value   = 'Ja'; // you could store "Ja" or true
         $opt->DetailID = $apartmentDetails->ID;
         $opt->write();
     }
                // if (isset($data['DetailsOptions']) && is_array($data['DetailsOptions'])) {
                //     $apartmentDetails->DetailsOptions = json_encode(array_values($data['DetailsOptions']));
                //     unset($data['DetailsOptions']);
                // }
        
        $apartmentDetails->QualitatDerWohnung = $data['QualitatDerWohnung'];
        $apartmentDetails->write();
    }else{
        return $this->redirect('/apartment/step3?apartmentID='.$apartment->ID);
    }

}
        return $this->redirect('/apartment/step5?apartmentID='.$apartment->ID);
    }
    public function step4Form($apartment = null){
        $fields = FieldList::create(
            CheckboxSetField::create(
                'DetailOptionsIDs',
                '',
                [
                    'Einbauküche'            => 'Einbauküche',
                    'Balkon/Terrasse'        => 'Balkon/Terrasse',
                    'Gäste WC'               => 'Gäste WC',
                    'WG geeignet'            => 'WG geeignet',
                    'Aufzug'                 => 'Aufzug',
                    'Gearten'                 => 'Gearten',
                    'Keller'                 => 'Keller',
                    'Stufenlose Zugang'      => 'Stufenlose Zugang',
                    'Wohnberechtigungsschein'=> 'Wohnberechtigungsschein',
                    'Haustiere erlaubt'      => 'Haustiere erlaubt',
                ]
            )->addExtraClass('radio_group')->setTemplate('OptionsetFieldListCheckbox'),    
           
            
            // Qualität der Wohnung
            OptionsetField::create(
                'QualitatDerWohnung',
                '',
                [
                    'Neubau'  => 'Neubau',
                    'Einfach' => 'Einfach',
                    'Gehoben' => 'Gehoben',
                    'Normal'  => 'Normal',
                    'Luxe'    => 'Luxe',
                ]
            )->addExtraClass('radio_group')->setTemplate('OptionsetFieldList'),
        );
        $actions = FieldList::create(
            FormAction::create('doStep4', 'Weiter')->addExtraClass('btn btn-primary')
        );
        $validator = RequiredFields::create(['QualitatDerWohnung']);
        $form = Form::create($this, 'step4Form', $fields, $actions, $validator);
        if($apartment){
            $form->setFormAction('/apartment/doStep4/?apartmentID='.$apartment->ID);
        }else{
            $form->setFormAction('/apartment/doStep4');
        }
        return $form;
    }

    public function step5(HTTPRequest $request){
        $apartment = $this->getApartmentFromRequest($request);
        $form=$this->step5Form($apartment);
        if($apartment){
            $apartmentDetails = ApartmentDetail::get()->byID($apartment->DetailsID);
            if($apartmentDetails){
                $form->loadDataFrom($apartmentDetails);
            }
        }
        return $this->customise([
            'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
            'Form'=>$form,
            'Schlafzimmer'=>$form->Fields()->dataFieldByName('Schlafzimmer'),
            'Badezimmer'=>$form->Fields()->dataFieldByName('Badezimmer'),
            'Etage'=>$form->Fields()->dataFieldByName('Etage'),
            'Von'=>$form->Fields()->dataFieldByName('Von'),
            'Nutzflache'=>$form->Fields()->dataFieldByName('Nutzflache'),
            'Wohnberechtigungsschein'=>$form->Fields()->dataFieldByName('Wohnberechtigungsschein'),
            'Heizungsart'=>$form->Fields()->dataFieldByName('Heizungsart'),
        ])->renderWith(['Layout/Broker/Apartment/step5', 'Page']);
    }
    public function step5Form($apartment = null){
        $fields = FieldList::create(
            TextField::create('Schlafzimmer', 'Schlafzimmer')->setTitle('Schlafzimmer')->setAttribute('type', 'number')->setAttribute('min',0),
            TextField::create('Badezimmer', 'Badezimmer')->setTitle('Badezimmer')->setAttribute('type', 'number')->setAttribute('min',0),
            TextField::create('Etage', 'Etage')->setTitle('Etage')->setAttribute('type', 'number')->setAttribute('min',0),
            TextField::create('Von', 'Von')->setTitle('Von')->setAttribute('type', 'number')->setAttribute('min',0),
            TextField::create('Nutzflache', 'Nutzflache')->setTitle('Nutzflache')->setAttribute('type', 'number')->setAttribute('min',0),
            OptionsetField::create('Wohnberechtigungsschein', '', [
                'Erforderlich' => 'Erforderlich',
                'Nichterforderlich' => 'Nichterforderlich',
            ])->addExtraClass('radio_group')->setTemplate('OptionsetFieldStack'),
            OptionsetField::create('Heizungsart', '', [
                'Etagenheizung' => 'Etagenheizung',
                'Zentralheizung' => 'Zentralheizung',
            ])->addExtraClass('radio_group')->setTemplate('OptionsetFieldStack'),
        );
        $actions = FieldList::create(
            FormAction::create('doStep5', 'Weiter')->addExtraClass('btn btn-primary')
        );
        $validator = RequiredFields::create(['Schlafzimmer','Badezimmer','Nutzflache','Wohnberechtigungsschein','Heizungsart','Etage']);
        $form = Form::create($this, 'step5Form', $fields, $actions, $validator);
        if($apartment){
            $form->setFormAction('/apartment/doStep5/?apartmentID='.$apartment->ID);
        }else{
            $form->setFormAction('/apartment/doStep5');
        }
        return $form;
    }
    public function doStep5(HTTPRequest $request){
        $apartment = $this->getApartmentFromRequest($request);
        $data = $request->postVars();
        $apartmentDetails = new ApartmentDetail();
        if($apartment){
            $apartmentDetails = ApartmentDetail::get()->byID($apartment->DetailsID);
          
            if($apartmentDetails){
           
      
        $apartmentDetails->Schlafzimmer = $data['Schlafzimmer'];
        $apartmentDetails->Badezimmer = $data['Badezimmer'];
        $apartmentDetails->Etage = $data['Etage'];
        $apartmentDetails->Von = $data['Von'];
        $apartmentDetails->Nutzflache = $data['Nutzflache'];
        $apartmentDetails->Wohnberechtigungsschein = $data['Wohnberechtigungsschein'];
        $apartmentDetails->Heizungsart = $data['Heizungsart'];
        $apartmentDetails->write();
    }else{
        return $this->redirect('/apartment/step4?apartmentID='.$apartment->ID);
    }

}

        return $this->redirect('/apartment/step6?apartmentID='.$apartment->ID);
    }

    public function step7(HTTPRequest $request){
        $apartment = $this->getApartmentFromRequest($request);
        $form=$this->step7Form($apartment);
        if($apartment){
            $form->loadDataFrom($apartment);
        }
        return $this->customise([
            'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
            'Form'=>$form,
             'Uberschrift'=>$form->Fields()->dataFieldByName('Uberschrift'),
        ])->renderWith(['Layout/Broker/Apartment/step7', 'Page']);
    }

    public function step7Form($apartment = null){
        $fields = FieldList::create(
            TextareaField::create('Uberschrift', 'Uberschrift*')->setTitle('Uberschrift*')->setAttribute('class', 'char-count')->setAttribute('maxlength', 100)->setAttribute('data-maxlength', 100)
        );
        $actions = FieldList::create(
            FormAction::create('doStep6', 'Weiter')->addExtraClass('btn btn-primary')
        );
        $validator = RequiredFields::create(['Uberschrift']);
        $form = Form::create($this, 'step6Form', $fields, $actions, $validator);
        if($apartment){
            $form->setFormAction('/apartment/doStep7/?apartmentID='.$apartment->ID);
        }else{
            $form->setFormAction('/apartment/doStep7');
        }
        return $form;
    }
    public function doStep7(HTTPRequest $request){
        $data = $request->postVars();
        $apartment = $this->getApartmentFromRequest($request);
        if($apartment){
            $apartment->Uberschrift = $data['Uberschrift'];
            $apartment->write();
        }
        return $this->redirect('/apartment/step8?apartmentID='.$apartment->ID);
    }
public function step6(HTTPRequest $request){
    $apartment = $this->getApartmentFromRequest($request);
    $form=$this->step6Form($apartment);
    if($apartment){
        $form->loadDataFrom($apartment);
    }
    return $this->customise([
        'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
        'Form'=>$form,
         'Internetgeschwindigkeit'=>$form->Fields()->dataFieldByName('Internetgeschwindigkeit'),
         'Energieeffiziezklasse'=>$form->Fields()->dataFieldByName('Energieeffiziezklasse'),
    ])->renderWith(['Layout/Broker/Apartment/step6', 'Page']);
}
public function step6Form($apartment = null){
    $fields = FieldList::create(
        OptionsetField::create('Internetgeschwindigkeit', 'Internetgeschwindigkeit',['Alle Geschwindigkiet'=>'Alle Geschwindigkiet:','Mind. 100 Mbit/s'=>'Mind. 100 Mbit/s:','Mind. 250 Mbit/s'=>'Mind. 250 Mbit/s:','Mind 1000 Mbit/s'=>'Mind 1000 Mbit/s:'])->setTitle('Internetgeschwindigkeit')->setTemplate('OptionFieldSetList6'),
        OptionsetField::create('Energieeffiziezklasse', 'Energieeffiziezklasse',['A'=>'A','B'=>'B','C'=>'C','D+'=>'D+'])->setTitle('Energieeffiziezklasse')->setTemplate('OptionFieldSetList6')
    );
    $actions = FieldList::create(
        FormAction::create('doStep6', 'Weiter')->addExtraClass('btn btn-primary')
    );
    $validator = RequiredFields::create([]);
    $form = Form::create($this, 'step6Form', $fields, $actions, $validator);
    if($apartment){
        $form->setFormAction('/apartment/doStep6/?apartmentID='.$apartment->ID);
    }else{
        $form->setFormAction('/apartment/doStep6');
    }
    return $form;
}
public function doStep6(HTTPRequest $request){
    $data = $request->postVars();
    $apartment = $this->getApartmentFromRequest($request);
    if($apartment){
        $apartment->Internetgeschwindigkeit = $data['Internetgeschwindigkeit'];
        $apartment->Energieeffiziezklasse = $data['Energieeffiziezklasse'];
        $apartment->write();
    }
    return $this->redirect('/apartment/step7?apartmentID='.$apartment->ID);
}
    public function step8(HTTPRequest $request){
        $apartment = $this->getApartmentFromRequest($request);
        $form=$this->step8Form($apartment);
        if($apartment){
            $form->loadDataFrom($apartment);
        }
        return $this->customise([
            'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
            'Form'=>$form,
             'Mietwohnung'=>$form->Fields()->dataFieldByName('Mietwohnung'),
        ])->renderWith(['Layout/Broker/Apartment/step8', 'Page']);
    }

    public function step8Form($apartment = null){
        $fields = FieldList::create(
            TextareaField::create('Mietwohnung', 'Mietwohnung beschreibung*')->setTitle('Mietwohnung beschreibung*')->setAttribute('class', 'char-count')->setAttribute('maxlength', 2000)->setAttribute('data-maxlength', 2000)
        );
        $actions = FieldList::create(
            FormAction::create('doStep7', 'Weiter')->addExtraClass('btn btn-primary')
        );
        $validator = RequiredFields::create(['Mietwohnung']);
        $form = Form::create($this, 'step7Form', $fields, $actions, $validator);
        if($apartment){
            $form->setFormAction('/apartment/doStep8/?apartmentID='.$apartment->ID);
        }else{
            $form->setFormAction('/apartment/doStep8');
        }
        return $form;
    }
    public function doStep8(HTTPRequest $request){
        $data = $request->postVars();
        $apartment = $this->getApartmentFromRequest($request);
        if($apartment){
            $apartment->Mietwohnung = $data['Mietwohnung'];
            $apartment->write();
        }
        return $this->redirect('/apartment/step9?apartmentID='.$apartment->ID);
    }

    public function step9(HTTPRequest $request){
        $apartment = $this->getApartmentFromRequest($request);
        $form=$this->step9Form($apartment);
        if($apartment){
            $form->loadDataFrom($apartment);
        }
        return $this->customise([
            'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
            'Form'=>$form,
             'Dieumgebung'=>$form->Fields()->dataFieldByName('Dieumgebung'),
        ])->renderWith(['Layout/Broker/Apartment/step9', 'Page']);
    }

    public function step9Form($apartment = null){
        $fields = FieldList::create(
            TextareaField::create('Dieumgebung', 'Die Umgebung*')->setTitle('Die Umgebung*')->setAttribute('class', 'char-count')->setAttribute('maxlength', 2000)->setAttribute('data-maxlength', 2000)
        );
        $actions = FieldList::create(
            FormAction::create('doStep9', 'Weiter')->addExtraClass('btn btn-primary')
        );
        $validator = RequiredFields::create([]);
        $form = Form::create($this, 'step9Form', $fields, $actions, $validator);
        if($apartment){
            $form->setFormAction('/apartment/doStep9/?apartmentID='.$apartment->ID);
        }else{
            $form->setFormAction('/apartment/doStep9');
        }
        return $form;
    }
    public function doStep9(HTTPRequest $request){
        $data = $request->postVars();
        $apartment = $this->getApartmentFromRequest($request);
        if($apartment){
            $apartment->Dieumgebung = $data['Dieumgebung'];
            $apartment->write();
        }
        return $this->redirect('/apartment/step10?apartmentID='.$apartment->ID);
    }
public function step10(HTTPRequest $request){
    $apartment = $this->getApartmentFromRequest($request);
    $form=$this->step10Form($apartment);
    if($apartment){
        //$form->loadDataFrom($apartment);
    }
    return $this->customise([
        'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
        'Form'=>$form,
        'apartment'=>$apartment,
         'BilderID'=>$form->Fields()->dataFieldByName('BilderID'),
         'DocumentID'=>$form->Fields()->dataFieldByName('DocumentID'),
         'VideoID'=>$form->Fields()->dataFieldByName('VideoID'),
         'GrundID'=>$form->Fields()->dataFieldByName('GrundID'),
    ])->renderWith(['Layout/Broker/Apartment/step10', 'Page']);
}
public function step10Form($apartment = null){
    $fields = FieldList::create(
        FileField::create('BilderID', 'Bilder*')->setTitle('Bilder*')->setAllowedExtensions(['gif', 'jpeg', 'png'])->setAttribute('id', 'BilderIDInput')->setAttribute('class', 'inputFileHidden')->setAttribute('multiple', 'multiple'),
        FileField::create('DocumentID', 'Dokumente*')->setTitle('Dokumente*')->setAllowedExtensions(['pdf'])->setAttribute('id', 'DocumentIDInput')->setAttribute('class', 'inputFileHidden'),
        FileField::create('VideoID', 'Video*')->setTitle('Video*')->setAllowedExtensions(['mps','avi','mov','mpg','mp4','mkv'])->setAttribute('id', 'VideoIDInput')->setAttribute('class', 'inputFileHidden'),
        FileField::create('GrundID', 'Grund*')->setTitle('Grund*')->setAllowedExtensions(['pdf','gif', 'jpeg', 'png'])->setAttribute('id', 'GrundIDInput')->setAttribute('class', 'inputFileHidden')

    );
    $actions = FieldList::create(
        FormAction::create('doStep10', 'Weiter')->addExtraClass('btn btn-primary')
    );
    $validator = RequiredFields::create([]);
    $form = Form::create($this, 'step10Form', $fields, $actions, $validator);
    if($apartment){
        $form->setFormAction('/apartment/doStep10/?apartmentID='.$apartment->ID);
    }else{
        $form->setFormAction('/apartment/doStep10');
    }
    return $form;
}
public function doStep10(HTTPRequest $request){
    $data = $request->postVars();
    $apartment = $this->getApartmentFromRequest($request);
    if($apartment){
        if ($img = $this->attachImageFromFiles('BilderID', 'apartments')) {
            $img->publishSingle();
            // set the correct relation column you have:
            $apartment->BilderID = $img->ID;
           
        }
        if ($img = $this->attachImageFromFiles('DocumentID', 'apartments')) {
            $img->publishSingle();
            // set the correct relation column you have:
            $apartment->DocumentID = $img->ID;
           
        }
        if ($img = $this->attachImageFromFiles('VideoID', 'apartments')) {
            $img->publishSingle();
            // set the correct relation column you have:
            $apartment->VideoID = $img->ID;
           
        }
        if ($img = $this->attachImageFromFiles('GrundID', 'apartments')) {
            $img->publishSingle();
            // set the correct relation column you have:
            $apartment->GrundID = $img->ID;
           
        }
        $apartment->write();
    }
    return $this->redirect('/apartment/step11?apartmentID='.$apartment->ID);
}

public function step11(HTTPRequest $request){
    $apartment = $this->getApartmentFromRequest($request);
    $form=$this->step11Form($apartment);
    if($apartment){
        $form->loadDataFrom($apartment);
    }
    return $this->customise([
        'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
        'Form'=>$form,
        'Objektzustand'=>$form->Fields()->dataFieldByName('Objektzustand'),
        'LetzteModernisierung'=>$form->Fields()->dataFieldByName('LetzteModernisierung'),
        'WesentlichterEnergietrager'=>$form->Fields()->dataFieldByName('WesentlichterEnergietrager'),
        'Heizungart'=>$form->Fields()->dataFieldByName('Heizungart'),
        'BaujahrDesGebaudes'=>$form->Fields()->dataFieldByName('BaujahrDesGebaudes'),
    ])->renderWith(['Layout/Broker/Apartment/step11', 'Page']);
}
public function step11Form($apartment = null){
    $fields = FieldList::create(
        TextField::create('Objektzustand', 'Objektzustand')->setTitle('Objektzustand'),
        DropdownField::create('LetzteModernisierung', 'Letzte Modernisierung',GlobalHelper::getYears())->setTitle('Letzte Modernisierung')->setEmptyString('LetzteModernisierung auswählen'),
        TextField::create('WesentlichterEnergietrager', 'Wesentlichter Energietrager')->setTitle('Wesentlichter Energietrager'),
        DropdownField::create('Heizungart', 'Heizungart',GlobalHelper::getHeizungsarten())->setTitle('Heizungart')->setEmptyString('Heizungart auswählen'),
        DropdownField::create('BaujahrDesGebaudes', 'Baujahr des Gebäudes',GlobalHelper::getModernizationYears())->setTitle('Baujahr des Gebäudes')->setEmptyString('BaujahrdesGebäudes auswählen'),
    );
    $actions = FieldList::create(
        FormAction::create('doStep11', 'Weiter')->addExtraClass('btn btn-primary')
    );
    $validator = RequiredFields::create([]);
    $form = Form::create($this, 'step11Form', $fields, $actions, $validator);
    if($apartment){
        $form->setFormAction('/apartment/doStep11/?apartmentID='.$apartment->ID);
    }else{
        $form->setFormAction('/apartment/doStep11');
    }
    return $form;
}
public function doStep11(HTTPRequest $request){
    $data = $request->postVars();
    $apartment = $this->getApartmentFromRequest($request);
    if($apartment){
        $apartment->Objektzustand = $data['Objektzustand'];
        $apartment->LetzteModernisierung = $data['LetzteModernisierung'];
        $apartment->WesentlichterEnergietrager = $data['WesentlichterEnergietrager'];
        $apartment->Heizungart = $data['Heizungart'];
        $apartment->BaujahrDesGebaudes = $data['BaujahrDesGebaudes'];
        $apartment->write();
    }
    return $this->redirect('/apartment/step12?apartmentID='.$apartment->ID);
}

public function step12(HTTPRequest $request){
    $apartment = $this->getApartmentFromRequest($request);
    $form=$this->step12Form($apartment);
    if($apartment){
        $form->loadDataFrom($apartment);
    }
    return $this->customise([
        'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
        'Form'=>$form,
        'Energieausweis'=>$form->Fields()->dataFieldByName('Energieausweis'),
        'Dieses'=>$form->Fields()->dataFieldByName('Dieses'),
        'EnergieausweisVor'=>$form->Fields()->dataFieldByName('EnergieausweisVor'),
    ])->renderWith(['Layout/Broker/Apartment/step12', 'Page']);
}
public function step12Form($apartment = null){
    $fields = FieldList::create(
        OptionsetField::create('Energieausweis', 'Energieausweis liegt zur Besigtigung vor',['Ja'=>'Ja','Nein'=>'Nein'])->setTitle('Energieausweis liegt zur Besigtigung vor')->setTemplate('OptionFieldSetTwocol'),
        OptionsetField::create('Dieses', 'Dieses Gebaude unterliegt den Anforderungen de GEG',['Ja'=>'Ja','Nein'=>'Nein'])->setTitle('Dieses Gebaude unterliegt den Anforderungen de GEG')->setTemplate('OptionFieldSetTwocol'),
        OptionsetField::create('EnergieausweisVor', 'Energieausweis liegt vor',['Ja'=>'Ja','Nein'=>'Nein'])->setTitle('Energieausweis liegt vor')->setTemplate('OptionFieldSetTwocol'),
       
    );
    $actions = FieldList::create(
        FormAction::create('doStep12', 'Weiter')->addExtraClass('btn btn-primary')
    );
    $validator = RequiredFields::create([]);
    $form = Form::create($this, 'step12Form', $fields, $actions, $validator);
    if($apartment){
        $form->setFormAction('/apartment/doStep12/?apartmentID='.$apartment->ID);
    }else{
        $form->setFormAction('/apartment/doStep12');
    }
    return $form;
}
public function doStep12(HTTPRequest $request){
    $data = $request->postVars();
    $apartment = $this->getApartmentFromRequest($request);
    if($apartment){
        $apartment->Energieausweis = $data['Energieausweis'];
        $apartment->Dieses = $data['Dieses'];
        $apartment->EnergieausweisVor = $data['EnergieausweisVor'];
        $apartment->write();
    }
    if(GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'owner' || GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'seller'){
        return $this->redirect('/apartment/preview?apartmentID='.$apartment->ID);
    }else
    return $this->redirect('/apartment/step13?apartmentID='.$apartment->ID);
}

public function step13(HTTPRequest $request){
  
    $apartment = $this->getApartmentFromRequest($request);
    if(GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'owner' || GlobalHelper::getCurrentUserSession($this->getRequest())->get('UserType') == 'seller'){
        return $this->redirect('/apartment/preview?apartmentID='.$apartment->ID);
    }
    $form=$this->step13Form($apartment);
    $form->loadDataFrom($apartment);
    $contacts=RentalWorkerInformation::get()
    ->filter('MemberID', $apartment->MemberID)
    ->sort('ID', 'ASC');
  
    return $this->customise([
        'Title' => 'Inserat erstellen zu Vermietung einer Wohnung',
        'Form'=>$form,
        'ContactId'=>$form->Fields()->dataFieldByName('ContactId'),
        'SelectedContact'=>$apartment->ContactId,
        'Contacts'=>$contacts,
    ])->renderWith(['Layout/Broker/Apartment/step13', 'Page']);
}

public function step13Form($apartment = null){
    $options = [];
    $member = Security::getCurrentUser();
    $contacts = RentalWorkerInformation::get()
        ->filter('MemberID', $member->ID)
        ->sort('ID', 'ASC');
        foreach ($contacts as $contact) {
       
            $options[$contact->ID] = $contact->Email; // value is just the ID
        }

    $fields = FieldList::create(
        OptionsetField::create('ContactId', 'Kontaktperson',$options)->setTitle('Kontaktperson')->setTemplate('OptionFieldsetContact'),
       
    );
    $actions = FieldList::create(
        FormAction::create('doStep13', 'Weiter')->addExtraClass('btn btn-primary')
    );
    $validator = RequiredFields::create(['ContactId']);
    $form = Form::create($this, 'step13Form', $fields, $actions, $validator);
    if($apartment){
        $form->setFormAction('/apartment/doStep13/?apartmentID='.$apartment->ID);
    }else{
        $form->setFormAction('/apartment/doStep13');
    }
    return $form;
}
public function doStep13(HTTPRequest $request){
    $data = $request->postVars();
    $apartment = $this->getApartmentFromRequest($request);
    
    if($apartment){
        //$apartment->Status='published';
        $apartment->ContactId = $data['ContactId'];
        
        $apartment->write();
        //$request->getSession()->set('ApartmentFlashMessage', 'Apartment has been added/updated successfully.');
    }
    return $this->redirect('/apartment/preview?apartmentID='.$apartment->ID);
}
public function doPayment(HTTPRequest $request){
    $data = $request->postVars();
    $apartment = $this->getApartmentFromRequest($request);
    $memberBasicData=MemberBasicData::get()->filter(['MemberID' => GlobalHelper::getLoggedInUser()->ID])->first();
    if($apartment){
        //if($data['PaymentType']=='Free'){
            $apartment->Status='published';
       // }
        //$apartment->PaymentType = $data['PaymentType'];
        
        $apartment->write();
        if($data['PaymentType']=='Kostenfrei vermieten'){
            $memberBasicData->PlanId=$data['PaymentType'];
            $memberBasicData->SubscriptionStatus='COMPLETED';
            $memberBasicData->ValidUntil=date('Y-m-d', strtotime('+5 year'));
            $memberBasicData->write();
            $request->getSession()->set('ApartmentFlashMessage', 'Apartment has been added/updated successfully.');
            
        }else{
            ([
                'Title' => 'Payment method',
                'Apartment'=>$apartment,
        'MemberBasicData' => $memberBasicData,
        'PaymentType'=>$request->postVar('PaymentType'),
        'plans'=>$plans,
        'planDetails'=>GlobalHelper::SelectedPlan($request->postVar('PaymentType'),'broker',0)
            ])->renderWith(['Layout/Payments/PaymentMethod', 'Page']);
        }
    }
    return $this->redirect('/apartment/listingcreated?apartmentID='.$apartment->ID);
    
}


public function listingcreated(HTTPRequest $request){
    $apartment = $this->getApartmentFromRequest($request);
    return $this->customise([
        'Title' => 'Listing created',
        'IsSubscriptionActive'=>GlobalHelper::getSubscriptionStatus(),
        'Apartment'=>$apartment,
    ])->renderWith(['Layout/Broker/Apartment/listingcreated', 'Page']);
}
public function preview(HTTPRequest $request){
    $apartment = $this->getApartmentFromRequest($request);
    $allOptions = [];
    $apartmentDetails = ApartmentDetail::get()->filter(['ID' => $apartment->DetailsID]);
    $checkSubscriptionStatus=GlobalHelper::getSubscriptionStatus();
    if($checkSubscriptionStatus=='Active'){
        if($apartment){
            $apartment->PaymentType=1;
            $apartment->Status='Published';
            $apartment->write();
        }
    }else
    {
        $apartment->Status='Published';
        $apartment->write();
    }
    foreach ($apartmentDetails as $detail) {
        // Loop through has_many DetailOptions relation
        foreach ($detail->DetailOptions() as $opt) {
            // Use Label and Value fields
            $allOptions[$opt->Label] = $opt->Label;
        }
    }
    $optionCounts = array_count_values($allOptions);
$contact = RentalWorkerInformation::get()->byID($apartment->ContactId);
    return $this->customise([
        'Title' => 'Überprüfen Sie Ihre Angaben',
        'Apartment'=>$apartment,
        'DetailOptions'=>$this->ssArray($optionCounts),
        'IsSubscriptionActive'=>GlobalHelper::getSubscriptionStatus(),
        'userType'=>GlobalHelper::getCurrentUserSession($request)->get('UserType'),
        'Contact'=>$contact,
    ])->renderWith(['Layout/Broker/Apartment/preview', 'Page']);
}
public function payment(HTTPRequest $request){
    $apartment = $this->getApartmentFromRequest($request);
    $memberBasicData=MemberBasicData::get()->filter(['MemberID' => GlobalHelper::getLoggedInUser()->ID])->first();
    $plans=GlobalHelper::getSubscriptionPlans('owner');
    return $this->customise([
        'Title' => 'Mietenprofi',
        'Apartment'=>$apartment,
        'Plans'=>$plans,
        'MemberBasicData'=>$memberBasicData,
    ])->renderWith(['Layout/Broker/Subscription', 'Page']);
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
    ])->renderWith(['Layout/Broker/Apartment/Subscription', 'Page']);
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
public function getContactsData()
{
    $member = Security::getCurrentUser();
    return RentalWorkerInformation::get()->filter('MemberID', $member->ID);
}
    // Inside ApartmentController
private function getApartmentFromRequest(HTTPRequest $request): Apartment|HTTPResponse|null
{
    $member = Security::getCurrentUser();
    if (!$member) {
        return null;
    }

    $id = (int) $request->getVar('apartmentID');
    if (!$id) {
        return null;
    }

    /** @var Apartment|null $apt */
    $apt = Apartment::get()->byID($id);
    if ($apt && (int)$apt->MemberID === (int)$member->ID) {
        return $apt;
    }
    return null;
}
private function attachImageFromFiles(string $field, string $folder = 'profiles'): ?File
{
    if (empty($_FILES[$field]) || empty($_FILES[$field]['tmp_name'])) {
        return null;
    }

    $upload = Upload::create();
    $upload->getValidator()->setAllowedExtensions([
        'jpg','jpeg','png','gif',
        'pdf',
        'avi','mov','mpg','mp4','mkv'
    ]);

    // Use generic File instead of Image
   
        $file = File::create();
   

    if ($upload->loadIntoFile($_FILES[$field], $file, $folder)) {
        return $file; // published later if you want
    }

    // Debug: $upload->getErrors()
    return null;
}
public function deleteFile(HTTPRequest $request): HTTPResponse
{
    // POST + CSRF
    if (!$request->isPOST() || !SecurityToken::inst()->checkRequest($request)) {
        return $this->jsonError('Invalid request', 400);
    }

    $member = Security::getCurrentUser();
    if (!$member) {
        return $this->jsonError('Unauthorized', 401);
    }

    $objectId = (int)$request->postVar('objectId');
    $field    = (string)$request->postVar('field');   // e.g. 'Bilder' or 'DocumentID'
    $fileID   = (int)$request->postVar('fileID');     // required for Bilder
    $deleteAsset = (int)$request->postVar('deleteAsset') === 1;

    /** @var Apartment|null $apartment */
    $apartment = Apartment::get()->byID($objectId);
    if (!$apartment) {
        return $this->jsonError('Apartment not found', 404);
    }

    // ---- A) many_many: Bilder ----
    if ($field === 'Bilder') {
        $list = $apartment->getManyManyComponents('Bilder');
        if (!$list) {
            return $this->jsonError('Bilder relation not found', 400);
        }
        if ($fileID <= 0) {
            return $this->jsonError('fileID required for Bilder', 422);
        }

        // Ensure the file is linked before removing
        $linked = $list->byID($fileID);
        if (!$linked) {
            return $this->jsonError('File not linked to this apartment', 404);
        }

        $list->removeByID($fileID); // unlink from relation only

        // Optionally remove asset from system
        if ($deleteAsset) {
            if ($file = File::get()->byID($fileID)) {
                if ($file->hasExtension(Versioned::class)) {
                    try { $file->doUnpublish(); } catch (\Throwable $e) {}
                }
                try { $file->deleteFile(); } catch (\Throwable $e) {}
                try { $file->delete(); } catch (\Throwable $e) {}
            }
        }

        return $this->jsonOk([
            'ok'         => true,
            'mode'       => 'many',
            'field'      => 'Bilder',
            'removedID'  => $fileID,
            'countLeft'  => $apartment->getManyManyComponents('Bilder')->count(),
        ]);
    }

    // ---- B) has_one fields (whitelist) ----
    $allowedHasOneColumns = ['DocumentID', 'VideoID', 'GrundID']; // add more if needed
    if (!in_array($field, $allowedHasOneColumns, true)) {
        return $this->jsonError('Invalid field', 422);
    }

    // Current file id on this column
    $currentID = (int)$apartment->{$field};
    if (!$currentID) {
        return $this->jsonOk(['ok' => true, 'message' => 'Nothing to delete', 'field' => $field]);
    }

    // If a fileID was provided, only clear if it matches
    if ($fileID && $fileID !== $currentID) {
        return $this->jsonError('File mismatch for this field', 409);
    }

    // Clear has_one
    $apartment->{$field} = 0;
    $apartment->write();

    if ($deleteAsset) {
        if ($file = File::get()->byID($currentID)) {
            if ($file->hasExtension(Versioned::class)) {
                try { $file->doUnpublish(); } catch (\Throwable $e) {}
            }
            try { $file->deleteFile(); } catch (\Throwable $e) {}
            try { $file->delete(); } catch (\Throwable $e) {}
        }
    }

    return $this->jsonOk([
        'ok'         => true,
        'mode'       => 'single',
        'field'      => $field,
        'clearedID'  => $currentID
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

public function getWorkerInformationByMember(){
    $member = Security::getCurrentUser();
    $memberID = $member->ID;

    return RentalWorkerInformation::get()
        ->filter('MemberID', $memberID)
        ->sort('ID', 'ASC');
}

public function SplitLabel($title) {
    $parts = explode('::', (string)$title, 2);
    return ArrayData::create([
        'Left'  => trim($parts[0] ?? ''), // e.g., email
        'Right' => trim($parts[1] ?? ''), // e.g., phone
    ]);
}

public function uploadFile(HTTPRequest $request): HTTPResponse
{
    if (!$request->isPOST() || !SecurityToken::inst()->checkRequest($request)) {
        return $this->jsonError('Invalid request', 400);
    }
   //return $this->jsonOk($_FILES['Bilder']);
    $member = Security::getCurrentUser();
    if (!$member) {
        return $this->jsonError('Unauthorized', 401);
    }
    $object = Apartment::get()->byID($request->postVar('objectID'));
    if (!$object) {
        return $this->jsonError('Worker not found or not yours', 404);
    }
    if ($img = $this->attachImageFromFilesObject($_FILES[$request->postVar('field')], 'apartments')) {
       
            $img->publishSingle();
            if ($request->postVar('field') === 'Bilder') {
                $object->Bilder()->add($img);             // many_many add
            }else{
                $object->{$request->postVar('field')} = $img->ID;
            }
            $object->write();
            return $this->jsonOk([
                'ok'  => true,
                'id'  => (int)$img->ID,
                'url' => $img->getURL()
            ]);
        
    }
    return $this->jsonError('File upload failed', 500);   
}
private function attachImageFromFilesObject($files, string $folder = 'apartments')
{
    if (empty($files) || empty($files['tmp_name'])) {
        return null;
    }

    $upload = Upload::create();
    $upload->getValidator()->setAllowedExtensions([
        'jpg','jpeg','png','gif',
        'pdf',
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
public function getDistrictbyCityAjax(HTTPRequest $request){
    $city = $request->getVar('city');
    $districts = GlobalHelper::getDistrictbycity($city);
    return json_encode($districts);
}
}
