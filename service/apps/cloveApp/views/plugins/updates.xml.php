<?php

Layout::extend("layouts/master_xml");

foreach($updateSet as $plugin)
{
	Part::draw('plugins/pluginVersion_xml',$plugin);
}

?>

