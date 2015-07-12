<?php 

Library::import('cloveApp.helpers.AccountPrivs');
Layout::extend("layouts/master");

$title = "Plugin Info";
$breadcrumbs = array(array("name"=>"Admin","link"=>Url::action("AdminController::index")),array("name"=>"Plugin Info"));


 ?>



<a href="<?=Url::action('AdminController::approvePlugin',$version->id); ?>">Approve</a>
<a href="<?=Url::action('AdminController::downloadPluginSource',$version->id); ?>">Download Source</a>