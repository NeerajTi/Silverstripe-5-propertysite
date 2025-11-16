<?php

namespace App\Controller;

use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\PasswordField;
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\OptionsetField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\Session;
use SilverStripe\Assets\Upload;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Subsites\Model\Subsite;
use SilverStripe\Security\Member;
use SilverStripe\Security\TemporaryHashStore;
use SilverStripe\Control\Director;
use SilverStripe\Control\Email\Email;
use App\Extensions\CustomMemberExtension;



class TestPagesController extends ContentController {
    private static $allowed_actions = ['index'];

    private static $url_segment = 'testpage';

    protected function init(){
        parent::init();
    }

    public function index(HTTPRequest $req)
    {
        return $this->customise([
            'Title' => 'Test Pages'
        ])->renderWith(['Layout/TestPages', 'Page']);
    }
}