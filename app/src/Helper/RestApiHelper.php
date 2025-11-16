<?php 
namespace App\Helper;
use SilverStripe\Control\HTTPResponse;
class RestApiHelper {
    static public function jsonOk(array $payload = []): HTTPResponse
    {
        $resp = HTTPResponse::create(json_encode(['ok' => true] + $payload));
        $resp->addHeader('Content-Type', 'application/json');
        return $resp;
    }
    
    static public function jsonError(string $msg, int $code = 400): HTTPResponse
    {
        $resp = HTTPResponse::create(json_encode(['ok' => false, 'error' => $msg]));
        $resp->addHeader('Content-Type', 'application/json');
        $resp->setStatusCode($code);
        return $resp;
    }  
}