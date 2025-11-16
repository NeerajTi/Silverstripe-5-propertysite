<?php
namespace {

    use SilverStripe\Admin\ModelAdmin;

    class VraagModelAdmin extends ModelAdmin {
        private static $managed_models = array(
            'VraagEnAntwoord',
        );

        private static $url_segment = 'vragen';
        private static $menu_title = 'Vragen';

        public function subsiteCMSShowInMenu(){
            return true;
        }        
    }
}
