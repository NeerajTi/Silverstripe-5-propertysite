<?php
namespace App\Model;

use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;
use SilverStripe\Forms\Tab;
class ApartmentAddress extends DataObject
{
    private static $table_name = 'ApartmentAddress';

    private static $db = [
        'Street'    => 'Varchar',
        'Nr'   => 'Varchar',
        'Plz'      => 'Varchar',
        'Ort'     => 'Varchar',
        'StrasseundHausnummer'  => 'Varchar',
        'Stadt'   => 'Varchar',
        // Optional geo fields:
        'Stadtteil'  => 'Varchar',
        'Lat' => 'Varchar',
        'Lng' => 'Varchar',
    ];

    // Inverse pointer (no extra column; ties to Apartment.Address)
    private static $belongs_to = [
        'Apartment' => Apartment::class . '.Address',
    ];

    private static $summary_fields = [
        'FullAddress' => 'Address'
    ];

    public function getFullAddress(): string
    {
        $parts = array_filter([
            "{$this->Street} {$this->Nr}",
            $this->Ort,
            $this->Plz,
            $this->Stadt,
            $this->Stadtteil
        ]);
        return implode(', ', $parts);
    }
    public function getGoogleAddress(): string
    {
        $parts = array_filter([
            "{$this->Street} {$this->Nr}",
            $this->Ort,
            $this->Plz,
            $this->Stadt,
            $this->Stadtteil
        ]);
        return implode('+', $parts);
    }

   
}
