<?php namespace App\Model;

use SilverStripe\Forms\TextField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\ORM\DataObject;

class ApartmentDetailOption extends DataObject
{
    private static $table_name = 'ApartmentDetailOption';

    private static $db = [
        'Label'       => 'Varchar(150)', // e.g. “Balkon”, “Aufzug”, “Tierhaltung”
        'Value'       => 'Varchar(255)', // e.g. “Ja/Nein/5Gbit/…”
        'Sort'        => 'Int',
        // Optional typed helpers if you need
        // 'Code'     => 'Varchar(64)',
        // 'Type'     => 'Enum("bool,text,number,select","text")',
        // 'Extra'    => 'Text',
    ];

    private static $has_one = [
        'Detail' => ApartmentDetail::class,
    ];

    private static $default_sort = 'Sort ASC, ID ASC';

    private static $summary_fields = [
        'Label' => 'Label',
        'Value' => 'Value',
    ];

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();

        $fields->replaceField('Label', TextField::create('Label', 'Label'));
        $fields->replaceField('Value', TextField::create('Value', 'Value'));
        // If you want a textarea:
        // $fields->replaceField('Value', TextareaField::create('Value', 'Value'));

        return $fields;
    }
}