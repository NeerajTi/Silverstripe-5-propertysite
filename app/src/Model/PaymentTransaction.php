<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

class PaymentTransaction extends DataObject
{
    private static $table_name = 'PaymentTransaction';

    private static $db = [
        'TransactionID'          => 'Varchar',
        'PayerID'                => 'Varchar',
        'Description'   => 'Varchar',
        'Price'         => 'Double(10,2)',
        'Status'        => 'Varchar',
        'Type'          => 'Varchar',
        'PaymentMethod' => 'Varchar',
        'RawResponse'   => 'HTMLText',
    ];

    private static $has_one = [
        'Member' => Member::class,
    ];
}



?>