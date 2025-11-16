<?php
namespace {

	use SilverStripe\ORM\PaginatedList;
	use SilverStripe\Forms\Form;
	use SilverStripe\Forms\FieldList;
	use SilverStripe\Forms\FormAction;
	use SilverStripe\Forms\HeaderField;
	use SilverStripe\Forms\DropdownField;
	use SilverStripe\Forms\TextField;
	use SilverStripe\Forms\LiteralField;
	use SilverStripe\Forms\CheckboxSetField;
	use SilverStripe\ORM\Filters;
	use SilverStripe\Subsites\Model\Subsite;
	use SilverStripe\Subsites\State\SubsiteState;
	use SilverStripe\SiteConfig\SiteConfig;
	use SilverStripe\Assets\Image;
	use SilverStripe\Assets\Storage\AssetStore;
	use SilverStripe\AssetAdmin\Forms\UploadField;
	use SilverStripe\Control\Director;
    use App\Model\Apartment;
	class HomePage extends Page {

		private static $db = [
			'PageTitle' => 'Varchar(255)',
		];

		private static $has_one = [
			'Afbeelding' => Image::class
		];

		private static $owns = [
			'Afbeelding',
		];

		public function getCMSFields()
		{
			$fields = parent::getCMSFields();

			$fields->addFieldToTab("Root.Main", TextField::create('PageTitle', 'Pagina titel'), 'Content');
			$fields->addFieldToTab("Root.Main", $Afbeelding = UploadField::create('Afbeelding', 'Banner'), 'Content');
			$Afbeelding->setAllowedExtensions(array('jpg', 'jpeg', 'png', 'gif', 'webp'));
			$Afbeelding->setAllowedMaxFileNumber(1);
			$Afbeelding->setFolderName('Banner');

			return $fields;
		}

	}
	class HomePageController extends PageController {

		public function index() {
			$request = $this->getRequest();
			$SiteConfig = SiteConfig::current_site_config();
			//$FilterWoord = 	$SiteConfig->Stad ;

			 //       $Kamers = Kamer::get()->filter(array('City'=> $FilterWoord))->limit(10);
			 //$Projecten = Kamer::get()->filter(array('City'=> $FilterWoord));

			// if($PriceMin = $request->getVar('minprijs')) {
			// 	$Projecten = $Projecten->filter([
			// 		"Price:GreaterThanOrEqual" => $PriceMin
			// 	]);
			// }

			// if($PriceMax = $request->getVar('maxprijs')) {
			// 	$Projecten = $Projecten->filter([
			// 		"Price:LessThanOrEqual" => $PriceMax
			// 	]);
			// }

			// if($kindLabel = $request->getVar('kindLabel')) {
			// 	$Projecten = $Projecten->filter([
			// 		"kindLabel:PartialMatch" => $kindLabel
			// 	]);
			// };

			// if($OppervlakteID = $request->getVar('Oppervlakte')){
			// 	$Projecten = $Projecten->filter([
			// 		"Oppervlakte:PartialMatch" => $OppervlakteID
			// 	]);
			// };
			$apartments = Apartment::get()->filter('Status', 'published')->sort('PaymentType', 'DESC')->sort('Created', 'DESC');
			$ProjectenPaginated = PaginatedList::create(
				$apartments,
				$request
			)->setPageLength(15);

			$data = [
				'Apartments' => $ProjectenPaginated,
			];

			if ($request->isAjax()) {
				return $this->customise($data)->renderWith('Layout/HomePage');
			}
			return $data;
		}

		public function ProjectenResultsForm() {
			$searchfields = FieldList::create(
				DropdownField::create('minprijs', "Minimumprijs", array( "0" => "Minimaler Preis", "300" => "300", "400" => "400", "500" => "500", "600" => "600", "700" => "700", "800" => "800", "900" => "900", "1000" => "1000", "1100" => "1100", "1200" => "1200", "1300" => "1300", "1400" => "1400" ), "1"),
				DropdownField::create('maxprijs', "Maximumprijs", array( "300" => "300", "400" => "400", "500" => "500", "600" => "600", "700" => "700", "800" => "800", "900" => "900", "1000" => "1000", "1100" => "1100", "1200" => "1200", "1300" => "1300", "1400" => "1400" ), "1")->setEmptyString('Höchstpreis'),

				CheckboxSetField::create('kindLabel', "Zimmertyp", array( "shared room" => "Mehrbettzimmer", "private room" => "WG-Zimmer", "entire place" => "Gesamte Wohnung")),
				CheckboxSetField::create('Oppervlakte', "Oberfläche", array( "1" => "Bis 10m²", "2" => "10+ m²", "3" => "20+ m²", "4" => "30+ m²", "5" => "40+ m²", "6" => "50+ m²"))
			);

			$actions = FieldList::create(
				FormAction::create('FilterAction','Filter')->addExtraClass('btn btn-uitgelicht'),
				LiteralField::create('reset', '<a href="'.$this->Link().'" class="btn btn-uitgelicht-outline reset">Sich erholen <i class="fa fa-undo"></i></a>')
			);

			$form = Form::create(
				$this,
				'ProjectenResultsForm',
				$searchfields,
				$actions
			);
			$form->setFormMethod('GET')->setFormAction($this->Link())->disableSecurityToken()->loadDataFrom($this->getRequest()->getVars());
			return $form;
		}
		public function ProjectenResultsForm2() {
			$searchfields = FieldList::create(
				DropdownField::create('minprijs', "Minimumprijs", array( "0" => "Preis von", "300" => "300", "500" => "500", "700" => "700", "900" => "900", "1100" => "1100", "1300" => "1300", "1600" => "1600" ), "1"),
				DropdownField::create('maxprijs', "Maximumprijs", array( "600" => "600", "800" => "800", "1000" => "1000", "1200" => "1200", "1500" => "1500", "1900" => "1900", "9999" => "> 1900" ), "1")->setEmptyString('Preis bis'),

				DropdownField::create('kindLabel', "Zimmertyp", array( "shared room" => "Mehrbettzimmer", "private room" => "WG-Zimmer", "entire place" => "Gesamte Wohnung"))->setEmptyString('Wohnungstyp'),
				DropdownField::create('Oppervlakte', "Oberfläche", array( "1" => "Bis 10m²", "2" => "10+ m²", "3" => "30+ m²", "4" => "60+ m²", "5" => "90+ m²"))->setEmptyString('Wohnfläche'),
				FormAction::create('FilterAction','Suchen')->addExtraClass('btn btn-uitgelicht')
			);

			$actions = FieldList::create(
				LiteralField::create('reset', '<a href="'.$this->Link().'" class="btn btn-uitgelicht-outline reset">Sich erholen <i class="fa fa-undo"></i></a>')
			);

			$form = Form::create(
				$this,
				'ProjectenResultsForm',
				$searchfields,
				$actions
			);
			$siteConfig = SiteConfig::current_site_config();
			$filterWoord = strtolower($siteConfig->FilterWoord);
			$redirectURL = 'wohnung-mieten-' . $filterWoord ;
			$form->setFormMethod('GET')->setFormAction(Director::baseURL() . $redirectURL)->disableSecurityToken()->loadDataFrom($this->getRequest()->getVars());


			return $form;
		}



		private static $allowed_actions = array (
		);

		public function init() {
			parent::init();
			// You can include any CSS or JS required by your project here.
			// See: http://doc.silverstripe.org/framework/en/reference/requirements
		}
	}
}
