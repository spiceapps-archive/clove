<?php


class BugUtil
{
	
	private static $_buggedCodeDir = null;
	
	public static function getBuggedCodeDir($report)
	{
		if(!self::$_buggedCodeDir)
			self::$_buggedCodeDir = dirname(__FILE__)."/../data/logs/bugs/".$report->uid;
			
		return self::$_buggedCodeDir;
	}
	
	public static function getBuggedCodeZip($report,$make = true)
	{
		
		$dir = self::getBuggedCodeDir($report);
		
		if($make)
		{
			@mkdir(self::getBuggedCodeDir($report),0777,true);
		}
		
		
		return $dir."/settings.zip";
		
	}
	
	
	
	
	public static function download($report)
	{
		
		$file = self::getBuggedCodeZip($report,false);
		
		
		if(!file_exists($file))
			return false;
			//die($tmpFile);
		// we deliver a zip file
		header("Content-Type: archive/zip");


		// filename for the browser to save the zip file
		header("Content-disposition: attachment; filename=settings.zip");


		// get a tmp name for the .zip
		//$tmp_zip = tempnam ("tmp", "tempname") . ".zip";


		//$zip->close();

		echo file_get_contents($file);
	}
}


?>