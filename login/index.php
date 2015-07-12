<?php

// login

require_once dirname(__FILE__).'/../spice/apps/clove/services/public/CloveUserService.php';

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
			$user = $method["email"];
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
        <link rel="stylesheet" type="text/css" media="screen" href="/backend/style.css" />
        <title>Login</title>
    </head>
    <body>
    <div id="header"><a class="light" href="/">Home &#9656;</a> Your Account</div>

        <div id="content">

		<p><?= $loggedInUser ? 'You are now logged in as '.$loggedInUser.'. <a href="../download/">Download clove</a>.' : $msg; ?></p>
		
		
		
		<form action="<?=$_SERVER["PHP_SELF"]; ?>" method="post">
			<?php 
				if(!$loggedInUser)
				{
			?>
			<p><strong>Email Address:</strong><br />
        		<input type="text" name="email" id="email" value="" /></p>
        	<p><strong>Password:</strong> (Shh..)<br />
        		<input type="password" name="pass" id="password" value="" /></p>
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
			<p><input type="submit" value="<?=($loggedInUser ? 'Logout' : 'Login'); ?>" /></p>
		</form>
		
    	</div>

    </body>
</html>