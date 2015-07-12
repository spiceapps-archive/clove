<?php



//we now need to include the configuration file to handle the database information

$dir = dirname(__FILE__);

//the configuration file needed for everything
require_once($dir.'/conf.inc.php');

//get the functions 
require_once($dir.'/functions.inc.php');

//the queries that run the site
require_once($dir.'/queries.inc.php');



?>