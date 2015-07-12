<?php



$prefix = $GLOBALS["table_prefix"];

$userTable		  = $prefix."users";
$pluginTable	  = $prefix."plugins";
$synchroTable	  = $prefix."synchro";


//USER QUERIES

//inserting users
$GLOBALS["REGISTER_USER"] = "INSERT INTO $userTable (`email`,`password`) VALUES('#anything','#anything')";

//checking if user exists
$GLOBALS["GET_USER"]      = "SELECT `email` FROM $userTable WHERE `email` = '#anything'";

//check login credentials
$GLOBALS["LOGIN_USER"]    = "SELECT `email`,`id` FROM $userTable WHERE `email` = '#anything' && `password` = '#anything'";


//PLUGIN QUERIES

//register new plugin
$GLOBALS["INSERT_PLUGIN"] = "INSERT INTO $pluginTable (`name`,`description`,`type`,`filePath`,`owner`) 
												VALUES('#anything','#anything','#anything','#anything','#anything')";

$GLOBALS["SELECT_PLUGINS"] = "SELECT * FROM $pluginTable WHERE `owner` = '#anything'";


$GLOBALS["SELECT_PLUGIN_BY_NAME"] = "SELECT * FROM $pluginTable WHERE `name` = '#anything' LIMIT 1";

$GLOBALS["SELECT_PLUGIN_BY_ID"] = "SELECT * FROM $pluginTable WHERE `id` = '#anything' LIMIT 1";


$GLOBALS["UPDATE_PLUGIN"] = "UPDATE $pluginTable SET `name` = '#anything',`description`='#anything' WHERE `id`='#anything' AND `owner` = '#anything'";


//SYNC
$GLOBALS["ADD_HISTORY"]	   = "INSERT INTO $synchroTable (`owner`,`filePath`,`date_added`) VALUES('#anything','#anything',NOW())";

$GLOBALS["GET_HISTORY"]	   = "SELECT * FROM $synchroTable WHERE (`date_added` > '#anything' AND `owner` = '#anything') ORDER BY `date_added` DESC LIMIT 1";

//$GLOBALS["GET_HISTORY"]	   = "SELECT * FROM $synchroTable WHERE (`date_added` > '#anything' AND `owner` = '#anything') ORDER BY `date_added` DESC LIMIT 1";

?>
