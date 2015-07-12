<?php
	
	
	$root = dirname(__FILE__);
	
	require_once($root."/library/bridge/node/BridgeNode.class.php");
	require_once($root."/library/bridge/core/ModuleType.class.php");
	require_once($root."/library/bridge/core/EvaluableModule.class.php");
	require_once($root."/module/TemplateModule.class.php");
	

	$data = file_get_contents($root."/bridgeScript/index.xml");
	
	//remove all white
	$data = preg_replace("/\n\r\t/","",$data);
	
	
	$parser = new XMLParser("BridgeNode");
	$script = @$parser->parseXML($data);
	
	
	//add the modules
	
	$tempModule = new TemplateModule("template",$root."/template/index.xml");
	$script->addModule($tempModule);
	
	$script->executeModules();
	
	echo $tempModule->getResult();

	//$node = new BridgeNode();
	//$node->addModule(new TemplateModule("template",$root."/template/index.xml"));
	//$node->parse($data);

?>