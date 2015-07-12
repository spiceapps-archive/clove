<?php

//we want to treat classes like packages so change the current directory to the root of all classes
ini_set('error_reporting', E_ALL);


$cdir = dirname(__FILE__);

//database info
define("DB_SERVER","internal-db.s40564.gridserver.com");
define("DB_NAME","db40564_spiceusers");
define("DB_USER","db40564");
define("DB_PASS","vj4SKQ8J");
define("TABLE_PREFIX","");
define("ROOT_DIR",realpath(dirname(__FILE__)."../")."/");
define("APP_LIB_DIR",realpath(dirname(__FILE__)."/../library/")."/");


//path info
define("CORE_DIR",dirname(__FILE__)."/../../../core/");
define("CORE_SERVICES_DIR",CORE_DIR."services/");

//library dir
define("LIBRARY_DIR",dirname(__FILE__)."/../../../library");



//SMTP
define("SMTP_OUTGOING","mail.s40564.gridserver.com");
//define("SMTP_OUTGOING","localhost");
define("SMTP_USERNAME","craig@spiceapps.com");
define("SMTP_PASSWORD","zi7JYUpA2GgLNW");
define("SMTP_FROM_EMAIL","craig@spiceapps.com");
define("SMTP_FROM_NAME","Support");
define("SMTP_PORT",25);
?>