<?php 

Library::import('cloveApp.helpers.AccountPrivs');
Layout::extend("layouts/master");

$title = "Edit User";
$breadcrumbs = array(array("name"=>"Admin"),array("name"=>"Plugins in Queue"));


foreach($pluginSet as $plugin)
{
	Part::draw('admin/waitingPlugin',$plugin);
}

 ?>


