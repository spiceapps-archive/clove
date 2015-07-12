<?php

require_once(LIBRARY_DIR."/mysql/MysqlConnect.class.php");

//returns an easy mysql connection so that the conf files do not need to be used every time
function get_mysql_connection()
{
	return new MysqlConnect(DB_SERVER,DB_USER,DB_PASS,DB_NAME);
}


//returns a query from the queries file
function get_query($name)
{
	global $queries;
	return $queries[$name];
}


?>