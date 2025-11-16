<?php
namespace {

    use SilverStripe\CMS\Controllers\ContentController;
	use SilverStripe\Subsites\Model\Subsite;
	use SilverStripe\Subsites\State\SubsiteState;
    use SilverStripe\SiteConfig\SiteConfig;
    use SilverStripe\ORM\ArrayList;

    class PageController extends ContentController
    {
		private static $allowed_actions = [];
        private $SiteConfig;
        private $FilterWoord;

		protected function init()
        {
			parent::init();
			// You can include any CSS or JS required by your project here.
			// See: http://doc.silverstripe.org/framework/en/reference/requirements

            $this->SiteConfig = SiteConfig::current_site_config();
			$this->FilterWoord = $this->SiteConfig->FilterWoord;
		}

        public function BodyClass()
        {
            // return lowercase + hyphenated classname + urlsegment
            $class = strtolower($this->dataRecord->ClassName);
            $class = preg_replace('/([a-z])([A-Z])/', '$1-$2', $class); // productPage -> product-Page
            $class = strtolower($class);

            return $class . ' ' . strtolower($this->dataRecord->URLSegment);
        }

		public function AlleKamers() {
			// $Kamers = Kamer::get()->filter(array('SubsiteID'=>SubsiteState::singleton()->getSubsiteId()));
            return Kamer::get()->filter(array('City'=> $this->FilterWoord));
		}

		public function LaatsteKamers() {
			// $Kamers = Kamer::get()->filter(array('SubsiteID'=>SubsiteState::singleton()->getSubsiteId()))->limit(10);
            return Kamer::get()->filter(array('City'=> $this->FilterWoord))->limit(10);
        }

        public function RandomKamers() {
            $randomKamers = Kamer::get()->filter(array('City' => $this->FilterWoord))->limit(10)->toArray();
            shuffle($randomKamers);
            return ArrayList::create($randomKamers);
        }
        

        public function Kameroverzichtpagina() {
            return KamerOverzicht::get()->limit(1);
		}


		public function LaatsteNieuws() {
            return NieuwsArtikel::get()->limit(10);
        }

		public function SubsiteList() {
            return Subsite::get();
        }

        public function VolledigeURL() {
            $actual_link = "//$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";

            if(str_contains($actual_link, '/kamer/')) {
                $showTrueFalse = "Succes";
            } else {
                $showTrueFalse = "Mislukt";
            }

            return $showTrueFalse;
        }
    }
}
