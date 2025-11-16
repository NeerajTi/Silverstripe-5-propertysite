<?php

namespace App\Model;

use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

class MemberBasicData extends DataObject
{
    private static $table_name = 'MemberBasicData';

    private static $db = [
        'InseriereAls'  => 'Varchar',
        'Anrede'        => 'Varchar',
        'FirstName'     => 'Varchar',
        'LastName'      => 'Varchar',
        'Firmaname'     => 'Varchar',
        'HRBHRA'        => 'Varchar',
        'CountryCode'   => 'Varchar',
        'Telefon'       => 'Varchar',
        'Email'         => 'Varchar',
        'Type'          => 'Varchar',
        'Notification1' => 'Int',
        'Notification2' => 'Int',
        'PlanId'   => 'Varchar',
        'PaymentDate'   => 'DBDatetime',
        'PaymentAmount' => 'Double(10,2)',
        'PaymentMethod' => 'Varchar',
        'ValidUntil'    => 'DBDatetime',
        'SubscriptionStatus' => 'Varchar',
        'AutoSubscription' => 'Int',
    ];

    private static $has_one = [
        'Member' => Member::class
    ];
       /**
     * Check if membership is active
     */
    public function isActive()
    {
        return $this->SubscriptionStatus === 'COMPLETED' && 
               strtotime($this->ValidUntil) > time();
    }
     /**
     * Check if membership expires soon (within days)
     */
    public function expiresSoon($days = 1)
    {
        if (!$this->isActive()) {
            return false;
        }
        
        $expiryTime = strtotime($this->ValidUntil);
        $warningTime = strtotime("+{$days} days");
        
        return $expiryTime <= $warningTime;
    }
     /**
     * Extend membership by months
     */
    public function extendMembership($months = 1)
    {
        $currentDate = $this->ValidUntil ?: date('Y-m-d H:i:s');
        $newDate = date('Y-m-d H:i:s', strtotime("+{$months} months", strtotime($currentDate)));
        
        $this->ValidUntil = $newDate;
        $this->SubscriptionStatus = 'COMPLETED';
        $this->write();
        
        return $this;
    }
}
