<?php



$title = "Account Registration";

$breadcrumbs = array(array("name"=>"Authentication","link"=>"/"));


Layout::extend("layouts/master");



Part::draw("parts/alert",(string)$statusCode,$statusMessage);

?>