<?php
header('Content-Type: application/json');
//SETUP
  //SF
$sfTokenGenURL = "https://login.salesforce.com/services/oauth2/token";
$endpoint = "/services/apexrest/DanBotRestService";

//user information
$username="";
$password="";//password+token
$clientName="";
$clientSecret="";


//commands

$commands = substr(strstr($_POST["text"]," "), 1);


// Get cURL resource
$curl = curl_init();
// Set some options - we are passing in a useragent too here
curl_setopt_array($curl, array(
    CURLOPT_RETURNTRANSFER => 1,
    CURLOPT_URL => $sfTokenGenURL,
    CURLOPT_POST => 1,
    CURLOPT_POSTFIELDS => array(
        grant_type => 'password',
        client_id => $clientName,
	client_secret => $clientSecret,
	username => $username,
	password => $password
    )
));

// Send the request to login, save acess token and orgURL
$resp = curl_exec($curl);
$responseObject = json_decode($resp, true);
$accessToken = $responseObject["access_token"];
$orgURL = $responseObject["instance_url"];
curl_close($curl);

//new request to the service
$ncurl = curl_init();

$data = array("command"=>$commands);
$dataString = json_encode($data);

curl_setopt_array($ncurl, array(
    CURLOPT_RETURNTRANSFER => 1,
    CURLOPT_URL => $orgURL.$endpoint,
    CURLOPT_HTTPHEADER => array(                                                                          
    'Content-Type: application/json',                                                                                
    'Content-Length: ' . strlen($dataString),
		'Authorization: Bearer '. $responseObject["access_token"]),
    CURLOPT_POST => 1,
    CURLOPT_POSTFIELDS => $dataString

));


// Send the request & save response to $resp
$nresp = curl_exec($ncurl);
echo $nresp;
curl_close($nresp);

?>
