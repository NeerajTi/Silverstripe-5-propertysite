<?php
namespace {

    use SilverStripe\CMS\Model\SiteTree;
    use SilverStripe\Assets\Image;
    use SilverStripe\AssetAdmin\Forms\UploadField;
    use SilverStripe\Forms\TextField;
	use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
	use SilverStripe\Forms\ToggleCompositeField;
	use SilverStripe\Subsites\Model\Subsite;
	use SilverStripe\Subsites\State\SubsiteState;	

	class Page extends SiteTree {

		private static $db = array(
			'SecondContent' => 'HTMLText',
			'CannonicalURL' => 'Varchar(255)',
        );

		private static $has_one = array(
        );

		public function getCMSFields() {
			$fields = parent::getCMSFields();

			// Access the ToggleCompositeField by name
			$metadataToggle = $fields->fieldByName('Root.Main.Metadata');

			// Ensure ToggleCompositeField is a ToggleCompositeField
			if ($metadataToggle instanceof ToggleCompositeField) {
				// Access the actual content field
				$metadataContent = $metadataToggle->FieldList();
				
				// Add the TextField to the ToggleCompositeField
				$metadataContent->push(
					TextField::create('CannonicalURL', 'Canonical URL')
						->setDescription('Een canonieke URL is de voorkeurs-URL voor een webpagina.')
				);
			}

			$fields->addFieldToTab('Root.Main', HTMLEditorField::create('SecondContent','Content onder de kamers'), '');
			return $fields;
		}
		
		public function getAllQuestions() {
            return VraagEnAntwoord::get();
        }

		public function getCurrentSubsite() {
			return Subsite::get();
		}
	}
}
