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

	class VraagEnAntwoord extends DataObject {

		private static $db = array(
            'Title' => 'Text',
            'Antwoord' => 'HTMLText',
			'Subsite' => 'Varchar'
		);

		private static $has_one = array(

		);

		private static $summary_fields = array(

		);		

		private static $has_many = array(
		);

		public function getCMSFields() {
			$fields = parent::getCMSFields();

			
			$fields->addFieldToTab('Root.Main', TextField::create('Title', 'Vraag'));
			$fields->addFieldToTab('Root.Main', HTMLEditorField::create('Antwoord', 'Antwoord'));
			$fields->addFieldToTab('Root.Main', DropdownField::create('Subsite', 'Website', Subsite::get()->map('ID', 'Title'))->setEmptyString('Selecteer website'));

			return $fields;
		}
		




	}
}
