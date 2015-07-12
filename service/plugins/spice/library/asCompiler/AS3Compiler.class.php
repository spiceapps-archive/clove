<?php

require_once(dirname(__FILE__).'/../security/InputSafety.class.php');
require_once(dirname(__FILE__).'/../utils/FileUtils.class.php');
require_once(dirname(__FILE__).'/../utils/ZipUtil.class.php');



function simplexml_find_nodes($node,$name,$index = -1,&$stack = null)
{
	if(!$stack)
		$stack = array();
		
	if(count($stack) > 0)
		return;
		
	foreach($node->children() as $child)
	{
			
		if($child->getName() == $name)
		{
			$stack[] = $child;
		}
		
		simplexml_find_nodes($child,$name,$index,$stack);
		
		
	}	
	
	if(count($stack) > 0)
	{
		if($index > -1)
			return $stack[$index];
		
		return $stack;
	}
}

class AS3Compiler
{
	private $_additional_arguments = null;
	private $_sourcePath = false;
	private $_outputPath = false;
	private $_outputName = false;
	private $_config = null;
	private $_compilerDir = null;
	private $_include_classes = array();
	private $_include_libraries = array();
	private $_library_paths     = array();
	
	private $_tmpDir = false;

	private $_locale = "en_US";
	
	protected $_warnings = array();
	protected $_errors   = array();
	
	const AS3_LIBRARY_TYPE_DIR = 1;
	const AS3_LIBRARY_TYPE_SWC = 3;
	
	const COMPILE_SWC     = "compileSwc";
	const COMPILE_SWF     = "compileSwf";
	const COMPILE_AIR_SWC = "compileAirSwc";
	const COMPILE_AIR     = "compileAir";
	
	public function __construct($compDir = null)
	{
		$this->setCompilerDir($compDir ? $compDir : dirname(__FILE__)."/bin");
		
		InputSafety::getInstance()->registerInputHandler('execSafe',new RegexpSafetyHandler('/^[\w=.\/-\s]+$/'));
		
		InputSafety::setMode(InputSafety::ON_PROBLEM);
	}
	
	public function setCompilerDir($compDir)
	{
		$this->_compilerDir = realpath($compDir);
	}
	
	public function getCOMPC()
	{
		return $this->_compilerDir."/compc";
	}
	
	public function getACOMPC()
	{
		return $this->_compilerDir."/acompc";
	}
	
	public function getMXMLC()
	{
		return $this->_compilerDir."/mxmlc";
	}
	
	
	
	public function setAdditionalCompilerArguments($arguments)
	{
	
		//we don't want to execute arbitrary code, so we need to pick out
		//what items we can use
		$useable = "";
		
		$this->buildArguments($arguments,'/-keep-as3-metadata\s*\+=\s*\w+/i',$useable);
		
		
		$this->_additional_arguments = escapeshellcmd($useable);
	}
	
	private function buildArguments($arguments,$regexp,&$command)
	{
		$matches = array();
		
		preg_match_all($regexp,$arguments,$matches);
		
		$matches = $matches[0];
		
		
		$command .= implode(" ",$matches);
		
	}
	
	
	public function includeLibrary($swcFile)
	{
		
		if(!$this->fileExists($swcFile)) 
			return;
			
		
		$this->_include_libraries[] = "-include-libraries+=".$this->cleanShellCmd($swcFile);
	}
	
	
	public function includeClass($class)
	{
		$this->_include_classes[] = $this->cleanShellCmd($class);
	}
	
	public function addLibrary($swcFile)
	{
		if(!$this->fileExists($swcFile)) 
			return;
			
		
		$this->_library_paths[] = "-library-path+=".$this->cleanShellCmd($swcFile);
	}
	
	
	
	public function hasWarnings()
	{
		return count($this->_warnings) > 0;
	}
	
	
	
	public function warningsToString($delim = "<BR />")
	{
		return implode($delim, $this->dumpWarnings());
	}
	
	public function dumpWarnings()
	{
		$warnings = $this->_warnings;
		$this->_warnings = array();
		
		return $warnings;
	}
	
	public function hasErrors()
	{
		return InputSafety::hasErrors() || count($this->_errors) > 0;
	}
	
	public function dumpErrors()
	{
		$errors = $this->_errors;
		$this->_errors = array();
		return array_merge(InputSafety::dumpErrors(),$errors);
	}
	
