<?php
namespace App\Model;
use SilverStripe\ORM\DataObject;

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
    public function getCreatedDate(){
        return date('H:i d-m-Y', strtotime($this->Created));
    }
    public function getSubDescription(){
        return substr($this->Description, 0, 92);
    }
}