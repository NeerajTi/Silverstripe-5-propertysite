<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;

class MemberSearchSetting extends DataObject
{
    private static $table_name = 'MemberSearchSetting';


    private static $db = [
        'Price' => 'Varchar(40)',
        'Space' => 'Varchar(40)',
        'Rooms' => 'Varchar(1000)',
        'Locations' => 'Varchar(1000)',
        'Equipment' => 'Varchar(1000)',
    ];
    private static $has_one = [
        'Member' => \SilverStripe\Security\Member::class,
    ];

}