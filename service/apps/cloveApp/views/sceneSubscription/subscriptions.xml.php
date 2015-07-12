<?php 
	Layout::extend("layouts/master_xml");
 ?>
 

 <?php 
	foreach($sceneSubscriptionSet as $subscription)
	Part::draw("sceneSubscription/subscription",$subscription); 
	?>
 





