<?php

require_once('TwitterTracker.class.php');

if(!array_key_exists("id",$_GET))
	exit(json_encode(array("error"=>"no ID has been specified.")));
	
$uid = $_GET["id"];
$type= $_GET["type"];




$track = new TwitterTracker("cache/");


switch($type)
{
	case "getConversationLength":
		echo json_encode(array("length"=>$track->getConversationLength($uid)));
	break;
	case"getConversation":
		echo $track->track($uid);
	break;
	default:
		echo json_encode(array("error"=>"undefined request ".$type));
	break;
}







?>