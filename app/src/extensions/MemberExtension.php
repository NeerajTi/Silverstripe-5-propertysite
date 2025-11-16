<?php

namespace App\Extensions;

use SilverStripe\ORM\DataExtension;
use App\Model\MemberBasicData;
use App\Model\MemberCompanyData;
use App\Model\PersonalInformation;
use App\Model\Apartment;
use App\Model\MemberSearchSetting;
class MemberExtension extends DataExtension
{
    private static $has_many = [
        'BasicDataRecords' => MemberBasicData::class,
        'CompanyDataRecords' => MemberCompanyData::class,
        'PersonalInformation' => PersonalInformation::class,
        'MemberSearchSetting' => MemberSearchSetting::class,
        'Apartments' => Apartment::class,
        
    ];
    private static $db = [
        'EmailValidate' => 'Varchar',
        'UserType' => 'Varchar'
    ];
    private static $cascade_deletes = [
        'BasicDataRecords',
        'CompanyDataRecords',
        'PersonalInformation',
        'Apartments',
        'MemberSearchSetting'
    ];
    
    public function getMemberType()
    {
        $record = $this->owner->BasicDataRecords()->first(); // ✅ Works because it's a DataList

        return $record && $record->InseriereAls
            ? ucfirst($record->InseriereAls)
            : 'N/A';
    }
    private static $summary_fields = [
        'FirstName'   => 'FirstName',
        'Surname'     => 'SurName',
        'Email'       => 'Email',
        'MemberType' => 'Member Type',
    ];
    

}
