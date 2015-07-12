<?php

Part::input($plugin,'Plugin');

?>

<?=$plugin->name; ?> - <a href="<?=Url::action('PluginController::editPlugin',$plugin->id);?>">change</a>  <a href="<?=Url::action('PluginController::updatePlugin',$plugin->id);?>">update</a><BR />

<?php foreach($plugin->pluginVersions() as $version): ?>
	
version <?=$version->version; ?> <?=$version->approved ? "APPROVED" : "" ?><BR />



<?php endforeach; ?>