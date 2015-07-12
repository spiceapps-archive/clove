<?php 

Layout::extend("layouts/master");

$title = "Plugins";
$breadcrumbs = array(array("name"=>"Plugins"));


foreach($pluginSet as $plugin)
{
	Part::draw('managePlugins/pluginListItem',$plugin);
}
 ?>











