<?php



//we now need to include the configuration file to handle the database information

$dir = dirname(__FILE__);

//the configuration file needed for everything
require_once($dir.'/conf.inc.php');

//the queries that run the site
require_once($dir.'/queries.inc.php');

//the class that handles all parameters passed to the database
require_once($dir."/../library/security/InputSaftey.class.php");

//the class that handles all database connections
require_once($dir.'/../library/database/MysqlConnect.class.php');

//the class that stores a static error log that is used throughout all scripts
require_once($dir.'/../library/log/ErrorLog.class.php');

//the list of small functions that handle core functionality
require_once($dir.'/functions.inc.php');

?>