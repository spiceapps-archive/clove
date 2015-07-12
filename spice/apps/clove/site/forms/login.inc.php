<?php


require_once dirname(__FILE__).'/../../services/public/CloveUserService.php';

$userService = new CloveUserService();


$method = $_POST;
$msg = "";
$errorLoginMsg = "The username or password specified is incorrect.";

$user = "username";
$pass = "password";

if($method)
{
	$action = $method["action"];
	
	
	
	switch($action)
	{
		
		case "login":
			$user = $method["user"];
			$pass = $method["pass"];
		
			
			
			
			try
			{
				if(!$userService->login($user,$pass))
				{
					$msg = $errorLoginMsg;
				}
				else
				{
					$msg = "Thanks for logging in.";
				}
			}catch(Exception $e)
			{
				$msg = $e->getMessage();
			}
		break;
		
		case "logout":
			$userService->logout();
			$msg = "You are now logged out.";
		break;
	}
	
}


/*

function handleRequest()
{
	$args = func_get_args();
	
	$method = array_unshift($args);
	
	$params = $args;
	
	
}

handleRequest($method,$userService)
*/


$loggedInUser = $userService->userName();

?>

<html>
	<head>
		<title>login</title>
	</head>
	
	<body>
		<p><?= $loggedInUser ? 'You are now logged in as '.$loggedInUser : $msg; ?></p>
		
		
		
		<form action="<?=$_SERVER["PHP_SELF"]; ?>" method="post">
			<?php 
		
				if(!$loggedInUser)
				{
			?>
			<input type="text" name="user" value="<?=$user; ?>" />
			<input type="password" name="pass" value="<?=$pass; ?>" />
			<input type="hidden" name="action" value="login" />
			
			<?php
				}
				else
				{
			?>
			
			<input type="hidden" name="action" value="logout" />
			
			<?php
				}
			?>
			
			
			
			<input type="submit" value="<?=($loggedInUser ? 'logout' : 'login'); ?>" />
		</form>
	</body>
</html>