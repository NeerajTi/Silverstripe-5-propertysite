<?php
namespace App\Model;
use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\File;
class ApartmentApplication extends DataObject
{
    private static $table_name = 'ApartmentApplication';

    private static $db = [
        'Description' => 'HTMLText',
        'Stadtteil' => 'Varchar',
        'CreditCheck' => 'Varchar',
        'Price' => 'Varchar',
        'Wohnungflache' => 'Varchar',
        'Zimmer' => 'Varchar(50)',
        'lookingfor'=>'HTMLText',
        'Wohnberechtigungsschein' => 'Varchar',
        'Heizungsart' => 'Varchar',
        'Erwachsene' => 'Varchar',
        'Kinder' => 'Varchar',
        'HouseholdIncome' => 'Varchar',
        'ListerID' => 'Int',
        'IsRead' => 'Int',
    ];

    private static $has_one = [
        'Apartment' => Apartment::class,
        'Member' => Member::class,
    ];
      private static $many_many = [
        'Attachment' => File::class,
    ];
    private static $owns = ['Attachment'];
    public function getCreatedDate(){
        return date('H:i d-m-Y', strtotime($this->Created));
    }
    public function getSubDescription(){
        return substr($this->Description, 0, 92);
    }
}