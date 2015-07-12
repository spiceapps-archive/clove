<?php


require_once 'Zend/Amf/Value/ByteArray.php';

class CompiledPluginAsset
{
	public $isSource; //Boolean
	public $data; //ByteArray
	public $name; //String
	
	
	public function __construct($name = null,$isSource = false,$data = null)
	{
		$this->name = $name;
		$this->data = new Zend_Amf_Value_ByteArray($data);
		$this->isSource = $isSource;
	}
}

?>