	public function errorsToString($delim = "<BR />")
	{
		return implode($delim, $this->dumpErrors());
	}
	
	public function hasProblems()
	{
		return $this->hasWarnings() || $this->hasErrors();
	}
	
	public function dumpProblems()
	{
		return array_merge($this->dumpErrors(), $this->dumpWarnings());
	}
	
	public function problemsToString($delim = "<BR />")
	{
		return implode($delim, $this->dumpProblems());
	}
	
	public function setSourcePath($file)
	{
		$this->_sourcePath = $this->cleanShellCmd(realpath($file));
	}
	
	public function setOutputPath($file)
	{
		$this->_outputPath = realpath($file);
	}
	
	public function setOutputName($name)
	{
		$this->_outputName = $name;
	}
	
	public function setOutput($file)
	{
		$this->setOutputPath(dirname($file));
		$this->setOutputName(basename($file));
	}
	
	public function getOutput($clean = true)
	{
		$path = $this->_outputPath."/".$this->_outputName;
		
		if($clean)
			return $this->cleanShellCmd($path);
			
		return $path;
	}
	
	public function setConfig($config)
	{
		$this->_config = $this->cleanShellCmd(realpath($config));
	}
	
	
	public function setActionscriptPropertiesFile($as3PropsFile)
	{
		$as3PropsFile = realpath($as3PropsFile);
		
		$dir = dirname($as3PropsFile);
		
		if(!$this->fileExists($as3PropsFile))
		{
			return;
		}
		
		
		//get the target main application
		$xml = simplexml_load_string(file_get_contents($as3PropsFile));
		
		foreach($xml->attributes() as $k => $v)
		{
			switch($k)
			{
				case "mainApplicationPath":
				break;
			}
		}
		
		//first find the compiler node that contains the arguments
		$compilerNode = simplexml_find_nodes($xml,"compiler",0);
		
		
		//next, go through the compiler properties and set them accordingly so we can
		//build our command
		foreach($compilerNode->attributes() as $k => $v)
		{
			switch($k)
			{
				
				case "additionalCompilerArguments":
					$this->setAdditionalCompilerArguments($v);
				break;
				case "outputFolderPath":
					$this->setOutputPath($dir."/".$v);
				break;
				case "sourceFolderPath":
					$this->setSourcePath($dir."/".$v);
				break;
				
				case "generateAccessible":
				case "copyDependentFiles":
				case "enableModuleDebug":
				case "htmlExpressInstall":
				case "htmlGenerate":
				case "htmlHistoryManagement":
				case "htmlPlayerVersion":
				case "htmlPlayerVersionCheck":
				case "strict":
				case "useApolloConfig":
				case "verifyDigests":
				case "warn":
				break;
			}
		}
		
		//next find the library paths
		$libraryPathEntries = simplexml_find_nodes($xml,"libraryPathEntry");
		
		
		
		foreach($libraryPathEntries as $libraryPathEntry)
		{
			
			foreach($libraryPathEntry->attributes() as $k => $v)
			{
				switch($k)
				{
					case "kind":
						$kind = $v;
					break;
					case "path":
						$path = $v;
					break;
					case "linkType":
						$linkType = $v;
					break;
					case "useDefaultLinkType":
						$useDefaultLinkType = $v;
					break;
				}
			}
			
			if($path == "")
				continue;
			
			
			switch($kind)
			{
				case self::AS3_LIBRARY_TYPE_DIR:
					$this->addLibrary($dir."/".$path);
				break;
				default:
					$this->includeLibrary($dir."/".$path);
				break;
			}
			
		}
		
		
	}
	
	
	public function setLibPropertiesFile($libsFile)
	{
		if(!$this->fileExists($libsFile))
		{
			return;
		}
		
		
		$xml = simplexml_load_string(file_get_contents($libsFile));
		
		
		$classEntries = simplexml_find_nodes($xml,"classEntry");
		
		
		foreach($classEntries as $classEntry)
		{
			foreach($classEntry->attributes() as $k => $v)
			{
				switch($k)
				{
					case "path":
						$this->includeClass((string)$v);
					break;
				}
			}
		}
		
		
	}
	
	/**
	 */
	public function setArchiveZip($file,$output = null)
	{
		if(!$output)
		{
			$output = $this->_tmpDir = tempnam("/tmp", basename($file));
		}
		
		@mkdir($output,0777,true);
		
		$za = new ZipArchive();
		
		if($za->open($file) !== TRUE)
		{
			$this->_warnings[] = "Unable to open zip file $file";
			return false;
		}
		
		$za->extractTo($output);
		$za->close();
		
		
		
		  	
		$this->setProjectArchiveDir($output);
		
		
		
	}
	
