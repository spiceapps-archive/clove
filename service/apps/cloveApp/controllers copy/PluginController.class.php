<?php
Library::import('cloveApp.models.Plugin');
Library::import('cloveApp.helpers.PluginUtil');
Library::import('spice.library.utils.ZipFile');
Library::import('cloveApp.models.CloveUser');
Library::import('cloveApp.models.PluginTag');
Library::import('cloveApp.models.PluginVersion');
Library::import('spice.library.security.InputSafety');
Library::import('spice.library.asCompiler.AS3Compiler');
Library::import('spice.library.utils.FileUtils');
Library::import('recess.framework.forms.ModelForm');

Library::import('spice.library.recess.SpiceController');
Library::import('cloveApp.controllers.CloveController');

/**
 * !RespondsWith Layouts
 * !Prefix managePlugins/
 */
 

//temporary. Use a data delegate for this

class PluginController extends CloveController 
{	
	
	
	/** @var Plugin */
	protected $plugin;

	public function init()
	{	
		$this->plugin = new Plugin();
		$this->_form = new ModelForm('plugin',$this->request->data('plugin'),$this->plugin);
		
		
		InputSafety::setMode(InputSafety::ON_DUMP);
	}
	/** !Route GET */
	public function index()
	{
		if($message = $this->notLoggedIn())	return $message;
		
		$user = new CloveUser($this->current_user->id);
		
		
		$this->pluginSet = $user->plugins();
	
		return $this->ok("showPlugins");
	}
	
	/** !Route GET, new
	  */
	
	public function newPlugin()
	{	
		if($message = $this->notLoggedIn())	return $message;
			
		$this->_form->to(Methods::POST, $this->urlTo('setPlugin'));
		
		return $this->ok("updateInfo");
	}
	
	/** !Route POST, new
	  */
	
	public function setPlugin($id = null)
	{
		if($message = $this->notLoggedIn())	return $message;
		
		
		$this->plugin->name        = $name        = InputSafety::cleanse($this->request->data('name'),new RegexpSafetyHandler('/(\w+\s)+/'),'Name is invalid.');
		$this->plugin->factory     = $factory     = InputSafety::cleanse($this->request->data('factory'),new RegexpSafetyHandler('/(\w+\.)+\w+/'),'The factory specified is invalid. Use this format: com.yoursite.plugins.pluginName.pluginFactory');
		$this->plugin->description = $description = InputSafety::cleanse($this->request->data('description'),"*");
		
		
		$this->_form->to(Methods::POST, $this->urlTo('setPlugin'));
		
		if($errors = $this->getInputErrors("updateInfo"))
			return $errors;
		
		if($id)
		{
			if(!(($plugin = $this->verifyPluginOwner($id)) instanceOf Plugin))
			{
				return $plugin;
			}
			
			$this->plugin->id = $id;
			
			$this->plugin->update();
			
			$this->_form->to(Methods::POST, $this->urlTo('setPluginUpdate',$id));
			
			return $this->finished("Successfully updated plugin.",0,'setPluginUpdate');
		}
		
		
		
		$plugin = new Plugin();
		$plugin->name = $name;
		
		$errors = array();
		
		if($plugin->exists())
		{
			$errors[] = "A plugin with that name already exists.";
		}
		
		$plugin = new Plugin();
		$plugin->factory = $factory;
		
		if($plugin->exists())
		{
			$errors[] = "A plugin with that factory class already exists.";
		}
		
		if(count($errors))
		{
			return $this->error(implode("<br />",$errors),"updateInfo");
		}
		
		$plugin = new Plugin();
		$plugin->factory     = $factory;
		$plugin->name        = $name;
		$plugin->description = $description;
		$plugin->user        = $this->current_user->id;
		
		
		//set the UID. this is done once, even if the user changes the factory class
		$plugin->uid = substr(base64_encode($name.":".$factory.":".time()),0,255);
		
		$plugin->insert();
		
		
		//print_r($_FILES);
		
		return $this->finished("Successfully created plugin.",0,"updateVersion");
	}
	
	
	/** !Route GET, edit/$id
	 */

	public function editPlugin($id = '')
	{
		
		if($message = $this->notLoggedIn())	return $message;
		
		$id = InputSafety::cleanse($id,'integer');
		
		if($errors = $this->getInputErrors())
			return $errors;
			
		$this->plugin = new Plugin($id);
		$this->plugin->exists();//selects the data
		
		
		$this->_form->to(Methods::POST, $this->urlTo('setPluginUpdate',$id));
			
		return $this->ok("updateInfo");
	}
	
