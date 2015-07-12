<?php


function local_path($path)
{
	
	$host = $_SERVER["HTTP_HOST"];
	
	$reg = "/.*?$host\\/(.*)/is";
	
	
	$newPath = preg_replace($reg,$_SERVER["DOCUMENT_ROOT"]."/\\1",$path);
	
	return $newPath;
}


?>