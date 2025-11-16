<?php
namespace {

    use SilverStripe\Admin\ModelAdmin;

    class KamerModelAdmin extends ModelAdmin {
        private static $managed_models = array(
            'Kamer',
        );

        private static $url_segment = 'Kamers';
        private static $menu_title = 'Kamers';

        public function subsiteCMSShowInMenu(){
            return true;
        }        
    }
}