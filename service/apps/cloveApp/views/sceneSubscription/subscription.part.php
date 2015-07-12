<?php 

Part::input($subscription, 'SceneSubscription');

 ?>
 
<subscription>
 <id><?=$subscription->id; ?></id>
 <scene><?=$subscription->scene; ?></scene>
 <subscribed_to><?=$subscription->subscribed_to; ?></subscribed_to>
</subscription>