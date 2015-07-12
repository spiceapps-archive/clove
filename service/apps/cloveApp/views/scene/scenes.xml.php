<?php 
	Layout::extend("layouts/master_xml");
 ?>
 

 <?php 
	foreach($sceneSet as $scene)
	Part::draw("scene/scene",$scene); 
	?>
 





