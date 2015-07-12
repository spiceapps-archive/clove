<?php

// activate

$method = $_GET;

$e = true;

if($method)
{
	require_once dirname(__FILE__)."/../spice/apps/clove/services/public/CloveUserService.php";
	
	$code	   = $method["code"];
	
	$service = new CloveUserService();
	$msg     = "";
	$msg2    = "";
		
	try
	{
		
		if($service->activateWithByEmail($code))
		{
			
			$msg = "Thanks for activating your account!";
			
			
			try
			{
				
				if($service->checkInvitedWithActivationCode($code))
				{
					$service->loginWithActivationCode($code);
					
					$msg2 = "Here's your <a href=\"http://cloveapp.com/download/\">beta download</a>!";
				}
				else
				{
					$msg2 = "We'll send you an email once you've been invited into the beta program.";
				}
				
				
				$e = false;
			}catch(Exception $e)
			{
				$m = $e->getMessage();
			}
		}
		else
		{
			$m = "Whoops! It doesn't look like that activation code is valid.";
		}
		
	}catch(Exception $e)
	{
	
		
		Logger::logError($e);
		
		
		$m = implode("<br />",Logger::getLogMessages());
		
	}
	
}

?>   
<html>
    <head>
        <link rel="stylesheet" type="text/css" media="screen" href="/backend/style.css" />
        <title>Account Activation</title>
    </head>
    <body>

        <div id="header"><a class="light" href="/">Activation &#9656;</a> <?=$e ? 'Error' : 'Success'; ?></div>
        
        <div id="content">
        <p>
     		<?=$msg; ?><br />
     		<?=$msg2; ?>
        </p>
		<br />
        <?php if($e) { ?>
        
        <div class="error">
			<b>Alert:</b> <?=$m; ?>
		</div>
		
		<?php } ?>

    </div>


    </body>
</html>