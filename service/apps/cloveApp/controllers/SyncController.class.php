<?php
Library::import('cloveApp.models.Sync');
Library::import('cloveApp.models.UsedSync');
Library::import('cloveApp.models.Screen');
Library::import('cloveApp.models.Scene');
Library::import('spice.library.utils.HtmlUtil');
Library::import('spice.library.security.InputSafety');
Library::import('recess.framework.forms.ModelForm');

Library::import('spice.library.recess.SpiceController');
Library::import('cloveApp.controllers.CloveController');

/**
 * !RespondsWith Layouts
 * !Prefix sync/
 */
 


//temporary. Use a data delegate for this
define("DATA_DIR",dirname(__FILE__)."/../data/scenes/");
define("SHOW_MAX",dirname(__FILE__)."/../data/scenes/");

define("SYNC_EXT","snc");

class SyncController extends CloveController 
{
	
	
	/** @var Sync */
	protected $sync;
	
	
	/** @var Form */
	protected $_form;
	
	function init()
	{
		$this->sync = new Sync();
		$this->_form = new ModelForm('sync',$this->request->data('sync'),$this->sync);
	}
	
	
	
	/** !Route GET */
	function index() 
	{
		$this->setBasicHTTPAuth();
		

		return $this->ok_success("Success");
	}
	
	/** !Route GET, download/$id
	 */
	
	function downloadSync($id)
	{
		
		$sync = new Sync($id);
		$sync = $sync->select()->first();
		
		
		die(file_get_contents($this->getSyncPath($sync->screen()->user()->id,$sync->scene,$sync->name)));
	}
	
	/** !Route GET, get
	 */
	
	
	function getSync()
	{
		
		//I haven't spent enough time doing my homework with the recess framwork, so I'm playing it safe by validating any input character
		//before using them in the database.
		
		$screen = $this->request->data('screen');
		
		//could be an unregistered user
		if(!$screen)
		{
			$screen = -1;
		}
		
		try
		{
			$scene    = InputSafety::cleanse($this->request->data('scene'),'integer');
			$screen   = InputSafety::cleanse($screen,'integer');
			$show     = $this->request->data('show');
			
			$show     = 1;//$show ? InputSafety::cleanse($show,'integer') : 1;
			
			
			
		
			//use the last sync sent by the user to find newer ones. IF there is a newer sync, the user is likely
			//to either sync, or ignore the current sync. At that point, it would use the sync FOUND to reset the timestamp
			//so the user doesn't get bugged anymore. If the user selects "remind me later", the timestamp won't change.
			$lastSync = InputSafety::cleanse($this->request->data('last_sync'),'integer');
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		if(!$lastSync)
		{
			return $this->ok_error("No Specified sync date.");
		}
		
		
		
		
		$sync = new Sync();
		$sync->scene = $scene;
		
		
		//get the newest sync
		//NOTE: not casting $lastSync to (int) causes a bug since the type is technically a string
		$this->syncSet = $sync->select()->orderBy('id DESC')->notEqual('screen',(int)$screen)->greaterThan('created_at',(int)$lastSync)->limit($show);
		
		

		
		
		//if no new sync is found, then don't pass back the url
		if(!count($this->syncSet))
		{
			return $this->ok_notFound("No new sync found.");
		}
		
		foreach($this->syncSet as $sync)
		{
			try
			{
				$sync->downloadUrl = "http://".$_SERVER['HTTP_HOST'].$this->urlTo("downloadSync",$sync->id);//file_get_contents($this->getSyncDir($sync->screen()->user()->id,$sync->scene).$sync->name);
			}catch(Exception $e)
			{
				$sync->syncData = "";
				//break;
			}
		}
		
		
		
		return $this->ok_success("Success","syncs"); //return sync url
	}
	
	
	
	
	/** !Route POST, 
		!Route POST, new/
		!Route GET, new/
		*/
	
	function newSync()
	{
		$this->setBasicHTTPAuth();
		
		
		
		// if(!isset($_FILES['sync'])) && !$this->request->data('sync'))
			// return $this->ok_notFound("No sync being uploaded.");
			
		
		if(!($sync = $this->setSyncPostInfo($e)))
		{
			return $e;
		}
		
		
		
		
		$sync->user = $user = CurrentUser::getInstance()->getUser()->id;
		
		$screen = new Screen();
		$screen->user = $user;
		$screen->id   = $sync->screen;
		
		
		if(!$screen->exists())
		{
			return $this->ok_notFound("Screen not found.");
		}
		
		$scene = new Scene();
		$scene->user = $user;
		$scene->id   = $sync->scene;
		
		if(!$scene->exists())
		{
			return $this->ok_notFound("Scene not found.");
		}
		
		
		
		
		
		$sceneID = $scene->id;
		$sync->name = $syncName = microtime().".".SYNC_EXT;//$scene->id;
		
		$localSyncPath = $this->getSyncDir($user,$sceneID);
		
		
		
		if(!file_exists($localSyncPath))
			mkdir($localSyncPath,0777,true);
		
		$localSyncPath .= $syncName;
		
		
		
		
		//$downloadUrl = HtmlUtil::toHtmlPath(dirname(__FILE__)."/../../../")."/".$this->application->routingPrefix.$this->getViewsPrefix($this)."show/$user/$sceneID/$syncFile";
		
		
		//$sync->download_url = $downloadUrl;
		
		$sync->insert();
		
		$this->sync = $sync;
		
		if(isset($_FILE['sync']))
		{
			$syncData = $_FILES['sync'];
			$name     = $syncData['name'];
			$tmp      = $syncData['tmp_name'];
			
			$result = move_uploaded_file($tmp,$localSyncPath);
		}
		else
		{
			$result =  file_put_contents($localSyncPath,file_get_contents('php://input'));
		}
		
		
		
		
		if($result)
		{
			return $this->ok_success("Added sync");
		}
		else
		{
			$this->sync->delete();
			return $this->ok_success("Unable to upload sync.");
		}
		
		
		
	}
	
	private function getSyncPath($user,$scene,$syncFile)
	{
		return $this->getSyncDir($user,$scene)."$syncFile";
	}
	
	private function getSyncDir($user,$scene)
	{
		return DATA_DIR."$user/$scene/";
	}
	
	
	
	
	private function setSyncPostInfo(&$e,&$sync = null,&$screen = null, &$scene = null)
	{
		if(!($sync instanceOf Sync))
		{
			$sync = new Sync();
		}
		try
		{
			$sync->scene    = $scene = $scene  ? $scene  : InputSafety::cleanse($this->request->data('scene'),'integer',"invalid scene");
			$sync->screen   = $screen = $screen ? $screen : InputSafety::cleanse($this->request->data('screen'),'integer',"invalid screen");
			
				
		}catch(Exception $e)
		{
			$e = $this->ok_error($e->getMessage());
			return false;
		}
		
		return $sync;
	}
	
	
	
	
	
}
?>