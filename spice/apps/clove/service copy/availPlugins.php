
<?php
//use MYSQL instead
require_once(dirname(__FILE__).'/config.inc.php');
require_once(dirname(__FILE__).'/php/htmlpath.php');


$dir = $_GLOBALS["plugin_dir"];


$types = array();

$plug = "<Neem>";


$installDir = htmlpath(dirname(__FILE__).'/install.php');

foreach(scandir($dir) as $file)
{
	
	
	if($file == "." || $file == ".." || $file == ".DS_Store")
		continue;
	
	
	
	if(is_dir($dir."/".$file))
	{
		foreach(scandir($dir."/".$file) as $plugin)
		{
			if($plugin == "." || $plugin == ".." || $plugin == ".DS_Store")
				continue;
				
			$plug .="<Plugin>";
			$plug .="<cat>";
			$plug .= $file;
			$plug .="</cat>";
			$plug .= "<name>";
			$plug .= $plugin;
			$plug .= "</name>";
			$plug .= "<package>";
			$plug .= $installDir."?install=".$file."/".$plugin;
			$plug .= "</package>";
			$plug .= "</Plugin>";
			
		}
	}
	
}


$plug .= "</Neem>";


echo $plug;

?>