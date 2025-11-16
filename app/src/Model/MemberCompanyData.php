<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\Image;
use SilverStripe\Security\Member;

class MemberCompanyData extends DataObject
{
    private static $table_name = 'MemberCompanyData';

    private static $db = [
        'Firmaname'    => 'Varchar',
        'HRBHRA'       => 'Varchar',
        'Strabe'       => 'Varchar',
        'Nr'           => 'Varchar',
        'Plz'          => 'Varchar',
        'Ort'          => 'Varchar',
        'Land'         => 'Varchar',
        'CountryCode'  => 'Varchar',
        'Telefon'      => 'Varchar',
        'Email'        => 'Varchar',
        'Website'      => 'Varchar',
        'Fax'          => 'Varchar',
        'Description'  => 'HTMLText'
    ];

    private static $has_one = [
        'Member' => Member::class,
        'Image'  => Image::class
    ];

    private static $owns = [
        'Image'
    ];
    // Optional: let templates use $Bilder even though DB is ImagedID
    public function getBilder(): ?Image
    {
        return $this->Image();
    }

}
