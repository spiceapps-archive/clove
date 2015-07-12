<?php

require_once(dirname(__FILE__).'/includes/headers.inc.php');


$con = mysql_connect($GLOBALS["mysql_server"],$GLOBALS["mysql_user"],$GLOBALS["mysql_pass"]);
$con = mysql_select_db($GLOBALS["mysql_db"]);
$prefix = $GLOBALS["table_prefix"];


if(!$con)
{
	echo mysql_error()."<BR>";
	exit();
}

//create the user tables

$sql[] = 

"CREATE TABLE `".$prefix."users`

(
	id int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(id),

	`email`	  text,
	`password`  text,
	`privs`	int(11)
);

";   

//echo $sql[0];

//create the site tables

$sql[] =


"CREATE TABLE `".$prefix."plugins`

(

	id int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(id),
	
	`name`	varchar(30),
	`description` text,
	`type` varchar(30),
	`filePath` text,
	`owner` int(11)
);

";

$sql[] =


"CREATE TABLE `".$prefix."plugin_stats`

(

	id int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(id),
	
	`ratings` int(11),
	`rating` int(11),
	`downloads` int(11)
);

";


$sql[] =


"CREATE TABLE `".$prefix."synchro`

(

	id int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(id),
	`owner` int(11),
	`date_added` text,
	`filePath`   text,
	`used`   boolean
);

";


$sql[] = 

"CREATE TABLE `".$prefix "store_forms`
(
	id int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY(id),
	`fullName` varchar(40),
	`email` text,
	`company` text
)";







echo "creating databases <BR>";


for($i = 0; $i < count($sql); $i++)
{

	$result = mysql_query($sql[$i]);
	
	if(mysql_error())
	{
		echo mysql_error()."<BR>";
		
	}
}

echo "successfully created tables.";


?>