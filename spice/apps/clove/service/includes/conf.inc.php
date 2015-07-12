<?php

//we want to treat classes like packages so change the current directory to the root of all classes


$cdir = dirname(__FILE__);

chdir($cdir);

$GLOBALS["mysql_server"]	     = "localhost";
$GLOBALS["mysql_db"]		     = "Clove";
$GLOBALS["mysql_user"]		     = "root";
$GLOBALS["mysql_pass"]		     = "root";
$GLOBALS["table_prefix"]         = "clove_";

//$GLOBALS["mysql_server"]	     = "localhost";
//$GLOBALS["mysql_db"]		     = "Clove";
//$GLOBALS["mysql_user"]		     = "root";
//$GLOBALS["mysql_pass"]		     = "root";
//$GLOBALS["table_prefix"]         = "clove_";

$GLOBALS["root_folder"]	         = realpath(dirname(__FILE__)."/../../")."/";


$GLOBALS["plugin_folder"]	     = $GLOBALS["root_folder"]."service/farm/plugins/";
$GLOBALS["sync_folder"]	     = $GLOBALS["root_folder"]."service/farm/syncs/";





?>