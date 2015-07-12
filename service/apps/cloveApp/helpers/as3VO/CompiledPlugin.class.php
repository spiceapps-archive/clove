<?php

require_once( "Zend/Amf/Value/Messaging/ArrayCollection.php" );

class CompiledPlugin
{
	public $info; //PluginInfo
	
	/**
	 * @type Zend_Amf_Value_Messaging_ArrayCollection
	 */
	 
	public $assets; //ArrayCollection
	
	
	public function __construct($info = null,$assets = null)
	{
		$this->info = $info;
		$col = new Zend_Amf_Value_Messaging_ArrayCollection();
		$col->source = $assets;
		
		$this->assets = $col;
	}
}


?>