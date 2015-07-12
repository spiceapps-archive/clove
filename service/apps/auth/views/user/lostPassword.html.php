<?php


Layout::extend("layouts/master");

$title = "Account Registration";

$e = $statusCode > 0;
$m = "hello";
$breadcrumbs = array(array("name"=>"Home","link"=>"/"),array("name"=>"Lost Password"));

?>
<p><?php 
Part::draw("parts/alert",(string)$statusCode,$statusMessage); ?></p>
		
	
		
<?php $_form->begin(); ?>
						<p><strong>Email Address:</strong>
        		<input type="text" name="email" id="email" value="" /></p>
        	
			<input type="hidden" name="action" value="login" />
						<p><input type="submit" value="submit" /></p>
		<?php $_form->end(); ?>
