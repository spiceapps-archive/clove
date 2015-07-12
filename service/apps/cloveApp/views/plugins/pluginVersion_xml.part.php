<?php

Part::input($version,'PluginVersion');

$plugin = $version->plugin();

?>
<plugin>
	<name><?=$plugin->name; ?></name>
	<description><?=$plugin->description; ?></description>
	<download><?="http://".$_SERVER['HTTP_HOST'].Url::action("PluginInfoController::downloadUpdate",$version->id)?></download>
	<uid><?=$plugin->uid; ?></uid>
	<factory><?=$plugin->factory; ?></factory>
	<created_at><?=$plugin->created_at; ?></created_at>
	<updated_at><?=$version->created_at; ?></updated_at>
	<version_description><?=$version->update_info; ?></version_description>
	<currentVersion><?=$version->version; ?></currentVersion>
</plugin>