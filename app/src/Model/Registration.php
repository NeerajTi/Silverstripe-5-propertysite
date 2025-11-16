<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;

class Registration extends DataObject
{
    private static $table_name = 'tbl_users';

    private static $db = [
        'InseriereAls' => 'Varchar',
        'Anrede' => 'Varchar',
        'FirstName' => 'Varchar',
        'LastName' => 'Varchar',
        'CountryCode' => 'Varchar',
        'PhoneNumber' => 'Varchar',
        'Email' => 'Varchar',
        'Type' => 'Varchar',
        'PersonalInfo' => 'Text',
        'Description' => 'Text',
    ];

    private static $has_one = [
        'Image' => \SilverStripe\Assets\Image::class
    ];
}
