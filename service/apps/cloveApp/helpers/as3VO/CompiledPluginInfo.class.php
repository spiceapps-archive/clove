<?php

class CompiledPluginInfo
{
	public $guid; //String
	public $name;//String
	public $sdkVersion;//String
	public $createdAt;//String
	public $updatedAt;//String
	public $description;//String
	public $factoryClass;//String
	public $updateInfo;//String
	public $version;
	
	public function __construct($name = null,
								$description = null,
								$factoryClass = null,
								$uid = null,
								//$dbid = null,
								$created_at = null,
								
								$version = null,
								$sdkVersion = null,
								$version_description = null,
								$updated_at = null)
	{
		$this->guid = $uid;
		$this->name = $name;
		$this->sdkVersion = $sdkVersion;
		$this->createdAt = $created_at;
		$this->updatedAt = $updated_at;
		$this->description = $description;
		$this->factoryClass = $factoryClass;
		$this->version = $version;
		$this->updateInfo = $version_description;
	}
								
			
}

?>