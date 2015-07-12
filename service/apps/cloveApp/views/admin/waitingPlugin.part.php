<?php

Part::input($version,'PluginVersion');


?>

<?=$version->plugin()->name; ?> 
<a href="<?=Url::action('AdminController::showPluginInfo',$version->id); ?>">Info</a><BR />