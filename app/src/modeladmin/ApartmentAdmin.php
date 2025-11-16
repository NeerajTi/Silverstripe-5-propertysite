<?php
namespace App\Admin;

use SilverStripe\Admin\ModelAdmin;
use App\Model\Apartment;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\GridField\GridFieldFilterHeader;
use SilverStripe\Forms\GridField\GridFieldExportButton;
use SilverStripe\Versioned\VersionedGridFieldItemRequest;

class ApartmentAdmin extends ModelAdmin
{
    private static $managed_models = [
        Apartment::class,
    ];

    private static $url_segment = 'apartments';   // /admin/apartments
    private static $menu_title = 'Apartments';
    private static $menu_icon_class = 'font-icon-home'; // optional: pick any admin icon class

    /**
     * Customize the edit form (GridField) to add filters/export etc.
     */
    public function getEditForm($id = null, $fields = null)
    {
        $form = parent::getEditForm($id, $fields);

        $gridFieldName = $this->sanitiseClassName($this->modelClass);
        $gridField = $form->Fields()->dataFieldByName($gridFieldName);

        if ($gridField && $gridField instanceof GridField) {
            /** @var GridFieldConfig_RecordEditor $config */
            $config = $gridField->getConfig();

            // Add filter header if not present
            if (!$config->getComponentByType(GridFieldFilterHeader::class)) {
                $config->addComponent(new GridFieldFilterHeader());
            }

            // Add CSV export button
            if (!$config->getComponentByType(GridFieldExportButton::class)) {
                $config->addComponent(new GridFieldExportButton());
            }

            // Use versioned item request to handle archived/published states if needed:
            if (!$config->getComponentByType(VersionedGridFieldItemRequest::class)) {
                // optional; uncomment if you use Versioned and want "restore/publish" actions
                // $config->addComponent(new VersionedGridFieldItemRequest());
            }
        }

        return $form;
    }
    public function subsiteCMSShowInMenu(){
        return true;
    } 
}