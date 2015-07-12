<?php 

Part::input($scene, 'Scene');

 ?>
 
<scene>
 <id><?=$scene->id; ?></id>
 <name><?=$scene->name; ?></name>
 <description><?=$scene->description; ?></description>
 <created_at><?=$scene->created_at; ?></created_at>
	
	
	<?php
	
		foreach($scene->scene_subscriptions() as $subscription)
		{
			Part::draw("sceneSubscription/subscription",$subscription);
		}
	
	?>
</scene>