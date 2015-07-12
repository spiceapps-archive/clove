<?php


Layout::extend("layouts/master");

$title = "Set New Password";

$e = $statusCode > 0;
$m = "hello";
$breadcrumbs = array(array("name"=>"Home","link"=>"/"),array("name"=>"Set New Password"));

?>
<p><?php 
Part::draw("parts/alert",(string)$statusCode,$statusMessage); ?></p>
		
	
		
			<?php $_form->begin(); ?>
				<p><strong>New Password:</strong><br />
				<input type="password" name="password" id="password" value="" /></p>

				<input type="hidden" name="action" value="login" />
				<p><input type="submit" value="Set Password" /></p>
			<?php $_form->end(); ?>
