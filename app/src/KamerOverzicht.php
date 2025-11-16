<?php
namespace {

	use SilverStripe\Forms\Form;
	use SilverStripe\Forms\HeaderField;
	use SilverStripe\Forms\LiteralField;
	use SilverStripe\Forms\FieldList;
	use SilverStripe\Forms\DropdownField;
	use SilverStripe\Forms\CheckboxSetField;
	use SilverStripe\Forms\FormAction;
	use SilverStripe\Forms\GridField\GridField;
	use SilverStripe\Forms\GridField\GridFieldConfig;
	use SilverStripe\Forms\GridField\GridFieldToolbarHeader;
	use SilverStripe\Forms\GridField\GridFieldAddNewButton;
	use SilverStripe\Forms\GridField\GridFieldSortableHeader;
	use SilverStripe\Forms\GridField\GridFieldDataColumns;
	use SilverStripe\Forms\GridField\GridFieldPaginator;
	use SilverStripe\Forms\GridField\GridFieldEditButton;
	use SilverStripe\Forms\GridField\GridFieldDeleteAction;
	use SilverStripe\Forms\GridField\GridFieldDetailForm;
	use SilverStripe\Control\HTTPRequest;
	use SilverStripe\Core\Convert;
	use SilverStripe\ErrorPage\ErrorPage;
	use SilverStripe\Subsites\Model\Subsite;
	use SilverStripe\Subsites\State\SubsiteState;
	use SilverStripe\ORM\PaginatedList;
	use SilverStripe\SiteConfig\SiteConfig;
	use SilverStripe\Control\Director;

	class KamerOverzicht extends Page {

		private static $db = array(
		);

		private static $has_one = array(
		);

		private static $has_many = array(
			"Kamer" => "Kamer"
		);

		function getCMSFields() {
			$fields = parent::getCMSFields();

			$gridFieldConfigMerk = GridFieldConfig::create()->addComponents(
				new GridFieldToolbarHeader(''),
				new GridFieldAddNewButton('toolbar-header-right'),
				new GridFieldSortableHeader(),
				new GridFieldDataColumns(),
				new GridFieldPaginator(10),
				new GridFieldEditButton(),
				new GridFieldDeleteAction(''),
				new GridFieldDetailForm()
			);
			$gridFieldMerk= new GridField("Kamer", "Kamer", $this->Kamer(), $gridFieldConfigMerk);
			$fields->addFieldToTab('Root.Main', $gridFieldMerk, 'Content');

			return $fields;
		}
	}

	class KamerOverzichtController extends PageController {

		/**
		 * An array of actions that can be accessed via a request. Each array element should be an action name, and the
		 * permissions or conditions required to allow the user to access it.
		 *
		 * <code>
		 * array (
		 *     'action', // anyone can access this action
		 *     'action' => true, // same as above
		 *     'action' => 'ADMIN', // you must have ADMIN permissions to access this action
		 *     'action' => '->checkAction' // you can only access this action if $this->checkAction() returns true
		 * );
		 * </code>
		 *
		 * @var array
		 */
		public static $current_product_id;
		private static $allowed_actions = array (
			'kamer'
		);

		public function index() {
			$request = $this->getRequest();
			$SiteConfig = SiteConfig::current_site_config();
			$FilterWoord = 	$SiteConfig->Stad ;

			// $Projecten = Kamer::get()->filter(array('SubsiteID'=>SubsiteState::singleton()->getSubsiteId()));
			 $Projecten = Kamer::get()->filter(array('City'=> $FilterWoord));
			// $Projecten = Kamer::get();
			if($PriceMin = $request->getVar('minprijs')) {
				$Projecten = $Projecten->filter([
					"Price:GreaterThanOrEqual" => $PriceMin
				]);
			}

			if($PriceMax = $request->getVar('maxprijs')) {
				$Projecten = $Projecten->filter([
					"Price:LessThanOrEqual" => $PriceMax
				]);
			}

			if($kindLabel = $request->getVar('kindLabel')) {
				$Projecten = $Projecten->filter([
					"kindLabel:PartialMatch" => $kindLabel
				]);
			};

			if($OppervlakteID = $request->getVar('Oppervlakte')){
				$Projecten = $Projecten->filter([
					"Oppervlakte:PartialMatch" => $OppervlakteID
				]);
			};

			$ProjectenPaginated = PaginatedList::create(
				$Projecten,
				$request
			)->setPageLength(15);

			$data = [
				'Projecten' => $ProjectenPaginated,
			];

			if ($request->isAjax()) {
				return $this->customise($data)->renderWith('Layout/KamerOverzicht');
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
				DropdownField::create('minprijs', "Minimumprijs", array( "0" => "Preis Von", "300" => "300", "500" => "500", "700" => "700", "900" => "900", "1100" => "1100", "1300" => "1300", "1600" => "1600" ), "1"),
				DropdownField::create('maxprijs', "Maximumprijs", array( "600" => "600", "800" => "800", "1000" => "1000", "1200" => "1200", "1500" => "1500", "1900" => "1900", "9999" => "> 1900" ), "1")->setEmptyString('Preis Bis'),

				DropdownField::create('kindLabel', "Zimmertyp", array( "shared room" => "Mehrbettzimmer", "private room" => "WG-Zimmer", "entire place" => "Gesamte Wohnung"))->setEmptyString('Immobilientyp'),
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
			$form->setFormMethod('GET')->setFormAction($this->Link())->disableSecurityToken()->loadDataFrom($this->getRequest()->getVars());

			return $form;
		}

		public function getFilterSummary() {
			// Retrieve selected filter values
			$filters = $this->getRequest()->getVars();
			$filterSummary = '';
		
			if (!empty($filters)) {
				$filterSummary .= '<p>Aktive Filter:</p><ul>';
				foreach ($filters as $key => $value) {
					if ($key !== 'action_FilterAction') {
						$filterSummary .= '<li>' .'<b>' .$key.'</b>' . ': ' . $value . '</li>';
					}
				}
				$filterSummary .= '</ul>';
			}
		
			return $filterSummary;
		}

		public function kamer(HTTPRequest $r) {
			$p = Kamer::get_by_url_segment(Convert::raw2sql($r->param('ID')));
			if (!$p) {
				return ErrorPage::response_for(404);
			}
			static::$current_product_id = $p->ID;
			return $this->customise(array('Kamer' => $p))->renderWith(array('Kamer', 'Page'));
		}
		public function isDataobject() {
			$urlsegment = "$this->URLSegment";
			$actual_link = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
			$end = array_slice(explode('/', $actual_link), -2)[0];

			if ($urlsegment == $end) {
				return 'true';
			} else {
				return 'false';
			}
		}
		public function init() {
			parent::init();
			// You can include any CSS or JS required by your project here.
			// See: http://doc.silverstripe.org/framework/en/reference/requirements
		}
	}
}
