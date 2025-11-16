<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\Image;
use SilverStripe\Security\Member;

class RentalWorkerInformation extends DataObject
{
    private static $table_name = 'RentalWorkerInformation';

    private static $db = [
        'Anrede'                 => 'Varchar',
        'Titel'                  => 'Varchar',
        'FirstName'              => 'Varchar',
        'LastName'               => 'Varchar',
        'CountryCode'            => 'Varchar',
        'Telefon'                => 'Varchar',
        'Email'                  => 'Varchar',
        'ZusaEmail'              => 'Varchar',
        'PositionUnterneehmen'   => 'Varchar',
        'Mobile'                 => 'Varchar',
        'Fax'                    => 'Varchar',
        'StandaardContact'       => 'Varchar',
        'Description'            => 'HTMLText',
    ];

    private static $has_one = [
        'Member' => Member::class,
        'Image'  => Image::class
    ];

    private static $owns = [
        'Image'
    ];
}
