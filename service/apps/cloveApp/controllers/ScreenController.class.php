<?php
Library::import('cloveApp.models.Screen');
Library::import('recess.framework.forms.ModelForm');
Library::import('spice.library.security.InputSafety');

Library::import('spice.library.recess.SpiceController');
Library::import('cloveApp.controllers.CloveController');

/**
 * !RespondsWith Layouts
 * !Prefix screen/
 */
 
class ScreenController extends CloveController 
{
	
	/** @var Screen */
	protected $screen;
	
	
	/** @var Form */
	protected $_form;
	
	function init()
	{
		$this->screen = new Screen();
		
		
		$this->_form  = new ModelForm('screens', $this->request->data('screen'),$this->screen);
	}
	
	
	/** !Route GET */
	function index() 
	{
		$this->setBasicHTTPAuth();
		
		$this->setScreenUser();
		
		$this->screenSet = $this->screen->all();
		
		return $this->ok_success("Success","screens");
	}
	
	
	
	/** !Route POST
	 	!Route GET, new
		!Route GET, register 
		*/
	
	function insert()
	{
		
		
		$this->setBasicHTTPAuth();
		
		
		$this->setScreenUser();
		
		$screen = new Screen();
		$screen->user = $this->screen->user;
		try
		{
			$screen->type = InputSafety::cleanse($this->screen->type);
			
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		$screen->insert();
		
		
		//refresh the new screen so we get the info
		$screen = $screen->select()->first();
		
		$this->screenSet = array($screen);
		
		
		
		return $this->ok_success("Successfully created screen.","screens");
	}
	
	/** !Route GET, remove
	 */
	
	
	function removeScreen()
	{
		$this->setBasicHTTPAuth();
		
		
		//$ids = explode(",",$this->screen->id);
		
		
		if($this->screen->exists())
		{
			$this->screen->delete();
			
			return $this->ok_success("Success");
		}
		
		return $this->ok_notFound("Scene doesn't exist");
		
		
	}
	
	
	
	
	private function setScreenUser()
	{
			$this->screen->user = CurrentUser::getInstance()->getUser()->id;
	}
	
}
?>