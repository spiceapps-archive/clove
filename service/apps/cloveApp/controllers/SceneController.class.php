<?php
Library::import('cloveApp.models.Scene');
Library::import('recess.framework.forms.ModelForm');

Library::import('spice.library.recess.SpiceController');
Library::import('cloveApp.controllers.CloveController');

/**
 * !RespondsWith Layouts
 * !Prefix scene/
 */
 
class SceneController extends CloveController 
{
	
	/** @var Scene */
	protected $scene;
	
	function init()
	{
		$this->scene = new Scene();
		$this->_form = new ModelForm('scene',$this->request->data('scene'),$this->scene);
	}
	
	
	
	
	/** !Route GET
		!Route GET, get/all
	 */
	function index() 
	{
		
		$user_id = $this->request->data('user_id');
		$email = $this->request->data('email');
		
		
		$user = new User();
		
		try
		{
			if($email)
			{
				$user->email = InputSafety::cleanse($email,'email');
			}
			else
			if($user_id)
			{
				$user->id = InputSafety::cleanse($user_id,'integer');
			}
			else
			{
				return $this->ok_success("Success","scenes");
			}
			
			if(!$user->exists())
			{
				return $this->ok_notFound("User doesn't exist.");
			}
			
			$scene = new Scene();
			$scene->user = $user->id;
			$this->sceneSet = $scene->select();
			
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		
		
		
		

		return $this->ok_success("Success","scenes");
	}
	
	
	
	/** !Route POST
		!Route POST, new
		!Route GET, new 
		*/
	
	function insert()
	{
		$this->setBasicHTTPAuth();
		
		
		try
		{
			$name = InputSafety::cleanse($this->request->data('name'),'*',"The scene name is invalid.");
			$desc = InputSafety::cleanse($this->request->data('description'),'*','The scene description is invalid');
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		
		
		$sc = new Scene();
		$sc->name = $name;
		$sc->user = CurrentUser::getInstance()->getUser()->id;
		
		
		if($sc->exists())
		{
			return $this->ok_alreadyExists("You already have a scene with that name.");
		}
		
		$sc->description = $desc;
		
		$sc->insert();
		
		$this->scene->id = $sc->id;
		$this->scene = $sc->select()->first();
		
		$this->sceneSet = $this->scene->select();
		
		
		return $this->ok_success("Successfully created Scene.","scenes");
	}
	
	
	/**	!Route POST, delete
		!Route GET, delete 
		*/
		
	function remove()
	{
		
		$this->setBasicHTTPAuth();
			
		try
		{
			$sceneID = InputSafety::cleanse($this->request->data('scene'),'integer');
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		
		$scene = new Scene($sceneID);
		$scene->user = CurrentUser::getInstance()->getUser()->id;
		
		
		try
		{
			$scene->syncs()->delete();
		
			if($scene->delete())
			{
			
				return $this->ok_success("Success");
			}
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		return $this->ok_notFound("No such scene exists.");
	}

}
?>