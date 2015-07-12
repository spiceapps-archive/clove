<?php

error_reporting(E_ALL);

require_once(dirname(__FILE__).'/htmlpath.php');

$file = $_GET["file"];

preg_match('/\w+$/',$file,$match);

$type = strtolower($match[0]);


$file = htmlpath('files/'.$file);

switch($type)
{
	case "jpg":
	case "png":
	case "gif":
		require_once(dirname(__FILE__).'/showImage.php');
	break;
	case "mov":
	case "mp4":
	case "flv":
		require_once(dirname(__FILE__).'/showVideo.php');
	break;
	default:
		require_once(dirname(__FILE__).'/showOther.php');
	break;
}
?>