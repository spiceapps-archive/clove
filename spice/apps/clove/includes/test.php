<?php


//require_once(dirname(__FILE__)	.'/conf.inc.php');

define("APP_LIB_DIR",realpath(dirname(__FILE__)."/../library/")."/");


//SMTP
define("SMTP_OUTGOING","mail.s40564.gridserver.com");
//define("SMTP_OUTGOING","localhost");
define("SMTP_USERNAME","craig@spiceapps.com");
define("SMTP_PASSWORD","zi7JYUpA2GgLNW");
define("SMTP_FROM_EMAIL","craig@spiceapps.com");
define("SMTP_FROM_NAME","Support");
define("SMTP_PORT",25);


//send an email off to the user
function smtp_mail($to,$subject,$message)
{
	require_once APP_LIB_DIR.'/swiftMailer/lib/swift_required.php';
	
	
	$transport = Swift_SmtpTransport::newInstance(SMTP_OUTGOING,SMTP_PORT);
	
	echo SMTP_USERNAME;
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
smtp_mail("craig.j.condon@gmail.com","from somebody","to somebody");


?>