<?php 

Library::import('cloveApp.helpers.AccountPrivs');
Layout::extend("layouts/master");

$title = "Edit User";
$breadcrumbs = array(array("name"=>"Admin","link"=>Url::action("AdminController::index")),array("name"=>"Edit User"));


 ?>


<a href="<?=Url::action('AdminController::showPluginsInQueue'); ?>">Plugins</a><BR />
<a href="<?=Url::action('AdminController::showUsers'); ?>">Users</a>
