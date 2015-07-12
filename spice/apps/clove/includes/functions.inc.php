<?php

require_once(LIBRARY_DIR."/mysql/MysqlConnect.class.php");

//returns an easy mysql connection so that the conf files do not need to be used every time
function get_mysql_connection()
{
	return new MysqlConnect(DB_SERVER,DB_USER,DB_PASS,DB_NAME);
}


//returns a query from the queries file
function get_query($name)
{
	global $queries;
	return $queries[$name];
}


//send an email off to the user
function smtp_mail($to,$subject,$message)
{
	require_once APP_LIB_DIR.'/swiftMailer/lib/swift_required.php';
	
	
	$transport = Swift_SmtpTransport::newInstance(SMTP_OUTGOING,SMTP_PORT);
	
	if(defined("SMTP_USERNAME"))
		$transport->setUsername(SMTP_USERNAME);
		
	if(defined("SMTP_PASSWORD"))
		$transport->setPassword(SMTP_PASSWORD);
	
	
	$mailer = Swift_Mailer::newInstance($transport);
	
	
	$from = array();
	$from[SMTP_FROM_EMAIL] = SMTP_FROM_NAME;
	
	$message = Swift_Message::newInstance($subject)
	->setFrom($from)
	->setTo(is_array($to) ? $to : array($to))
	->setBody($message);
	
	$mailer->batchSend($message);
}


function do_post_request($url, $data, $optional_headers = null) 
{
	$c= curl_init();
	curl_setopt($c, CURLOPT_URL,$url);
	curl_setopt($c, CURLOPT_POST,true);
	
	$params = array();
	
	foreach($data as $k => $v)
	{
		$params[] = "$k=$v";
	}
	
	
	curl_setopt($c, CURLOPT_POSTFIELDS, implode("&",$params));
	
	//remove the echo that comes in via curl
	ob_start();
	curl_exec($c);
	ob_end_clean();
	
	curl_close($c);
}
?>