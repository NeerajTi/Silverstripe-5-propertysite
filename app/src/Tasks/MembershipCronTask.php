<?php

namespace App\Tasks;

use SilverStripe\Dev\BuildTask;
use SilverStripe\Control\Email\Email;
use SilverStripe\SiteConfig\SiteConfig;
use App\Model\MemberBasicData;

class MembershipCronTask extends BuildTask
{
    private static $segment = 'MembershipCronTask';
    
    protected $title = 'Membership Cron Task';
    
    protected $description = 'Sends membership reminders and updates statuses for MemberBasicData';
    
    public function run($request)
    {
        echo "Starting membership cron task...\n";
        
        $now = date('Y-m-d H:i:s');
        $tomorrow = date('Y-m-d 23:59:59', strtotime('+1 day'));
        
        // Find memberships expiring tomorrow (active subscriptions)
        $expiringMemberships = MemberBasicData::get()->filter([
            'ValidUntil:GreaterThan' => date('Y-m-d H:i:s'),
            'ValidUntil:LessThan' => $tomorrow,
            'SubscriptionStatus' => 'COMPLETED'
        ]);
        
        $sentCount = 0;
        foreach ($expiringMemberships as $membership) {
            if ($this->sendReminderEmail($membership)) {
                $sentCount++;
                echo "Sent reminder to: {$membership->Email}\n";
            }
        }
        
        // Find expired memberships and mark as pending
        $expiredMemberships = MemberBasicData::get()->filter([
            'ValidUntil:LessThan' => date('Y-m-d H:i:s'),
            'SubscriptionStatus' => 'active'
        ]);
        
        $expiredCount = 0;
        foreach ($expiredMemberships as $membership) {
            $membership->SubscriptionStatus = 'EXPIRED';
            $membership->write();
            $this->sendExpirationEmail($membership);
            $expiredCount++;
            echo "Marked as pending: {$membership->Email}\n";
        }
        
        // Show statistics
        $activeCount = MemberBasicData::get()->filter(['SubscriptionStatus' => 'COMPLETED'])->count();
        $pendingCount = MemberBasicData::get()->filter(['SubscriptionStatus' => 'EXPIRED'])->count();
        $expiredCountTotal = MemberBasicData::get()->filter(['SubscriptionStatus' => 'EXPIRED'])->count();
        
        echo "\n--- Task Completed Successfully ---\n";
        echo "Reminder emails sent: {$sentCount}\n";
        echo "Memberships marked as pending: {$expiredCount}\n";
        echo "--- Current Statistics ---\n";
        echo "Active memberships: {$activeCount}\n";
        echo "Pending memberships: {$pendingCount}\n";
        echo "Expired memberships: {$expiredCountTotal}\n";
        echo "Total memberships: " . MemberBasicData::get()->count() . "\n";
    }
    
    private function sendReminderEmail($membership)
    {
        try {
            $member = $membership->Member();
            $siteConfig = SiteConfig::current_site_config();
            
            $email = Email::create()
                ->setFrom($siteConfig->ContactEmail ?: 'noreply@example.com')
                ->setTo($membership->Email)
                ->setSubject("Mitgliedschaft Verlängerungserinnerung - {$siteConfig->Title}")
                ->setHTMLTemplate('Email\\MembershipReminderEmail')
                ->setData([
                    'Member' => $member,
                    'Membership' => $membership,
                    'SiteConfig' => $siteConfig,
                    'RenewalDate' => $membership->ValidUntil
                ]);
            
            return $email->send();
        } catch (\Exception $e) {
            echo "ERROR - Failed to send reminder email for {$membership->Email}: " . $e->getMessage() . "\n";
            return false;
        }
    }
    
    private function sendExpirationEmail($membership)
    {
        try {
            $member = $membership->Member();
            $siteConfig = SiteConfig::current_site_config();
            
            $email = Email::create()
                ->setFrom($siteConfig->ContactEmail ?: 'noreply@example.com')
                ->setTo($membership->Email)
                ->setSubject("Mitgliedschaft Abgelaufen - {$siteConfig->Title}")
                ->setHTMLTemplate('Email\\MembershipExpiredEmail')
                ->setData([
                    'Member' => $member,
                    'Membership' => $membership,
                    'SiteConfig' => $siteConfig
                ]);
            
            return $email->send();
        } catch (\Exception $e) {
            echo "ERROR - Failed to send expiration email for {$membership->Email}: " . $e->getMessage() . "\n";
            return false;
        }
    }
}