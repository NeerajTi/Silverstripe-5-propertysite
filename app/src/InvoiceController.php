<?php

namespace App\Controller;

use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Control\Controller;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\Director;
use App\Helper\GlobalHelper;
use App\Model\Subscription;
use App\Model\PaymentTransaction;
use App\Model\MemberBasicData;
use App\Model\PersonalInformation;
use Dompdf\Dompdf;
use Dompdf\Options;

class InvoiceController extends ContentController
{
    private static $allowed_actions = [
        'index','download'
    ];
 protected function init()
    {
        parent::init();

        // Check login status
        if (!GlobalHelper::isloggedin()) {
            return $this->redirect('/login');
        }
       
    }

    public function index(HTTPRequest $request){
        $subscriptions=Subscription::get()->filter('MemberID', GlobalHelper::getLoggedInUser()->ID);
         return $this->customise([
        'Title' => 'Abrechnungen',
        'subcriptions'=>$subscriptions
    ])->renderWith(['Layout/Invoice/Index', 'Page']);
    }
public function download(HTTPRequest $request)
{
    $id=$request->param('ID');
    $subscription=Subscription::get()->byID($id);
    if($subscription->MemberID!=GlobalHelper::getLoggedInUser()->ID)
    {
        return $this->redirect('/invoices');
    }
    $userDetail=MemberBasicData::get()->filter('MemberID', GlobalHelper::getLoggedInUser()->ID)->first();
    if($userDetail->InseriereAls=='broker')
    $Company=MemberCompanyData::get()->filter(['MemberID' => $userDetail->MemberID])->first();
    else
    $Company=PersonalInformation::get()->filter(['MemberID' => $userDetail->MemberID])->first();
    $html = '<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice</title>

    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            color: #333;
        }

        .invoice-container {
            width: 100%;
            padding: 20px;
        }

        .header {
            display: table;
            width: 100%;
            margin-bottom: 30px;
        }

        .header .left,
        .header .right {
            display: table-cell;
            vertical-align: top;
        }

        .header .right {
            text-align: right;
        }

        h1 {
            margin: 0;
            font-size: 24px;
            color: #2c3e50;
        }

        .company-details {
            margin-top: 10px;
            line-height: 1.5;
        }

        .invoice-details {
            margin-top: 20px;
        }

        .invoice-details table {
            width: 100%;
        }

        .invoice-details td {
            padding: 3px 0;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .items-table th,
        .items-table td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .items-table th {
            background: #f5f5f5;
            text-align: left;
        }

        .text-right {
            text-align: right;
        }

        .totals {
            margin-top: 20px;
            width: 100%;
        }

        .totals table {
            width: 100%;
        }

        .totals td {
            padding: 5px;
        }

        .totals .label {
            text-align: right;
        }

        .totals .value {
            text-align: right;
            width: 120px;
        }

        .grand-total {
            font-weight: bold;
            font-size: 14px;
        }

        .footer {
            margin-top: 40px;
            font-size: 11px;
            text-align: center;
            color: #777;
        }
    </style>
</head>

<body>
<div class="invoice-container">

    <!-- Header -->
    <div class="header">
        <div class="left">
            <h1>INVOICE</h1>
            <div class="company-details">
                <strong>Wohnung mieten Berlin.de</strong><br>
                Street Address<br>
                City, ZIP<br>
                Country<br>
                Email: info@w.de
            </div>
        </div>

        <div class="right">
            <strong>Invoice #:</strong> INV-'.$id.'<br>
            <strong>Date:</strong> '.date('Y-m-d',strtotime($subscription->Created)).'<br>
            <strong>Due Date:</strong> '.date('Y-m-d',strtotime($subscription->Created)).'<br>
            <strong>Source:</strong> PayPal<br>
            <strong>Transaction ID:</strong> '.$subscription->TransactionID.'<br>
            <strong>Payer ID:</strong> '.$subscription->PayerID.'<br>
        </div>
    </div>

    <!-- Bill To -->
    <div class="invoice-details">
        <table>
            <tr>
                <td>
                    <strong>Bill To:</strong><br>
                    '.$userDetail->FirstName.' '.$userDetail->LastName.'<br>
                    '.$Company->Strabe.','.$Company->Nr.','.$Company->Plz.','.$Company->Ort.','.$Company->Land.'<br>
                    '.$userDetail->Email.'
                </td>
            </tr>
        </table>
    </div>

    <!-- Items -->
    <table class="items-table">
        <thead>
            <tr>
                <th>Description</th>
                <th class="text-right">Qty</th>
                <th class="text-right">Unit Price</th>
                <th class="text-right">Total</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>'.$subscription->Name.'</td>
                <td class="text-right">1</td>
                <td class="text-right">'.$subscription->Price.' &euro;</td>
                <td class="text-right">'.$subscription->Price.' &euro;</td>
            </tr>
           
        </tbody>
    </table>

    <!-- Totals -->
    <div class="totals">
        <table>
            <tr>
                <td class="label">Subtotal:</td>
                <td class="value">'.$subscription->Price.' &euro;/td>
            </tr>
            <tr>
                <td class="label">VAT (00%):</td>
                <td class="value">0.00 &euro;</td>
            </tr>
            <tr class="grand-total">
                <td class="label">Total:</td>
                <td class="value">'.$subscription->Price.' &euro;</td>
            </tr>
        </table>
    </div>

    <!-- Footer -->
    <div class="footer">
        Thank you for your business!<br>
      
    </div>

</div>
</body>
</html>
';

    // Dompdf options
    $options = new Options();
    $options->set('isRemoteEnabled', true);
    $options->set('defaultFont', 'DejaVu Sans');

    $dompdf = new Dompdf($options);
    $dompdf->loadHtml($html);
    $dompdf->setPaper('A4', 'portrait');
    $dompdf->render();

    // 🔽 Force download
    $dompdf->stream('invoice-'.$id.'-'.date('Ymdhis').'.pdf', [
        'Attachment' => true
    ]);

    return null;
}
}
