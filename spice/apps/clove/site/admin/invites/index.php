<?php


require_once dirname(__FILE__).'/../../../services/public/CloveUserService.php';

$inviteNum = 10;
$addInvite = "add invite";


$userService = new CloveUserService();
$inviteService = new InviteCodeService();

//admin level
$userService->verifySession(1);


$method = $_POST;

$msg = "";

if($method)
{
	$action = $method["action"];
	
	
	switch($action)
	{
		case "invite";
			$num = $method["invite"];
			$msg = "invited $num people.";
			
			
			$inviteService->inviteUsers($num);
		break;
		case "addInvite";
			$name = $method["name"];
			$num  = $method["num"];
			
			$inviteService->addInviteCode($name,$num);
		break;
		
	}
}


if($_GET)
{
	if($_GET["deleteInvite"])
	{
		$inviteService->removeInvite($_GET["deleteInvite"]);
	}
}


			

?>

<html>
	<head>
		<title>login</title>
	</head>
	
	<body>
		<p><?=$msg; ?></p>
		<p>Logged in as <?=$userService->userName() ?></p>
		
		
		
		Invite X people:
		<form action="<?=$_SERVER["PHP_SELF"]; ?>" method="post">

			<input type="text" name="invite" value="<?=$inviteNum; ?>" />
			<input type="hidden" name="action" value="invite" />

			
			
			<input type="submit" value="invite" />
		</form>
		
		
		
		Add Invite Code:
		<form action="<?=$_SERVER["PHP_SELF"]; ?>" method="post">

			<input type="text" name="name" value="<?=$addInvite; ?>" />
			<input type="text" name="num" value="-1" />
			<input type="hidden" name="action" value="addInvite" />

			
			
			<input type="submit" value="invite" />
		</form>
		
		
		
		
		<table border="1">
			<tr>
				<th>Invite Code:</th>
				<th>Invites Left:</th>
				<th>Action:</th>
			</tr>
			
			<?php
			
			$codes = $inviteService->getInviteCodes();
			
			foreach($codes as $code)
			{
			?>
			<tr>
				<td><?=$code["code"] ?></td>
				<td><?=$code["invites_left"] ?></td>
				<td><a href="<?=$_SERVER['PHP_SELF']; ?>?deleteInvite=<?=$code['id']; ?>">delete</a></td>
			</tr>
			
			<?php 
			}
			?>
		</table>
	</body>
</html><strong></strong>