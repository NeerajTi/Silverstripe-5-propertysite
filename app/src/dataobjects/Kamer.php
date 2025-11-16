<?php
namespace {

	use SilverStripe\ORM\DataObject;
	use SilverStripe\Forms\HeaderField;
	use SilverStripe\Forms\HiddenField;
	use SilverStripe\Forms\TextField;
	use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
	use SilverStripe\Forms\ReadonlyField;
	use SilverStripe\Forms\CheckboxField;
	use SilverStripe\Forms\DropdownField;
	use SilverStripe\Control\Controller;
	use SilverStripe\View\Parsers\URLSegmentFilter;
	use SilverStripe\Subsites\Model\Subsite;
	use SilverStripe\Subsites\State\SubsiteState;	

	class Kamer extends DataObject {

		private static $db = array(
			'Title' => 'Text',
			'AffiliateLink' => 'Text',
			'AffiliateImage' => 'Text',
			'AffiliateImage2' => 'Text',
			'AffiliateImage3' => 'Text',
			'AffiliateImage4' => 'Text',
			'AffiliateImage5' => 'Text',
			'AffiliateImage6' => 'Text',
			'AffiliateImage7' => 'Text',
			'AffiliateImage8' => 'Text',
			'AffiliateImage9' => 'Text',
			'AffiliateImage10' => 'Text',
			'AffiliateImage11' => 'Text',
			'AffiliateImage12' => 'Text',
			'AffiliateImage13' => 'Text',
			'AffiliateImage14' => 'Text',
			'AffiliateImage15' => 'Text',
			'AffiliateImage16' => 'Text',
			'AffiliateImage17' => 'Text',
			'AffiliateImage18' => 'Text',
			'AffiliateImage19' => 'Text',
			'AffiliateImage20' => 'Text',
			'AffiliateImage21' => 'Text',
			'AffiliateImage22' => 'Text',
			'AffiliateImage23' => 'Text',
			'Description' => 'HTMLText',
			'Price' => 'Int',
			'Address' => 'Text',
			'City' => 'Text',
			'Area' => 'Text',
			'typeLabel' => 'Text',
			'kindLabel' => 'Text',
			'Zipcode' => 'Text',
			'Latitude' => 'Text',
			'Longitude' => 'Text',
			'Zipcode' => 'Text',
			'AffiliateProvider' => 'Text',
			'DateImported' => 'Text',
			'IsImported' => 'Boolean',
			'URLSegment' => 'Text',
			'Time' => 'Text',
			'MapsImage' => 'Text',
			'TypeKamer' => 'Text',
			'Oppervlakte' => 'Text',
			'EchteOppervlakte' => 'Text',
			'bedroomSize' => 'Text',
			'availableFromdate' => 'Date',
			
		);

		private static $has_one = array(
			'KamerOverzicht' => 'KamerOverzicht',
			'Subsite' => Subsite::class
		);

		private static $summary_fields = array(
			'Title' => 'Straat',
			'Area' => 'Gebied',
			'Latitude' => 'Latitude',
			'Longitude' => 'Longitude',
			'City' => 'Stad',
		);		

		private static $has_many = array(
		);

