<?php
namespace App\Model;

use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\Tab;
use SilverStripe\Forms\TabSet;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\GridField\GridFieldDetailForm;
use SilverStripe\Forms\GridField\GridFieldDeleteAction;
use SilverStripe\Forms\GridField\GridFieldEditButton;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\NumericField;
use SilverStripe\Forms\DateField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;
use SilverStripe\Assets\File;
use SilverStripe\Assets\Image;
use App\Model\ApartmentAddress;
use App\Model\ApartmentDetail;
use SilverStripe\Security\Security;
use SilverStripe\Control\Controller; // <-- needed to access current request
use SilverStripe\Forms\TextField;
use App\Helper\GlobalHelper;
use SilverStripe\Forms\CheckboxSetField;
use App\Model\ApartmentDetailOption;
use App\Model\RentalWorkerInformation;
class Apartment extends DataObject
{
    private static $table_name = 'Apartment';
    
    private static $db = [
        'ObjectNumber' => 'Varchar',
        'GroupNumber'  => 'Varchar',
        'WohnungType'  => 'Varchar',
        'Uberschrift'  => 'HTMLText',
        'Mietwohnung'  => 'HTMLText',
        'Dieumgebung'  => 'HTMLText',
        'ContactId'    => 'Int',
        'Objektzustand' => 'Varchar',
        'Heizungart'    => 'Varchar',
        'LetzteModernisierung'   => 'Varchar',
        'WesentlichterEnergietrager'   => 'Varchar',
        'BaujahrDesGebaudes'   => 'Varchar',
        'Energieausweis'   => 'Varchar',
        'Dieses'=>'Varchar',
        'EnergieausweisVor'=>'Varchar',
        'Internetgeschwindigkeit'=>'Varchar',
        'Energieeffiziezklasse'=>'Varchar',
        'Status'=>'Varchar',
        'PaymentType'=>'Int',
        'ViewCount'=>'Int',
    ];

    private static $has_one = [
        'Member'   => Member::class,
        'Video'    => File::class,  // VideoID
        'Document' => File::class,  // DocumentID
        'Grund'    => File::class,  // GrundID
        'Address'  => ApartmentAddress::class,
        'Details'  => ApartmentDetail::class,
    ];
     // 🔁 Multiple images:
     private static $many_many = [
        'Bilder' => File::class,
    ];
    private static array $has_many = [
        'Wishlists' => \App\Model\ApartmentWishlist::class,
        'Applications' => \App\Model\ApartmentApplication::class,
    ];
    private static $defaults = [
        'Status' => 'draft',
    ];
    private static $cascade_deletes = [
    'Address',
    'Details',
    'Bilder',
    'Wishlists',
    'Applications'
];


    // Ensures files publish with the Apartment
    private static $owns = ['Bilder','Video','Document','Grund','Address','Details'];
    private static $summary_fields = [
        'ID' => 'ID',
        'Address.Street' => 'Street',
        'ObjectNumber' => 'Object #',
        'GroupNumber' => 'Group #',
        'WohnungType' => 'Type',
        'Status' => 'Status',
        'ViewCount' => 'Views',
        'MemberName' => 'Created By', 
    ];
    private static $searchable_fields = [
        'ObjectNumber',
        'GroupNumber',
        'WohnungType',
        'Uberschrift',
        'Status'
    ];

    public function getWohnungTypeOptions(): array
{
    return [
        'Wohnung' => 'Wohnung',
        'WG Zimmer' => 'WG Zimmer',
        'Haus' => 'Haus',
        'Wohnung auf Zeit' => 'Wohnung auf Zeit',
        'Grage oder stellplatz'=>'Grage oder stellplatz'
        // add/remove options as needed
    ];
}
        /**
     * Return number of Bilder (useful for grid column).
     */
    public function getBilderCount()
    {
        return $this->Bilder()->count();
    }

    public function IsWishlist(): bool{
        $member = Security::getCurrentUser();
        if (!$member) {
            return false;
        }
        return ApartmentWishlist::get()
        ->filter([
            'MemberID' => $member->ID,
            'ApartmentID' => $this->ID,
        ])
        ->exists();
    }
    public function getMemberName()
    {
        if ($this->MemberID && $this->Member()->exists()) {
            return $this->Member()->FirstName . ' ' . $this->Member()->Surname;
        }
        return '';
    }

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
  // Remove the auto-generated has_one dropdown for Address (we use inline Address tab instead)
  $fields->removeByName(['AddressID', 'Address', 'DetailsID', 'Details','WohnungType','PaymentType','ViewCount','MemberID', 'Member','Video', 'VideoID', 'Document', 'DocumentID','Grund','GrundID']);
  // Add the dropdown to the Main tab (or any other tab you prefer)
$fields->addFieldToTab('Root.Main',
DropdownField::create(
    'WohnungType',
    'Wohnung Type',
    $this->getWohnungTypeOptions()
)->setEmptyString('-- select type --')
);
        // Ensure a Root tabset exists
           // Ensure Root exists and create Main tab
    if (!$fields->fieldByName('Root')) {
        $fields->push(TabSet::create('Root'));
    }

