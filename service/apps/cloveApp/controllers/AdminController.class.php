<?php
Library::import('cloveApp.models.Sync');
Library::import('spice.library.utils.ZipUtil');
Library::import('cloveApp.models.Plugin');
Library::import('cloveApp.helpers.PluginUtil');
Library::import('cloveApp.helpers.AccountPrivs');
Library::import('spice.library.security.InputSafety');
Library::import('recess.framework.forms.ModelForm');

Library::import('spice.library.recess.SpiceController');
Library::import('spice.library.asCompiler.AS3Compiler');
Library::import('cloveApp.controllers.CloveController');

/**
 * !RespondsWith Layouts
 * !Prefix admin/
 */



//$as->compile(AS3Compiler::COMPILE_AIR_SWC);


define("ADMIN_MAX_SHOW_USER",50);
define("DEFAULT_SHOW_PAGE_NUM",30);
 
class AdminController extends CloveController 
{
	
	
	/** @var Sync */
	protected $sync;
	
	
	/** @var Form */
	protected $_form;
	
	function init()
	{
		$this->sync = new Sync();
		$this->_form = new ModelForm('user',$this->request->data('user'),$this->sync);
		InputSafety::setMode(InputSafety::ON_DUMP);
	}
	
	/** !Route GET
	  */
	
	function index()
	{
		if($error = $this->notAllowed())
			return $error;
		
		return $this->ok('index');
	}
	
	/** !Route GET, users
	  */
	
	function showUsers()
	{
		if($error = $this->notAllowed())
			return $error;
		
		$page   = $this->request->data('page');
		$show   = $this->request->data('show');
		$filter = $this->request->data('filter');
		$filter = $filter == '' ? null : $filter;
		
		
		
		$this->currentPage = $page   = $page   ? InputSafety::cleanse($page,'integer','Invalid page number.')      : 0;
		$this->showPages   = $show   = $show   ? InputSafety::cleanse($show,'integer','Invalid show page number.') : DEFAULT_SHOW_PAGE_NUM;
		$this->filter      = $filter = $filter ? InputSafety::cleanse($filter,'mysqlSafeChars','Invalid filter.')          : $filter;
		
		$show = $show > ADMIN_MAX_SHOW_USER ? ADMIN_MAX_SHOW_USER : $show;
		
		$this->numUsers = count((Make::a("User")->select()));
		$this->numPages = $this->numUsers / $show;
		$this->userSet = array();
		
		if($errors = $this->getInputErrors('showUsers'))
		{
			return $errors;
		}
		
	//	echo $page*$show;
	//	die();
	
		
		$offset = $page*$show;
		
		
		$this->_form->to(Methods::GET, $this->urlTo('showUsers'));
		
		$query = $this->getSelectQuery();
		
		if($filter)
		{
			$query = $query->like('email',"%$filter%");
		}
		
		$this->userSet = $query->limit("$offset,$show");
		
		
		return $this->ok('showUsers');
	}
	
	/**
	 * !Route GET, users/edit/$id
	 */
	
	
	public function editUser($id)
	{
		if($error = $this->notAllowed())
			return $error;
			
		
			
		$this->user = new User($id);
		
		if(!$this->user->exists())
		{
			return $this->redirect($this->urlTo("AdminController::showUsers"));
		}
		
		$this->_form->to(Methods::POST, $this->urlTo('updateUser',$id));
		
			
		return $this->ok('editUser');
	}
	
	
	/**
	 * !Route POST, users/edit/$id
	 */

	public function updateUser($id)
	{
		if($error = $this->notAllowed())
			return $error;
			
		$this->_form->to(Methods::POST, $this->urlTo('updateUser',$id));
		$admin_privs = $this->request->data('admin_privs') ? 8 : 0;
		
		
		$this->user = $user= new User($id);
		
		$user->permissions = $admin_privs; //& $plugin_privs & $email_privs;
		$user->update();
		
		$user->exists();
		
		return $this->finished("Updated user: ".$user->email,0,'editUser');
	}
	
	
	/**
	 * !Route GET, plugins/queue
	 */
	
	public function showPluginsInQueue()
	{
		if($error = $this->notAllowed())
			return $error;
		
		$this->pluginSet = Make::a("PluginVersion")->select()->equal("approved",0);
		
		return $this->ok('showPluginsInQueue');
	}
	
	
	/**
	 * !Route GET, plugins/approve/$id
	 */
	
	public function approvePlugin($id)
	{
		if($error = $this->notAllowed())
			return $error;
			
		$plugin = $this->version = new PluginVersion($id);
		
		if(!$plugin->exists())
		{
			return $this->error("That plugin doesn't exist","showPluginsInQueue");
		}
		
		if(!PluginUtil::compile($plugin,$compiler))
		{
			return $this->error("Unable to compile swc: ".$compiler->problemsToString(),"pluginInfo");
		}
		
		$plugin->approved = 1;
		$plugin->update();
		
		$this->statusMessage = "Successfully approved plugin.";
		
		//mail the user of the update
		
	
		return $this->ok('pluginInfo');
		return $this->showPluginsInQueue();
	}
	
	/**
	 * !Route GET, plugins/info/$id
	 */
	
	public function showPluginInfo($id)
	{
		if($error = $this->notAllowed())
			return $error;
		
		$plugin = $this->version = new PluginVersion($id);
		
		
		if(!$plugin->exists())
		{
			return $this->error("That plugin doesn't exist","showPluginsInQueue");
		}
		
		
	 	$this->setCompiler($plugin,$compiler);
		
		if($compiler->hasProblems())
		{
			return $this->error(PluginUtil::getPluginSourcePath($plugin),"pluginInfo");
		}
		
			
		return $this->finished("<font color=\"red\">Examine ALL project properties before approving. Failing to so may allow a hacker to inject commands.</font>",0,'pluginInfo');
	}
	
	/**
	  * !Route GET, plugins/download/$id
	  */

	public function downloadPluginSource($id)
	{
		// this script zips up a directory (on the fly) and delivers it
		// C.Kaiser 2002
		// No Copyright, free to use.
		$version = new PluginVersion($id);
		$version->exists();

		PluginUtil::download($version);
		
	}
	
	
	private function compilePlugin($version,&$compiler)
	{
		$this->setCompiler($version,$compiler);
	}
	
	private function setCompiler($version,&$compiler)
	{
		$compiler = new AS3Compiler();
		$compiler->setProjectArchiveDir(PluginUtil::getPluginSourcePath($version));
		PluginUtil::setupCompiler($compiler,$version);
		//$compiler->replaceLibrary("libs/CloveSDK.swc","hello world");
		
	}
	
	
	private function getSelectQuery()
	{
		return Make::a("User")->select()->orderBy('id DESC');
	}
	
	
	private function notAllowed()
	{
		if(!($this->current_user instanceOf User) || !($this->current_user->permissions & AccountPrivs::ADMIN)) return $this->error("You're not authorized to view this page.","index");
		
		
		return false;
	}
	
	
	
	
}
?>