<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;
use SilverStripe\Assets\Image;

class PersonalInformation extends DataObject
{
    private static $table_name = 'MemberPersonalInformation';

    private static $db = [
        'Anrede'        => 'Varchar',
        'FirstName'     => 'Varchar',
        'LastName'      => 'Varchar',
        'Geburtsdatum'  => 'Varchar',
        'Strabe'        => 'Varchar',
        'Nr'            => 'Varchar',
        'Plz'           => 'Varchar',
        'Ort'           => 'Varchar',
        'Land'          => 'Varchar',
        'CountryCode'   => 'Varchar',
        'Telefon'       => 'Varchar',
        'Email'         => 'Varchar',
        'Fax'           => 'Varchar',
        'Description'   => 'HTMLText',
    ];

    private static $has_one = [
        'Member' => Member::class,
        'Bilder'  => Image::class
    ];

    private static $owns = [
        'Bilder'
    ];
}