    // Recreate Main tab and add fields in desired order
    if (!$fields->fieldByName('Root.Main')) {
        $fields->addFieldToTab('Root', Tab::create('Main'));
    }
    $contacts = RentalWorkerInformation::get()
    ->filter('MemberID', $this->MemberID)
    ->sort('ID', 'ASC');
    $contactOptions=[];
    foreach ($contacts as $contact) {
   
        $contactOptions[$contact->ID] = $contact->FirstName.' '.$contact->LastName.' ('.$contact->Email.')'; // value is just the ID
    }
    // Add fields in the exact order you want them displayed in the CMS Main tab:
    $mainFields = [
        TextField::create('ObjectNumber', 'Object Number'),
        TextField::create('GroupNumber', 'Group Number'),
        // WohnungType as dropdown using the centralized options method
        DropdownField::create('WohnungType', 'Wohnung Type', $this->getWohnungTypeOptions())->setEmptyString('-- select type --'),
        HTMLEditorField::create('Uberschrift', 'Überschrift'),
        HTMLEditorField::create('Mietwohnung', 'Mietwohnung'),
        HTMLEditorField::create('Dieumgebung', 'Die Umgebung'),
        DropdownField::create('ContactId', 'Contact ID',$contactOptions)->setEmptyString('-- select contact --'),
        TextField::create('Objektzustand', 'Objektzustand'),
        DropdownField::create('Heizungart', 'Heizungsart',GlobalHelper::getHeizungsarten())->setTitle('Heizungart')->setEmptyString('Heizungart auswählen'),
        DropdownField::create('LetzteModernisierung', 'Letzte Modernisierung',GlobalHelper::getYears())->setTitle('Letzte Modernisierung')->setEmptyString('LetzteModernisierung auswählen'),
        TextField::create('WesentlichterEnergietrager', 'Wesentlicher Energieträger'),
        DropdownField::create('BaujahrDesGebaudes', 'Baujahr des Gebäudes',GlobalHelper::getModernizationYears())->setTitle('Baujahr des Gebäudes')->setEmptyString('Baujahr des Gebäudes auswählen'),
        DropdownField::create('Energieausweis', 'Energieausweis',['Ja' => 'Ja','Nein' => 'Nein']),
        DropdownField::create('Dieses', 'Dieses',['Ja' => 'Ja','Nein' => 'Nein']),
        DropdownField::create('EnergieausweisVor', 'Energieausweis Vor',['Ja' => 'Ja','Nein' => 'Nein']),
        DropdownField::create('Internetgeschwindigkeit', 'Internetgeschwindigkeit',['Alle Geschwindigkiet'=>'Alle Geschwindigkiet:','Mind. 100 Mbit/s'=>'Mind. 100 Mbit/s:','Mind. 250 Mbit/s'=>'Mind. 250 Mbit/s:','Mind 1000 Mbit/s'=>'Mind 1000 Mbit/s:'])->setEmptyString('-- select --'),
        DropdownField::create('Energieeffiziezklasse', 'Energieeffizienzklasse',['A'=>'A','B'=>'B','C'=>'C','D+'=>'D+'])->setEmptyString('-- select --'),
        DropdownField::create('Status', 'Status', [
            'draft' => 'Draft',
            'published' => 'Published'
        ])->setEmptyString('-- select status --')
    ];

    // Remove any existing Main tab fields so we can control order precisely
    $fields->removeByName($this->getFieldNamesInList($mainFields));
    $fields->addFieldsToTab('Root.Main', $mainFields);

        // Add / ensure Media tab
        if (!$fields->fieldByName('Root.Bilder')) {
            $fields->addFieldToTab('Root', Tab::create('Bilder'));
        }

        // Upload field for Bilder (your existing code)
        $upload = UploadField::create('Bilder', 'Bilder (Files)')
            ->setFolderName('Apartments/Bilder')
            ->setAllowedMaxFileNumber(50)
            ->setDescription('Upload files for this apartment. You can edit metadata per file or delete them.');

        $upload->getValidator()->setAllowedExtensions([
            'jpg','jpeg','png','gif','pdf','doc','docx','mp4','mov','webm'
        ]);

