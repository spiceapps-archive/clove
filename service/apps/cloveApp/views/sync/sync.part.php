<?php 

Part::input($sync, 'Sync');

 ?>
 
<sync>
 <id><?=$sync->id; ?></id>
 <?=Part::draw("screen/screen",$sync->screen()); ?>
 <?=Part::draw("scene/scene",$sync->scene()); ?>
 <created_at><?=$sync->created_at; ?></created_at>
 <url><?=$sync->downloadUrl; ?></url>
</sync>