		public function getCMSFields() {
			$fields = parent::getCMSFields();

			if(class_exists('Subsite')){
				$fields->push(new HiddenField('SubsiteID','SubsiteID', Subsite::currentSubsiteID()));
			}
			// $fields->addFieldToTab("Root.Main", DropdownField::create('TypeKamer', 'Type kamer - filter', array("1" => "Kamer", "2" => "Studio", "3" => "Appartement"))->setEmptyString('(Kamer type)'));
			$fields->addFieldToTab("Root.Main", DropdownField::create('Oppervlakte', 'Oppervlakte - filter', array("1" => "Bis 10m²", "2" => "10+ m²", "3" => "30+ m²", "4" => "60+ m²", "5" => "90+ m²"))->setEmptyString('(Oppervlakte)'));

			$fields->addFieldToTab('Root.Main', HeaderField::create('Data','Gegevens'));
			$fields->addFieldToTab('Root.Main', TextField::create('KindLabel', 'KindLabel'));
			$fields->addFieldToTab('Root.Main', TextField::create('Title', 'Titel'));
			$fields->addFieldToTab('Root.Main', ReadOnlyField::create('URLSegment', 'URL segment'));
			$fields->addFieldToTab('Root.Main', HTMLEditorField::create('Description', 'Beschrijving'));
			$fields->addFieldToTab('Root.Main', TextField::create('Price', 'Prijs'));
			$fields->addFieldToTab('Root.Main', TextField::create('Address', 'Adres'));
			$fields->addFieldToTab('Root.Main', TextField::create('City', 'Stad'));
			$fields->addFieldToTab('Root.Main', TextField::create('Area', 'Gebied'));
			$fields->addFieldToTab('Root.Main', TextField::create('Type', 'Type'));
			$fields->addFieldToTab('Root.Main', TextField::create('Zipcode', 'Postcode'));
			$fields->addFieldToTab('Root.Main', TextField::create('Latitude', 'Latitude'));
			$fields->addFieldToTab('Root.Main', TextField::create('Longitude', 'Longitude'));
			$fields->addFieldToTab('Root.Main', HeaderField::create('Affiliate','Affiliate'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateProvider', 'Affiliate provider'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateLink', 'Affiliate link'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage', 'Affiliate afbeelding'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage2', 'Affiliate afbeelding 2'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage3', 'Affiliate afbeelding 3'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage4', 'Affiliate afbeelding 4'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage5', 'Affiliate afbeelding 5'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage6', 'Affiliate afbeelding 6'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage7', 'Affiliate afbeelding 7'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage8', 'Affiliate afbeelding 8'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage9', 'Affiliate afbeelding 9'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage10', 'Affiliate afbeelding 10'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage11', 'Affiliate afbeelding 11'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage12', 'Affiliate afbeelding 12'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage13', 'Affiliate afbeelding 13'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage14', 'Affiliate afbeelding 14'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage15', 'Affiliate afbeelding 15'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage16', 'Affiliate afbeelding 16'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage17', 'Affiliate afbeelding 17'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage18', 'Affiliate afbeelding 18'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage19', 'Affiliate afbeelding 19'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage20', 'Affiliate afbeelding 20'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage21', 'Affiliate afbeelding 21'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage22', 'Affiliate afbeelding 22'));
			$fields->addFieldToTab('Root.Main', TextField::create('AffiliateImage23', 'Affiliate afbeelding 23'));
			$fields->addFieldToTab('Root.Main', TextField::create('DateImported', 'Datum geïmporteerd'));
			$fields->addFieldToTab('Root.Main', TextField::create('Time', 'Laatst gewijzigd'));
			$fields->addFieldToTab('Root.Main', TextField::create('MapsImage', 'Maps afbeelding'));
			$fields->addFieldToTab('Root.Main', CheckboxField::create('IsImported', 'Is geïmporteerd'));

			$fields->removeFieldFromTab('Root.Main','KamerOverzichtID');

			return $fields;
		}

		public function onBeforeWrite() {
		parent::onBeforeWrite();
			//Generate URLSegment
			$filter = URLSegmentFilter::create();
			$this->URLSegment = $this->zipcode .'-'.  $this->address .'-'. $this->city;
			$this->URLSegment = $filter->filter($this->URLSegment);
			if (!$this->URLSegment) {
				$this->URLSegment = uniqid();
			}
			$count = 2;
			while (static::get_by_url_segment($this->URLSegment, $this->ID)) {
				// add a -n to the URLSegment if it already existed
				$this->URLSegment = preg_replace('/-[0-9]+$/', null, $this->URLSegment) . '-' . $count;
				$count++;
			}
		}

		protected static $_cached_get_by_url = array();

		public static function get_by_url_segment($str, $excludeID = null) {
			if (!isset(static::$_cached_get_by_url[$str])) {
				$list = static::get()->filter('URLSegment', $str);
				if ($excludeID) {
					$list = $list->exclude('ID', $excludeID);
				}
				$obj = $list->First();
				static::$_cached_get_by_url[$str] = ($obj && $obj->exists()) ? $obj : false;
			}
			return static::$_cached_get_by_url[$str];
		}

		public function Link() {
			if ($this->isInDB()) {
				return Controller::join_links($this->KamerOverzicht()->Link(), 'kamer', $this->URLSegment);
			}
			return '';
		}

		function AbsoluteLink() {
			return Director::absoluteURL($this->Link());
		}
	}
}
