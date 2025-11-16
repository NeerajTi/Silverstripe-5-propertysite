<?php
namespace App\Model;
use SilverStripe\ORM\DataObject;

class ApartmentWishlist extends DataObject
{
    private static $table_name = 'ApartmentWishlist';

    private static $db = [
    ];

    private static $has_one = [
        'Apartment' => Apartment::class,
        'Member' => Member::class,
    ];
}
