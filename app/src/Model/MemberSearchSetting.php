<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;

class MemberSearchSetting extends DataObject
{
    private static $table_name = 'MemberSearchSetting';


    private static $db = [
        'Price_Min' => 'Varchar(40)',
        'Space_Min' => 'Varchar(40)',
        'Price_Max' => 'Varchar(40)',
        'Space_Max' => 'Varchar(40)',
        'Rooms' => 'Varchar(1000)',
        'Locations' => 'Varchar(1000)',
        'Equipment' => 'Varchar(1000)',
    ];
    private static $has_one = [
        'Member' => \SilverStripe\Security\Member::class,
    ];

}