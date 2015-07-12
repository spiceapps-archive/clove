<?php


Layout::extend("layouts/master");

$title = "Account Registration";

$breadcrumbs = array(array("name"=>"Home","link"=>"/"),array("name"=>"Your Account"));

Part::draw("parts/alert","0",'You are now logged in as '.$current_user->email.'. <a href="/download/">Download clove</a>.');

?>
