<?php 

Layout::extend("layouts/master_xml");


 ?>

<?php 
	foreach($syncSet as $syncSet)
	Part::draw("sync/sync",$syncSet); 
	?>



