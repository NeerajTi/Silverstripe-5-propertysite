<?php
namespace App\Controller;
use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Security\Security;
use SilverStripe\Security\Member;
use SilverStripe\Security\SecurityToken;
use SilverStripe\Control\Session;
use SilverStripe\Assets\Upload;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Subsites\Model\Subsite;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\Assets\File;
use SilverStripe\View\ArrayData;
use App\Model\PersonalInformation;
use App\Helper\RestApiHelper;
use App\Helper\GlobalHelper;
use App\Helper\FileHelper;
use App\Model\ApartmentWishlist;
use App\Model\Apartment;
use App\Model\ApartmentApplication;
use App\Model\MemberBasicData;
use App\Model\MemberCompanyData;
use App\Model\RentalWorkerInformation;
use App\Model\Subscription;
use App\Model\PaymentTransaction;
use SilverStripe\ORM\DB;
class PaymentController extends ContentController{
    private static $allowed_actions = [
        'payment_approve','payment_thankyou','payment_cancel'
    ];
    public function init(){
        parent::init();
        if(!GlobalHelper::isloggedin()){
            $this->redirect('/login');
        }
        
    }   
    public function payment_approve(HTTPRequest $request){
        $data = json_decode($request->getBody(), true);

        if (!$data || !isset($data['transaction_id'])) {
            return $this->httpError(400, 'Invalid data');
        }
        $currentDate=date('Y-m-d H:i:s');
        $MemberBasicData=MemberBasicData::get()->filter('MemberID', GlobalHelper::getLoggedInUser()->ID)->first();
        $subscription = Subscription::create();
        $subscription->MemberID = GlobalHelper::getLoggedInUser()->ID;
        $subscription->Name = $data['plan_id'];
        $subscription->Description = $data['plan_id'];
        $subscription->Price = $data['amount'];
        $subscription->ValidUntil = date('Y-m-d H:i:s', strtotime('+'.$data['qty'].' months', strtotime($currentDate)));
        $subscription->Type = $MemberBasicData->InseriereAls;
        $subscription->Status = $data['status'];
        $subscription->TransactionID = $data['transaction_id'];
        $subscription->PayerID = $data['payer_id'];
        $subscription->write();
        $paymentTransaction = PaymentTransaction::create();
        $paymentTransaction->MemberID = GlobalHelper::getLoggedInUser()->ID;
        $paymentTransaction->TransactionID = $data['transaction_id'];
        $paymentTransaction->PayerID = $data['payer_id'];
        $paymentTransaction->Description = $data['plan_id'];
        $paymentTransaction->Price = $data['amount'];
        $paymentTransaction->Status = $data['status'];
        $paymentTransaction->Type = $MemberBasicData->InseriereAls;
        $paymentTransaction->PaymentMethod = $data['payment_method'];
        $paymentTransaction->RawResponse = json_encode($data['raw_response']);
        $paymentTransaction->write();


        $MemberBasicData->PlanId = $data['plan_id'];
        $MemberBasicData->PaymentDate = $currentDate;
        $MemberBasicData->PaymentAmount = $data['amount'];
        $MemberBasicData->PaymentMethod = $data['payment_method'];
        $MemberBasicData->ValidUntil = date('Y-m-d H:i:s', strtotime('+'.$data['qty'].' months', strtotime($currentDate)));
        $MemberBasicData->SubscriptionStatus = $data['status'];
        $MemberBasicData->write();
        if($MemberBasicData->InseriereAls=='broker' || $MemberBasicData->InseriereAls=='owner' || $MemberBasicData->InseriereAls=='seller') {
       
          DB::query("UPDATE Apartment SET PaymentType = 1 WHERE MemberID = " . GlobalHelper::getLoggedInUser()->ID); 
        }
        return HTTPResponse::create(json_encode(['status' => 'ok']))
            ->addHeader('Content-Type', 'application/json');
    }  
    public function payment_thankyou(HTTPRequest $request){
        $member = GlobalHelper::getLoggedInUser();
        $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
        if($memberBasicData->InseriereAls == 'renter'){
         $dashboard = '/renter-dashboard';
        }else{
            $dashboard = '/dashboard';
        }
        return $this->customise([
            'Title' => 'Zahlung erfolgreich',
            'Name' => $member->FirstName.' '.$member->LastName,
            'MemberBasicData' => $memberBasicData,
            'Dashboard' => $dashboard,
            'userType'=>$memberBasicData->InseriereAls
        ])->renderWith(['Layout/Payments/PaymentThankyou', 'Page']);
    }
    public function payment_cancel(HTTPRequest $request){
        $member = GlobalHelper::getLoggedInUser();
        $memberBasicData = MemberBasicData::get()->filter('MemberID', $member->ID)->first();
        if($memberBasicData->InseriereAls == 'renter'){
            $dashboard = '/renter-dashboard';
           }else{
               $dashboard = '/dashboard';
           }
        return $this->customise([
            'Title' => 'Zahlung erfolgreich',
            'Name' => $member->FirstName.' '.$member->LastName,
            'MemberBasicData' => $memberBasicData,
            'Dashboard' => $dashboard,
        ])->renderWith(['Layout/Payments/PaymentCancel', 'Page']);
    }
}
