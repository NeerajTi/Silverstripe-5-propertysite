<?php namespace App\Model;

use SilverStripe\ORM\DataObject;

class ApartmentDetail extends DataObject
{
    private static $table_name = 'ApartmentDetail';

    private static $db = [
        // Screen 1 (already present)
        'Wohnflache'                   => 'Decimal(10,2)',  // e.g. 82.50
        'Zimmer'                       => 'Varchar(50)',  // e.g. 3
        'Kaltmiete'                    => 'Decimal(10,2)',
        'FloorVerfugbarAb'             => 'Varchar(50)',  // e.g. 2nd / EG
        'Nebenkosten'                  => 'Decimal(10,2)',
        'Kaution'                      => 'Varchar(50)',
        'Gesamtmiete'                  => 'Decimal(10,2)',
        'QualitatDerWohnung'           => 'Varchar(50)',

        // Screen 3 (NEW)        // count of amenities
        'Schlafzimmer'                 => 'Int',
        'Badezimmer'                   => 'Int',
        'Etage'                        => 'Varchar(10)',  // e.g. 0, 1, EG
        'Von'                          => 'Varchar(10)', 
        'Nutzflache'                   => 'Varchar(15)',
        'Wohnberechtigungsschein'      => 'Varchar(50)',
        'Heizungsart'       => 'Varchar(50)',
    ];

    // Inverse of Apartment.Has one Details
    private static $belongs_to = [
        'Apartment' => Apartment::class . '.Detail',
    ];

    private static $summary_fields = [
        'Wohnflache'                           => 'Wohnflache',
        'Zimmer'                               => 'Zimmer',
        'Kaltmiete'                            => 'Kaltmiete',
        'FloorVerfugbarAb'                     => 'FloorVerfugbarAb',
        'Nebenkosten'                          => 'Nebenkosten',
        'Kaution'                              => 'Kaution',
        'HeizunkostenInNebenkosten'            => 'HeizunkostenInNebenkosten',
        'Gesamtmiete'                          => 'Gesamtmiete',
        'QualitatDerWohnung'                   => 'QualitatDerWohnung',

        // NEW summary fields
        'Schlafzimmer'                         => 'Schlafzimmer',
        'Badezimmer'                           => 'Badezimmer',
        'Etage'                             => 'Etage',
        'Von'                             => 'Von',
        'Nutzflache'                           => 'Nutzflache',
        'Etagenheizung'                        => 'Etagenheizung',
        'Zentralheizung'                       => 'Zentralheizung',
        'Internetgeschwindigkeit'              => 'Internetgeschwindigkeit',
        'Energieeffizienzklasse'               => 'Energieeffizienzklasse',
    ];
    private static $has_many = [
        'DetailOptions' => ApartmentDetailOption::class,
    ];
    public function getAbdate()
    {
        $value = $this->FloorVerfugbarAb;

        if ($value && preg_match('/^\d{4}-\d{2}-\d{2}$/', $value)) {
            // Valid YYYY-MM-DD format → format to d-m-Y
            return date('d-m-Y', strtotime($value));
        }
    
        // Fallback: return as-is or empty
        return $value ?: '';
    }
}