	/** !Route POST, edit/$id
	 */
	public function setPluginUpdate($id='')
	{
		$this->setPlugin($id);
		$this->_form->to(Methods::POST, $this->urlTo('setPluginUpdate',$id));
		return $this->ok("updateInfo");
	}
	
	
	/** !Route GET, update/$id
	  */
	
	public function updatePlugin($id='')
	{
		
		if(!(($plugin = $this->verifyPluginOwner($id)) instanceOf Plugin))
		{
			return $plugin;
		}
		$this->plugin = $plugin;
		
		$this->currentVersion = $plugin->pluginVersions()->first();
		
		$msg = "This is your first update.";
		
		if($this->currentVersion)
		{
			$msg = "Current Version: ".$this->currentVersion->version;
		}
		
		$this->_form->to(Methods::POST, $this->urlTo('addPluginUpdate',$id));
		
		return $this->finished($msg,0,'updateVersion');
	}
	
	/** !Route POST, update/$id
	 */

	public function addPluginUpdate($id='')
	{
		if(!(($plugin = $this->verifyPluginOwner($id)) instanceOf Plugin))
		{
			return $plugin;
		}
		$plugin->exists();
		
		
		
		$this->_form->to(Methods::POST, $this->urlTo('addPluginUpdate',$id));
			
			
		$version = InputSafety::cleanse($this->request->data('version'),'mysqlSafeChars','Invalid version.');
		$update_info = InputSafety::cleanse($this->request->data('update_info'),'mysqlSafeChars','Invalid update description.');
		
		
		
		if($_FILES["pluginFile"]["error"])
			return $this->error("Please provide a Flex Archive file.","updateVersion");
		
		
		$pluginFile = $_FILES["pluginFile"];
		
		$fileType = InputSafety::cleanse($pluginFile["name"],new RegexpSafetyHandler('/\.(zip)$/'),'Invalid plugin.');
		
		if($errors = $this->getInputErrors("updateVersion"))
		{
			return $errors;
		}
		
		
		$this->currentVersion = $cv = new PluginVersion();
		$cv->plugin = $id;
		
		$cv->version = $version;
		
		
		
		
		
		
		if($cv->exists())
		{
			return $this->error("That version already exists.","updateVersion");
		}
		
		
		$cv->update_info = $update_info;
		
		$tmpFile = $pluginFile["tmp_name"];
		$cv->dir = base64_encode($version);
		
		
		if($errors = $this->compileAS3Archive($tmpFile,$this->currentVersion))
		{
			return $errors;
		}
		
		
		$cv->insert();
		
		return $this->finished("Successfully updated plugin. We'll let you know when it's been approved.",0,"updateVersion");
	}
	
	private function compileAS3Archive($file,$version)
	{
		
		
		$pluginDir = PluginUtil::getPluginSourcePath($version);
		
		//delete 
		FileUtils::rmdir_r($pluginDir);
		mkdir($pluginDir,0777,true);
				
		
		
		//NOTE: we ready the command for the plugin archive only to validate
		//to make sure there are no problems with it. We won't execute since
		//we don't want to allow the user to arbitraily execute malicious code.
		//The AS3 compiler is only used with the administrator approves of the plugin.
		$compiler = new AS3Compiler();
		$compiler->setOutputName("output.swc");
		$compiler->setArchiveZip($file,$pluginDir);
		$command = $compiler->getCommand(AS3Compiler::COMPILE_AIR_SWC,true);
		

		PluginUtil::cleanProjectArchive($version);
		
		if($compiler->hasProblems())
		{
			return $this->error($compiler->problemsToString()."<BR /><BR />Shell: <BR />$command","updateVersion");
		}
		
		return false;
		
	}
	
	private function notLoggedIn()
	{
		if(!($this->current_user instanceOf User)) return $this->error("You must <a href=\"".$this->urlTo("UserController::login")."\">log in</a> to see this page.");
		
		return false;
		
	}
	
	
	private function verifyPluginOwner($id)
	{
		if($message = $this->notLoggedIn())
			return $message;
			
		$plugin = new Plugin($id);
		
		if(!$plugin->equal('user',$this->current_user->id)->first())
		{
			return $this->error("This plugin doesn't belong to you.");
		}
		
		return $plugin;
	}
}
?>