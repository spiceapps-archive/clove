<?php


Library::import('cloveApp.models.PluginVersion');
Library::import('spice.library.utils.ZipUtil');
Library::import('spice.library.utils.FileUtils');
Library::import('cloveApp.helpers.as3VO.CompiledPlugin');
Library::import('cloveApp.helpers.as3VO.CompiledPluginInfo');
Library::import('cloveApp.helpers.as3VO.CompiledPluginAsset');

require_once dirname(__FILE__).'/Config.class.php';

class PluginUtil
{

	public static function getPluginSourcePath(PluginVersion $version)
	{
		
		//die(print_r($version->plugin(),true));
		//$plug = new Plugin($version->plugin);
		//$plug->exists();
		
		$uid = $version->plugin; /*$version->plugin()->uid;*/ /*$plug->uid;*/
	
		return dirname(__FILE__)."/../data/plugins/".$uid."/".$version->dir."/";
	}
	
	public static function getPluginLibsPath(PluginVersion $version)
	{
		return self::getPluginSourcePath($version)."libs/";
	}
	
	
	/**
	 * cleans the project archive of any swc's stored on the server such as SpiceKit.swc, CloveSDK.swc. This is to remove
	 * the posibility of having an older version of the swc's being compiled
	 */
	
	public static function cleanProjectArchive(PluginVersion $version)
	{
		$path = self::getPluginLibsPath($version);
		
		$files = scandir($path);
		$libs  = scandir(Config::getSetting(Config::PLUGIN_LIBS_PATH));
		
		foreach($files as $file)
		{
			if($file == "." || $file == "..") continue;
			
			foreach($libs as $lib)
			{
				//if we have any pre-existing swc's remove them so there's no conflict
				//when compiling. We want to use the same libraries for ALL plugins.
				if($file == $lib)
				{
					$f2 = realpath($path."/".$file);
					
					unlink($f2);
					break;
				}
			}
			
		}
	}
	
	/**
	 * sets up the compiler with additional arguments needed such as SpiceKit, and CloveSDK
	 */
	 
	public static function setupCompiler($compiler,$version)
	{
		$pluginPath = Config::getSetting(Config::PLUGIN_LIBS_PATH);
		
		$compiler->addLibrary($pluginPath);
		
		/*$libs  = scandir($pluginPath);
		
		foreach($libs as $lib)
		{
			if($lib == "." || $lib == "..") continue;
			
			$compiler->addLibrary(realpath($pluginPath."/".$lib));
		}*/
		
		$compiler->setOutput(self::getPluginSwcPath($version));
	}
	
	
	public static function getPluginSwcPath($version)
	{
		return self::getPluginSourcePath($version)."/bin/output.swc";
	}
	
	public static function getClovePluginPath($version)
	{
		$name = $version->plugin()->name;
		
		return self::getPluginSourcePath($version)."/bin/".$name.".cplugin";
	}
	
	/**
	 * compiles the plugin so it's ready to be used by Clove
	 */
	
	public static function compile($version,&$compiler)
	{
		$compiler = new AS3Compiler();
		self::setupCompiler($compiler,$version);
		$compiler->setProjectArchiveDir(PluginUtil::getPluginSourcePath($version));
		
		
		$success = $compiler->compile(AS3Compiler::COMPILE_AIR_SWC);
		
		if(!$success)
			return false;
			
		//once compiled, unzip the SWC, and leave ONLY the library.swf file
		//$zip = new ZipArchive();
		
		$zip = new ZipFile();
		
		//get the output dir
		$out = $compiler->getOutput(false);
		
		//open the swc
		$zip->open($out);
		
		//get the dir name of the swc. the SWF still lives here
		$outdir = dirname($out);
		
		//unzip
		$zip->extractTo($outdir);
		//$zip->close();
		
		
		$plugin = $version->plugin();
		
		//the plugin info to be included in the CPlugin
		$info = new CompiledPluginInfo($plugin->name,
									   $plugin->description,
									   $plugin->factory,
									   $plugin->uid,
									   date_create("@".$plugin->created_at),
									   $version->version,
									   $version->sdk_version,
									   $version->update_info,
									   date_create("@".$version->created_at));
		
		
		$files = scandir($outdir);
		
		//the assets to compiled into the cplugin
		$pluginAssets = array();
		
		//iterate through the output and delete all files EXCEPT library.swf
		foreach($files as $file)
		{
			
			if($file == "." || $file == "..") continue;
			
			$path = $outdir."/".$file;
			
			//for now, only add the swf into the compiled plugin
			if($file == "library.swf")
			{
				$pluginAssets[] = new CompiledPluginAsset($file,true,file_get_contents($path));
				
				//we want to delete the swf actually...
				//continue;
			}
			
			//remove any other plugin info to save room on the server
			if(is_dir($path))
				FileUtils::rmdir_r($path);
			else
				unlink($path);
		}
		
		
		
		
		$voCompiledPlugin = new CompiledPlugin($info,$pluginAssets);
		
		
		require_once "Zend/Amf/Value/ByteArray.php" ;
		require_once "Zend/Amf/Parse/OutputStream.php" ;
		require_once "Zend/Amf/Parse/Amf3/Serializer.php" ;
		
		
		
		//$server->setClass( "CompiledPluginInfo" );
		
		// Create an instance of an AMF Output Stream
		$out = new Zend_Amf_Parse_OutputStream();
		// We will serialize our content into AMF3 for this example
		// You could alternatively serialize it as AMF0 for legacy
		// Flash applications.
		$s = new Zend_Amf_Parse_Amf3_Serializer($out);
		$s->writeObject($voCompiledPlugin);
		
		//write the plugin
		file_put_contents(self::getClovePluginPath($version),"\n".$out->getStream());
		

		return true;
		
	}
	
	
	/**
	 * zips up, and prompts for a download of the plugin with all of the required files
	 */
	
	public static function download($version)
	{

		$zipName = str_replace(".", "_",urlencode($version->plugin()->name."-".$version->version));

		$tmpFile = tempnam("/tmp",$zipName).".zip";
		
		$zip = AS3Compiler::zipProjectArchiveDir(self::getPluginSourcePath($version),$tmpFile);
		

		// get the filename of this php file without extension.
		// that is also the directory to zip and the name of the
		// zip file to deliver
		if(!$zip)
			die("unable to download plugin");
		
		$pluginPath = Config::getSetting(Config::PLUGIN_LIBS_PATH);
		
		$libs  = scandir($pluginPath);
		
		//add the libraries to the zip file
		foreach($libs as $lib)
		{
			if($lib == "." || $lib == "..") continue;
			
			$zip->addFile($pluginPath."/".$lib,"libs/$lib");
		}
		
		$zip->zipUp();
		
		
		
		
		//die($tmpFile);
		// we deliver a zip file
		header("Content-Type: archive/zip");


		// filename for the browser to save the zip file
		header("Content-disposition: attachment; filename=".$zipName.".zip");


		// get a tmp name for the .zip
		//$tmp_zip = tempnam ("tmp", "tempname") . ".zip";
		
		
		//$zip->close();
		
		echo file_get_contents($tmpFile);
		
		@unlink($tmpFile);
		
		//die();
	}
}


?>