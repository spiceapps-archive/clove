<?php


Layout::extend("layouts/master");

$title = "Your Account";

$breadcrumbs = array(array("name"=>"Home","link"=>"/"),array("name"=>"Your Account"));

Part::draw("parts/alert","0",'You are now logged in as '.$current_user->email);

?>
<br />
<strong>Version 2.1</strong> <a href="/download/"><img src="http://cloveapp.com/images/btn/download.png" style="margin: 0 0 -5px 10px" /></a> 
