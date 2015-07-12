<?php

//we want to treat classes like packages so change the current directory to the root of all classes


$cdir = dirname(__FILE__);

//database info
define("DB_SERVER","localhost");
define("DB_NAME","BugTracker");
define("DB_USER","root");
define("DB_PASS","root");
define("ROOT_DIR",realpath(dirname(__FILE__)."../../")."/");

//path info
define("CORE_DIR",dirname(__FILE__)."/../../../core/");
define("CORE_SERVICES_DIR",CORE_DIR."services/");

//library dir
define("LIBRARY_DIR",dirname(__FILE__)."/../../../library");

?>