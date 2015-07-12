<?php


$method = $_POST;


if($method)
{
	require_once dirname(__FILE__)."/../spice/apps/clove/services/public/CloveUserService.php";
	
	$name	   = $method["name"];
	$user	   = $method["email"];
	$invite    = $method["code"];	
	$password  = $method["password"];
	$subscribe = array_key_exists("subscribe",$method);
	
	
	
	$service = new CloveUserService();
	
	$m = "Location: signup/";
		

	$result = $service->register($name,$user,$password,$invite,$subscribe);
	
	
	$e = $result->errorCode;
	
	if(!$e)
	{
		$m = $result->message;
	}
	else
	{
		$m = implode("<br />",Logger::getLogs());
	}
}


?>
<html>
    <head>
        <link rel="stylesheet" type="text/css" media="screen" href="/backend/style.css" />
        <title>Account Registration</title>
    </head>
    <body>

        <div id="header"><a class="light" href="/">Registration &#9656;</a> <?=$e ? 'Error' : 'Success'; ?></div>
        
        <div id="content">
            
		<br />
        
        <div class="<?=$e ? 'error' : 'tip'; ?>">
			<b>Alert:</b> <?=$m; ?>
		</div>
	
		
    </div>


    </body>
</html>