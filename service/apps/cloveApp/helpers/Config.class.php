<?php

$dirPath = dirname(__FILE__);

class Config
{
	const PLUGIN_LIBS_PATH = "pluginLibsPath";
	
	private static $_settings = array();
	
	public static function saveSetting($name,$value)
	{
		self::$_settings[$name] = $value;
	}
	
	public static function getSetting($name)
	{
		return self::$_settings[$name];
	}
}


Config::saveSetting(Config::PLUGIN_LIBS_PATH,$dirPath."/../data/cloveSources/pluginLibs/");
?>