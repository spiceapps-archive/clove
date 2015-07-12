<?php 
	Layout::extend("layouts/master_xml");
 ?>
 

 <?php 
	foreach($screenSet as $screen)
	Part::draw("screen/screen",$screen); 
	?>
 





