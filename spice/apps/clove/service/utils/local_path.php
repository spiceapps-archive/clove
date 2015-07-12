<?php


function local_path($path)
{
	$reg = '/^([\w-]+:\/\/)*[\w-]+(\.\w+)*(:\d+)*/';
	
	$newPath = preg_replace($reg,$_SERVER["DOCUMENT_ROOT"],$path);
	
	return $newPath;
}


?>