        if (method_exists($upload, 'getConfig')) {
            $config = $upload->getConfig();

            if (!$config->getComponentByType(GridFieldDetailForm::class)) {
                $config->addComponent(new GridFieldDetailForm());
            }
            if (!$config->getComponentByType(GridFieldEditButton::class)) {
                $config->addComponent(new GridFieldEditButton());
            }
            if (!$config->getComponentByType(GridFieldDeleteAction::class)) {
                $config->addComponent(new GridFieldDeleteAction());
            }
        } else {
            $config = GridFieldConfig_RecordEditor::create();
            $config->addComponent(new GridFieldDetailForm());
            $config->addComponent(new GridFieldEditButton());
            $config->addComponent(new GridFieldDeleteAction());

            if (method_exists($upload, 'setConfig')) {
                $upload->setConfig($config);
            }
        }

        $fields->addFieldToTab('Root.Bilder', $upload);

        /*
         * === ADDRESS TAB (inline editing) ===
         * Prefixed field names (AddressStreet, AddressNr, etc.)
         * so they don't collide with Apartment DB fields.
         */

        // Ensure Address tab exists
        if (!$fields->fieldByName('Root.Address')) {
            $fields->addFieldToTab('Root', Tab::create('Address'));
        }

        // Load the related address (may be null)
        $address = $this->Address();

        // Add text fields for address (prefixed)
        $fields->addFieldsToTab('Root.Address', [
            TextField::create('AddressStreet', 'Street')->setValue($address ? $address->Street : null),
            TextField::create('AddressNr', 'Nr')->setValue($address ? $address->Nr : null),
            TextField::create('AddressPlz', 'PLZ')->setValue($address ? $address->Plz : null),
            TextField::create('AddressOrt', 'Ort')->setValue($address ? $address->Ort : null),
            DropdownField::create('AddressStrasseundHausnummer', 'Strasse und Hausnummer',['Ja' => 'Ja','Nein' => 'Nein'])->setValue($address ? $address->StrasseundHausnummer : null),
            DropdownField::create('AddressStadt', 'Stadt',GlobalHelper::getCities())->setValue($address ? $address->Stadt : null),
            TextField::create('AddressLat', 'Lat')->setValue($address ? $address->Lat : null),
            TextField::create('AddressLng', 'Lng')->setValue($address ? $address->Lng : null),
            DropdownField::create('AddressStadtteil', 'Stadtteil',GlobalHelper::getDistrict())->setValue($address ? $address->Stadtteil : null),
        ]);

        // === DETAILS TAB (inline editing) ===
if (!$fields->fieldByName('Root.Details')) {
    $fields->addFieldToTab('Root', Tab::create('Details'));
}

// Load related detail object (if exists)
$details = $this->Details();


// Preselected values: if details exists, get related IDs (has_many)
$selected = $details->DetailOptions()->column('Label'); // or 'Code' if you have one

// Add Checkbox set (prefixed name)
$detailOptionsfield = CheckboxSetField::create(
    'DetailOptionsSelected',     // form field name (prefixed)
    'Detail Options',            // label
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
)->setValue($selected);

// Add the checkbox set to the Details tab (add it along with other detail fields)
//$fields->addFieldToTab('Root.Details', $checkbox);
// Add form fields for Details (prefixed)
$fields->addFieldsToTab('Root.Details', [
    TextField::create('DetailWohnflache', 'Wohnfläche (m²)')->setValue($details?->Wohnflache),
    DropdownField::create('DetailZimmer', 'Zimmer',[1,2,3,4,'5 und mehr'])->setValue($details?->Zimmer),
    TextField::create('DetailKaltmiete', 'Kaltmiete')->setValue($details?->Kaltmiete),
    DateField::create('DetailFloorVerfugbarAb', 'Verfügbar ab')->setValue($details?->FloorVerfugbarAb)->setHTML5(true),
    TextField::create('DetailNebenkosten', 'Nebenkosten')->setValue($details?->Nebenkosten),
    TextField::create('DetailKaution', 'Kaution')->setValue($details?->Kaution),
    TextField::create('DetailGesamtmiete', 'Gesamtmiete')->setValue($details?->Gesamtmiete),
    DropdownField::create('DetailQualitatDerWohnung', 'Qualität der Wohnung',[
        'Neubau'  => 'Neubau',
        'Einfach' => 'Einfach',
        'Gehoben' => 'Gehoben',
        'Normal'  => 'Normal',
        'Luxe'    => 'Luxe',
    ])->setValue($details?->QualitatDerWohnung),

    // Additional (new) fields
    TextField::create('DetailSchlafzimmer', 'Schlafzimmer')->setValue($details?->Schlafzimmer),
    TextField::create('DetailBadezimmer', 'Badezimmer')->setValue($details?->Badezimmer),
    TextField::create('DetailEtage', 'Etage')->setValue($details?->Etage),
    TextField::create('DetailVon', 'Von')->setValue($details?->Von),
    TextField::create('DetailNutzflache', 'Nutzfläche')->setValue($details?->Nutzflache),
    DropdownField::create('DetailWohnberechtigungsschein', 'Wohnberechtigungsschein', [
        'Erforderlich' => 'Erforderlich',
        'Nichterforderlich' => 'Nichterforderlich',
    ])->setValue($details?->Wohnberechtigungsschein),
    DropdownField::create('DetailHeizungsart', 'Heizungsart',[
        'Etagenheizung' => 'Etagenheizung',
        'Zentralheizung' => 'Zentralheizung',
    ])->setValue($details?->Heizungsart),
    $detailOptionsfield
]);

