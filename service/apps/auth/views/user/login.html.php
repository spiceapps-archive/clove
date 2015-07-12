<?php


Layout::extend("layouts/master");

$title = "Login";

$e = $statusCode > 0;
$m = "hello";
$breadcrumbs = array(array("name"=>"Home","link"=>"/"),array("name"=>"Your Account"));

?>
<p><?php 
Part::draw("parts/alert",(string)$statusCode,$statusMessage); ?></p>
		
	
		
		<?php $_form->begin(); ?>

			<p><strong>Email Address:</strong><br />
			<input type="text" name="email" id="email" value="" /></p>

			<p><strong>Password:</strong> (Shh..)<br />
			<input type="password" name="password" id="password" value="" /></p>
			<?=Html::anchor(Url::action('UserController::lostPassword'), 'Lost your password?'); ?>

			<input type="hidden" name="action" value="login" />
			<p><input type="submit" value="Login" /></p>

		<?php $_form->end(); ?>
