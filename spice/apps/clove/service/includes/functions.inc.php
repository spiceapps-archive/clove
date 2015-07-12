<?php

//returns an easy mysql connection so that the conf files do not need to be used every time
function get_mysql_connection()
{
	return new MysqlConnect($GLOBALS["mysql_server"],$GLOBALS["mysql_user"],$GLOBALS["mysql_pass"],$GLOBALS["mysql_db"]);
}


//returns a query from the queries file
function get_query($name)
{
	return $GLOBALS[$name];
}


//returns the folder where all the users are
function get_user_directory()
{
	return $GLOBALS["user_folder"];
}


//returns the default template in the config file
function get_template_directory()
{
	return $GLOBALS["template_directory"];
}

function get_settings()
{
	return $GLOBALS["pumpkin_config"];
}


//imports a utility function in the utilities directory
function import_utility($name)
{
	$dir = dirname(__FILE__);
	
	require_once('../utils/'.$name.'.php');
}



function get_server_config()
{
	//require_once(dirname(__FILE__).'/../libraries/amfphp/services/UserService.php');
	//require_once(dirname(__FILE__).'/../library/xml/XMLParser.class.php');
	//require_once(dirname(__FILE__).'/../library/bridge/BridgeNode.class.php');
	
	//$ar = new XMLParser('BridgeNode');
	
	
	//$user = new UserService();
	
    //$node = $ar->parseXML($GLOBALS["pumpkin_confg"]);
	

	//$node->setVariable("USER",$user->getLoggedInUser());
	$node->setVariable("ROOT",$GLOBALS["root_folder"]);
	
	//$node->executeModules();

	
	return $node;
}

?>