        return $fields;
    }

    /**
     * Create or update the ApartmentAddress record from the prefixed Address* fields.
     * Reads from POST because the prefixed fields are not DB fields on Apartment.
     */
    protected function onBeforeWrite()
    {
        parent::onBeforeWrite();

        // Get current request safely
        $request = Controller::curr() ? Controller::curr()->getRequest() : null;
        if (!$request) {
            return;
        }

        $post = $request->postVars();

        // Mappings: form key => ApartmentAddress field
        $keys = [
            'AddressStreet' => 'Street',
            'AddressNr' => 'Nr',
            'AddressPlz' => 'Plz',
            'AddressOrt' => 'Ort',
            'AddressStrasseundHausnummer' => 'StrasseundHausnummer',
            'AddressStadt' => 'Stadt',
            'AddressStadtteil' => 'Stadtteil',
            'AddressLat' => 'Lat',
            'AddressLng' => 'Lng',
        ];

        // Check if any address data present in POST
        $hasAddressData = false;
        foreach (array_keys($keys) as $k) {
            if (array_key_exists($k, $post)) {
                $hasAddressData = true;
                break;
            }
        }
        if (!$hasAddressData) {
            return;
        }

        // Load existing or create new ApartmentAddress
        $address = $this->Address();
        if (!$address || !$address->exists()) {
            $address = ApartmentAddress::create();
        }

        // Copy values from POST into the ApartmentAddress object
        foreach ($keys as $formKey => $addressField) {
            if (array_key_exists($formKey, $post)) {
                $address->{$addressField} = $post[$formKey];
            }
        }

        // Save and attach
        $address->write();
        $this->AddressID = $address->ID;
           /**
     * === DETAILS SAVE ===
     */
    $detailKeys = [
        'DetailWohnflache' => 'Wohnflache',
        'DetailZimmer' => 'Zimmer',
        'DetailKaltmiete' => 'Kaltmiete',
        'DetailFloorVerfugbarAb' => 'FloorVerfugbarAb',
        'DetailNebenkosten' => 'Nebenkosten',
        'DetailKaution' => 'Kaution',
        'DetailGesamtmiete' => 'Gesamtmiete',
        'DetailQualitatDerWohnung' => 'QualitatDerWohnung',
        'DetailSchlafzimmer' => 'Schlafzimmer',
        'DetailBadezimmer' => 'Badezimmer',
        'DetailEtage' => 'Etage',
        'DetailVon' => 'Von',
        'DetailNutzflache' => 'Nutzflache',
        'DetailWohnberechtigungsschein' => 'Wohnberechtigungsschein',
        'DetailHeizungsart' => 'Heizungsart',
    ];
    if (array_intersect_key($post, $detailKeys)) {
        $details = $this->Details() && $this->Details()->exists()
            ? $this->Details()
            : ApartmentDetail::create();
        foreach ($detailKeys as $formKey => $dbField) {
            if (isset($post[$formKey])) {
                $details->$dbField = $post[$formKey];
            }
        }
        $details->write();
        $this->DetailsID = $details->ID;
    }
    }
    protected function getFieldNamesInList(array $fieldObjects): array
{
    $names = [];
    foreach ($fieldObjects as $f) {
        // If caller passed a plain string name, keep it
        if (is_string($f)) {
            $names[] = $f;
            continue;
        }

        // If it's an object with getName(), call it
        if (is_object($f) && method_exists($f, 'getName')) {
            $names[] = $f->getName();
            continue;
        }

        // Fallback: try property 'name'
        if (is_object($f) && isset($f->name)) {
            $names[] = $f->name;
        }
    }

    return $names;
}
}