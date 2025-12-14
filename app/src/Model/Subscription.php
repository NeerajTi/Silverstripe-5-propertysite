<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

class Subscription extends DataObject
{
    private static $table_name = 'Subscription';

    private static $db = [
        'Name'          => 'Varchar',
        'Description'   => 'Varchar',
        'Price'         => 'Double(10,2)',
        'ValidUntil'    => 'DBDatetime',
        'Type'          => 'Varchar',
        'Status'        => 'Varchar',
        'TransactionID' => 'Varchar',
        'PayerID'       => 'Varchar',
    ];

    private static $has_one = [
        'Member' => Member::class,
    ];

       public function getFromDate(): string
    {
       return date('d M Y', strtotime($this->Created));
    }
    public function getToDate(): string
    {
       return date('d M Y', strtotime($this->ValidUntil));
    }


}



?>