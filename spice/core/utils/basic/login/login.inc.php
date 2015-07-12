<?php


require_once dirname(__FILE__)."/../../../services/UserService.php";


function loginUser(UserService $service,$user,$pass,&$message)
{

	
	try
	{
		if($service->login($user,$pass))
		{
			$success = true;
		}
		else
		{
			$success = false;
		}
		
	}catch(Exception $e)
	{
		$success = false;
	}
	
	
	$message = $success ? " Thanks for logging in." : "The specified username / password is incorrect.";
	
	return $success;
	
}

function logoutUser(UserService $service,&$message)
{
	$service->logout();
	
	$message = "You are now logged out";
	return true;
}


function handleRequest(UserService $service,$method,&$message)
{
	if(!$method)
		return;
	
	$action = $method["action"];
	$user   = $method["user"];
	$pass   = $method["pass"];
	
	
	
	switch($action)
	{
		case "login";
			return loginUser($service,$user,$pass,$message);
		break;
		case "logout";
			return logoutUser($service,$message);
		break;
	}
	
}

?>