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
 * !Prefix plugins/
 */
 

//temporary. Use a data delegate for this

class PluginInfoController extends CloveController 
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
		
	}
	
	
	
	
	/** !Route GET, updates/ */
	
	public function getUpdates()
	{
		
		//format: [{"uid":"VHdpdHRlciBQbHVnaW46Y29tLnNwaWNlLmNsb3ZlLnBsdWdpbi50d2l0dGVyLkNsb3ZlVHdpdHRlclBsdWdpbjoxMjcyMDYyODk1","currentVersion":"1.0"}]
		$plugins = json_decode(stripslashes($this->request->data('plugins')));
		
		
		$updates = array();
		
		foreach($plugins as $pluginInfo)
		{
			$plugin = new Plugin();
			
			foreach($pluginInfo as $property => $value)
			{
				if($property == "currentVersion") continue;
				
				$plugin->$property = InputSafety::cleanse($value,"*");
			}
			
			if($plugin->exists())
			{
				
				$latestVersion = $plugin->pluginVersions()->equal('approved',1)->orderBy("id DESC")->first();
				
				//echo $latestVersion->version." ".$plugin->name."<BR />";
				
				if($latestVersion->version != $pluginInfo->currentVersion)
				{
					$updates[] = $latestVersion;
				}
			}
		}
		
	
		$this->updateSet = $updates;
		
		
		return $this->success("Success","updates");
	}
	
	/** !Route GET, download/$id */
	
	public function downloadUpdate($id)
	{
		$version = new PluginVersion($id);
		if(!$version->exists())
		{
			return $this->error("plugin doesn't exists");
		}
		
		$this->pluginData = file_get_contents(PluginUtil::getClovePluginPath($version));
		
		return $this->ok('downloadPlugin');
	}
	
	
	/** !Route GET, available/ */
	
	public function showAvailable()
	{
		$page   = $this->request->data('page');
		$show   = $this->request->data('show');
		$filter = $this->request->data('filter');
		$filter = $filter == '' ? null : $filter;
		
		
		
		$this->currentPage = $page   = $page   ? InputSafety::cleanse($page,'integer','Invalid page number.')      : 0;
		$this->showPages   = $show   = $show   ? InputSafety::cleanse($show,'integer','Invalid show page number.') : 30;
		$this->filter      = $filter = $filter ? InputSafety::cleanse($filter,'mysqlSafeChars','Invalid filter.')          : $filter;
		
		//yuck. magic numbers >.>. Change this in the future so it's a config item
		$show = $show > 60 ? 30 : $show;
		
		$this->numPlugins = count((Make::a("Plugin")->select()));
		$this->numPages = $this->numPlugins / $show;
		$this->userSet = array();

		if($errors = $this->getInputErrors('showUsers'))
		{
			return $errors;
		}
		
		$offset = $page*$show;
		
		
		//$this->_form->to(Methods::GET, $this->urlTo('showUsers'));
		
		$query = Make::a("Plugin")->select()->orderBy('id DESC');
		
		if($filter)
		{
			$query = $query->like('email',"%$filter%");
		}
		
		$this->userSet = $query->limit("$offset,$show");
		
		
		return $this->ok('showUsers');
	}
	
}
?>