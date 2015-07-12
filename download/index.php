<?php

// download


require_once dirname(__FILE__)."/../spice/apps/clove/services/public/CloveUserService.php";


$service = new CloveUserService();


try
{
	$service->verifySession();
}catch(Exception $e)
{
	header("Location: ../");
}


$file = "../../files/CloveApp.air";



header('Content-Type: application/force-download');
header('Content-disposition: attachment; filename=CloveApp.air');
header('Pragma: public');
header('Content-length: '.fileSize($file));

readfile($file);



?>