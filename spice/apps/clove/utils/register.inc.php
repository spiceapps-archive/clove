<?php


require_once dirname(__FILE__).'/../services/public/CloveUserService.php';

$userService = new CloveUserService();


$method 	   = $_POST;
$msg 		   = "";
$errorLoginMsg = "That email address has already been registered";

$email = "email";
$fn = "Full Name";
$pass  = "password";
$invite  = "invite";
$success = false;

if($method)
{
	$fn = $method["fn"];
	$email = $method["email"];
	$pass  = $method["pass"];
	$invite = $method["invite"];

	
	
	
	try
	{
		$message = $userService->register($fn,$email,$pass,$invite);
		
		if(!$message)
		{
			$msg = $errorLoginMsg;
		}
		else
		{
			$msg = $message;
			$success = true;
		}
	}catch(Exception $e)
	{
		$msg = $errorLoginMsg;
	}
	
}


?>

<html>
	<head>
		<title>register</title>
		
		<?= $success ? '<meta http-equiv="REFRESH" content="2;url=login.inc.php"></HEAD>': ''; ?>
	</head>
	
	
	<body>
		<p><?=$msg; ?></p>
		
		
		<form action="<?=$_SERVER["PHP_SELF"]; ?>" method="post">

			<input type="text" name="fn" value="<?=$fn; ?>" />
			<input type="text" name="email" value="<?=$email; ?>" />
			<input type="password" name="pass" value="<?=$pass; ?>" />
			<input type="text" name="invite" value="<?=$invite; ?>" />
			<input type="hidden" name="action" value="login" />
			
			<input type="submit" value="register" />
		</form>
	</body>
</html>