<?php
namespace {

    use SilverStripe\ORM\DataExtension;
    use SilverStripe\Forms\FieldList;
    use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
    use SilverStripe\Forms\TextField;
    use SilverStripe\Forms\TextareaField;
    use SilverStripe\Assets\Image;
    use SilverStripe\AssetAdmin\Forms\UploadField;

    class CustomSiteConfig extends DataExtension {

        private static $db = array(
            'FacebookLikeURL' => 'Text',            
            'FacebookPageURL' => 'Text',
            'InstagramPageURL' => 'Text',
            'OverOnsTekst' => 'HTMLText',
            'OverigTekst' => 'HTMLText',
            'FacebookTekst' => 'HTMLText',
            "TagmanagerBoven" => "Text",
            "TagmanagerOnder" => "Text",  
            "FacebookPixels" => "Text", 
            "MetaTag" => "Text",     
            "MapsApi" => "Text",
			"AdsenseID" => "Text", 
			"AdsensePosition1" => "Text", 
            "FilterWoord" => "Text", 
            "Stad" => "Text", 
            'KamerLink' => 'Text',
            
            
            // Vertalingen
            'FilterResetten' => 'Text',


        );

        private static $has_one = array(
            'Banner' => Image::class,
            'Logo' => Image::class,
            'ScrollLogo' => Image::class,
            'Favicon' => Image::class
        );

        
        private static $owns = array(
         'Banner',
        'Logo',
        'Favicon',
        'ScrollLogo'
        );

        public function updateCMSFields(FieldList $fields) {

            
            $fields->addFieldToTab('Root.Footer', new HTMLEditorField('OverOnsTekst','Over ons tekst:'));
            $fields->addFieldToTab('Root.Footer', new HTMLEditorField('OverigTekst',"Overige pagina's tekst:"));
            $fields->addFieldToTab('Root.Main', new TextField('KamerLink','Link voor de kamers'));
            $fields->addFieldToTab('Root.SocialMedia', new TextField('FacebookLikeURL','Facebook like url'));
            $fields->addFieldToTab('Root.SocialMedia', new TextField('FacebookPageURL','Facebook Page URL'));
            $fields->addFieldToTab('Root.SocialMedia', new TextField('InstagramPageURL','Instagram Page URL'));
            $fields->addFieldToTab('Root.SocialMedia', new HTMLEditorField('FacebookTekst','Facebook tekst'));

            // $fields->addFieldToTab('Root.GoogleSettings', new TextareaField('TagmanagerBoven','Tag manager'));
            // $fields->addFieldToTab('Root.GoogleSettings', new TextareaField('TagmanagerOnder','Tag manager'));

		    $fields->addFieldToTab("Root.GoogleSettings", TextareaField::create('TagmanagerBoven', 'Tag manager <head>'));						
            $fields->addFieldToTab("Root.GoogleSettings", TextareaField::create('TagmanagerOnder', 'Tag manager <body>'));	 
			$fields->addFieldToTab("Root.GoogleSettings", TextField::create('AdsenseID', 'AdsenseID'));	
            $fields->addFieldToTab('Root.FacebookPixels', new TextField('FacebookPixels','Facebook Pixels init code'));
            $fields->addFieldToTab('Root.FacebookPixels', new TextField('MetaTag','Meta Tag Facebook domain content'));
			
			$fields->addFieldToTab("Root.GoogleSettings", TextField::create('AdsensePosition1', 'Data Slot ID'));

                   
		    $fields->addFieldToTab("Root.Google Maps", TextField::create('MapsApi', 'Api Key'));	        

            $fields->addFieldToTab('Root.Main', new UploadField('Banner','Banner'));
            $fields->addFieldToTab('Root.Main', new TextField('FilterWoord','FilterWoord'));
            $fields->addFieldToTab('Root.Main', new TextField('Stad','Stad naam'));
            $fields->addFieldToTab('Root.Main', new UploadField('Logo','Logo'));
            $fields->addFieldToTab('Root.Main', new UploadField('ScrollLogo','Scroll Logo'));
            $fields->addFieldToTab('Root.Main', new UploadField('Favicon','Favicon'));
        }
    }
}
