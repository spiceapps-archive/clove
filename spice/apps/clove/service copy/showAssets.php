<?php

require_once(dirname(__FILE__).'/config.inc.php');
require_once(dirname(__FILE__).'/php/htmlpath.php');




$req = "";

foreach(scandir($dir) as $file)
{
	if($file == "." || $file == ".." || $file == ".DS_Store")
		continue;
		
	$to = $dir."/".$file;
	
	$driver = "false";
	if(strstr($to,"service.xml"))
		$driver = "true";
		
	$req .= '<plugin:asset src="'.htmlpath($to).'" saveTo="'.$install."/".$file.'" isDriver="{'.$driver.'}" />';
}
?>
<?=$req; ?>
