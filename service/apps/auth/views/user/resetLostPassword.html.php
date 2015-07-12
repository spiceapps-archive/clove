<?php


Layout::extend("layouts/master");

$title = "Account Registration";

$e = $statusCode > 0;
$m = "hello";
$breadcrumbs = array(array("name"=>"Home","link"=>"/"),array("name"=>"Reset Lost Password"));

?>
<p><?php 
Part::draw("parts/alert",(string)$statusCode,$statusMessage); ?></p>
		
	
		
<?php $_form->begin(); ?>
						<p><strong>New  Password:</strong>
        		<input type="password" name="password" id="password" value="" /></p>
        	
			<input type="hidden" name="action" value="login" />
						<p><input type="submit" value="reset" /></p>
		<?php $_form->end(); ?>
