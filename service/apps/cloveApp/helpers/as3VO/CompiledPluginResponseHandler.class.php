<?php

require_once dirname(__FILE__).'/CompiledPlugin.php';
require_once dirname(__FILE__).'/CompiledPluginInfo.php';
require_once dirname(__FILE__).'/CompiledPluginAsset.php';

require_once( "Zend/Amf/Value/ByteArray.php" );
require_once( "Zend/Amf/Value/Messaging/ArrayCollection.php" );
class CompiledPluginResponseHandler
{
	public $info;
	public $assets; 
	
	
	public function getCompiledPlugin()
	{
		$info = new CompiledPluginInfo("Twitter","desc","factory","uid","dbid",date_create(),"version","sdkVersion","vers_desc",date_create());
		$assets = new Zend_Amf_Value_Messaging_ArrayCollection();
		$assets->source = 
		array(new CompiledPluginAsset("library.swf",true,new Zend_Amf_Value_ByteArray("this is some data")),
		new CompiledPluginAsset("library.swf",true,new Zend_Amf_Value_ByteArray("this is some data")),
		new CompiledPluginAsset("library.swf",true,new Zend_Amf_Value_ByteArray("this is some data")),
		new CompiledPluginAsset("library.swf",true,new Zend_Amf_Value_ByteArray("this is some data")),
		new CompiledPluginAsset("library.swf",true,new Zend_Amf_Value_ByteArray("this is some data")),
		new CompiledPluginAsset("library.swf",true,new Zend_Amf_Value_ByteArray("this is some data")));
		
		return new CompiledPlugin($info,$assets);
	}
}


?>