<?php

namespace App\Forms;

use SilverStripe\Forms\OptionsetField;
use SilverStripe\ORM\ArrayList;
use SilverStripe\View\ArrayData;

class ContactOptionsetField extends OptionsetField
{
    /** @var iterable|null a list of contact objects/arrays with ID, Email, Telefon */
    protected $contacts = null;

    /**
     * Pass your contacts (DataList/array of objects/arrays).
     * Each item must have: ID, Email, Telefon (or Phone).
     */
    public function setContacts($contacts): self
    {
        $this->contacts = $contacts;
        return $this;
    }

    /**
     * Build $Options with extra fields (Email, Phone) per item.
     * Keeps Title as a simple string to avoid forTemplate errors.
     */
    public function getOptions()
    {
        // If no contacts provided, fallback to default behaviour
        if ($this->contacts === null) {
            return parent::getOptions();
        }

        $list = ArrayList::create();
        $currentValue = (string)$this->Value();
        $fieldDomID   = $this->ID();      // DOM id base for inputs
        $name         = $this->getName(); // input name attribute

        foreach ($this->contacts as $c) {
            // accept both arrays and objects
            $id     = is_array($c) ? ($c['ID'] ?? null)     : ($c->ID ?? null);
            $email  = is_array($c) ? ($c['Email'] ?? '')    : ($c->Email ?? '');
            $phone  = is_array($c) ? ($c['Telefon'] ?? ($c['Phone'] ?? '')) : ($c->Telefon ?? $c->Phone ?? '');

            if ($id === null) {
                continue;
            }

            $value     = (string)$id;
            $optionID  = $fieldDomID . '_' . $value; // unique input id
            $isChecked = ($currentValue !== '' && $currentValue == $value);

            $list->push(ArrayData::create([
                // Standard fields expected by OptionsetField.ss:
                'ID'            => $optionID,
                'Name'          => $name,
                'Value'         => $value,
                'Title'         => $email ?: 'Contact ' . $value, // keep Title a STRING
                'isChecked'     => $isChecked,
                'AttributesHTML'=> '', // you can add extra per-option attrs if needed

                // Your extra fields available in the template loop:
                'Email'         => $email,
                'Phone'         => $phone,
            ]));
        }

        return $list;
    }
}