	/**
	 * zips up the project archive
	 */
	
	public static function zipProjectArchiveDir($dir,$zipFile)
	{
		$za = ZipUtil::zipAll($dir,$zipFile);
		
		if(!$za)
		{
			return false;
		}
		
		
		return $za;
	}
	
	
	
	
	public function setProjectArchiveDir($dir)
	{
		$this->setActionscriptPropertiesFile($dir.'/.actionScriptProperties');
		$this->setLibPropertiesFile($dir.'/.flexLibProperties');
		
		
		
	}
	
	
	
	
	
	public function compile($type,$ignoreWarnings = false)
	{
		$command = $this->getCommand($type);	
		
		if($this->hasErrors() || ($this->hasWarnings() && !$ignoreWarnings))
		{
			return false;
		}
		
		$outputFile = $this->getOutput(false);
		
		
		$output = array();
		
		@unlink($outputFile);
		
		//$out = exec('/usr/bin/sudo -u root /usr/bin/whoami 2>&1');
		$out = `bash $command 2>&1 1> /dev/null`;
		
		//exec($command,$output);
		
		
		//$out = implode(" ",$output);
		
		if(!file_exists($outputFile))
		{
			$this->_warnings[] = "Unable to compile: ".$out;
			return false;
		}
		
		
		return true;
	}
	
	public function getCommand($type)
	{
		switch($type)
		{
			case self::COMPILE_SWC:
				return $this->getSWCCommand();
			break;
			case self::COMPILE_AIR_SWC:
				return $this->getAIRSWCCommand();
			break;
			case self::COMPILE_SWF:
				return $this->getSWFCommand();
			break;
		}
	}
	
	
	private function getSWFCommand()
	{
		$args = array();
		$args[] = $this->getMXMLC();
		
		$this->buildGeneralCommand($args);
		
		if($this->_config)
			$args[] = "-load-config ".$this->_config;
		
		
		
		return implode(" ",$args);
	}
	
	private function getSWCCommand()
	{
		$args = array();
		$args[] = $this->getCOMPC();
		
		
		
		$this->buildGeneralCommand($args);
		
		
				
		return implode(" ",$args);
	}
	
	private function getAIRSWCCommand()
	{
		$args = array();
		$args[] = $this->getACOMPC();
		
		
		
		$this->buildGeneralCommand($args);
		
		
				
		return implode(" ",$args);
	}
	
	
	
	private function buildGeneralCommand(&$args)
	{
	
		$args[] = "-locale ".$this->_locale;
			
		if($this->_additional_arguments)
			$args[] = $this->_additional_arguments;
			
			
		$args = array_merge($args,$this->_include_libraries);
		$args = array_merge($args,$this->_library_paths);
		
		if(count($this->_include_classes) > 0)
		{
			$args[] = "-include-classes ".implode(" ",$this->_include_classes);
		}
		
		//if($this->_include_libraries)
		//	$args[] = "-include-libraries ".implode(",",$this->_include_libraries;
		
		
		if(!$this->_outputPath)
			$this->_warnings[] = "The output path has not been set.";
		
		if(!$this->_outputName)
			$this->_warnings[] = "The output name has not been set.";
		
		if(!$this->_sourcePath)
			$this->_warnings[] = "The source path has not been set.";
		
		
		$args[] = "-output ".$this->getOutput();
		
		$args[] = "-source-path ".$this->_sourcePath;
		
	}
	
	
	private function cleanShellCmd($cmd)
	{
		try
		{
			return escapeshellarg(escapeshellcmd(InputSafety::cleanse($cmd,'execSafe')));
		}catch(Exception $e)
		{
			$this->_errors[] = "Invalid shell argument: \"$cmd\"";
			return "";
		}
	}
	
	private function fileExists($file)
	{
		if(!file_exists($file))
		{
			$name = basename($file);
			
			$this->_warnings[] = "The library \"$name\" doesn't exist.";
			return false;
		}
		
		return true;
	}
	
	
	public function __destruct()
	{
		if($this->_tmpDir)
		{
			FileUtils::rmdir_r($this->_tmpDir);
		}
	}
	
	
	
	
}


?>