<?php


Layout::extend("layouts/master");

$title = "Account Registration";

$e = $statusCode > 0;
$m = "hello";
$breadcrumbs = array(array("name"=>"Home","link"=>"/"),array("name"=>"Your Account"));

?>
<p><?php 
Part::draw("parts/alert",(string)$statusCode,$statusMessage); ?></p>
		
	
		
<?php $_form->begin(); ?>
			<p><strong>Email Address:</strong>
        	<input type="text" name="email" id="email" value="" /></p>
        	<p><strong>Password:</strong> (Shh..)
        	<input type="password" name="password" id="password" value="" /></p>

			<input type="hidden" name="action" value="login" />
			<p><input type="submit" value="Login" /></p>
<?php $_form->end(); ?>
