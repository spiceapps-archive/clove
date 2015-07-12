<?php
Library::import('cloveApp.models.Scene');
Library::import('cloveApp.models.SceneSubscription');
Library::import('recess.framework.forms.ModelForm');

Library::import('spice.library.recess.SpiceController');
Library::import('cloveApp.controllers.CloveController');

/**
 * !RespondsWith Layouts
 * !Prefix sceneSubscription/
 */
 
class SceneSubscriptionController extends CloveController 
{
	
	/** @var SceneSubscription */
	protected $sceneSubscription;
	
	function init()
	{
		$this->sceneSubscription = new SceneSubscription();
	}
	
	
	
	
	/** !Route GET
	 */
	function index() 
	{

		return $this->ok_success("Success");
	}
	
	/** !Route GET, get
	  */
	
	function getSubscription()
	{
		try
		{
			$sceneID = InputSafety::cleanse($this->request->data('scene'),'integer');
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		$sub = new SceneSubscription();
		$sub->scene = $sceneID;
		$this->sceneSubscriptionSet = $sub->select();
		
		return $this->ok_success('Success','subscriptions');
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
			$subscribe_to = InputSafety::cleanse($this->request->data('subscribe_to','integer'));
			$scene = InputSafety::cleanse($this->request->data('scene','int'));
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		
		if($subscribe_to == $scene)
		{
			return $this->ok_error("You cannot subscribe to your own scene.");
		}
		
		$sc = new Scene($scene);
		$sc->user = CurrentUser::getInstance()->getUser()->id;
		
		
		
		if(!$sc->exists())
		{
			return $this->ok_notFound("You don't have any scene with that ID.");
		}
		
		
		$subScene = new Scene($subscribe_to);
		
		if(!$subScene->exists())
		{
			return $this->ok_notFound("The scene you're subscribing to doesn't exist.");
		}
		
		
		
		$ss = new SceneSubscription();
		$ss->scene = $scene;
		$ss->subscribed_to = $subscribe_to;
		
		
		if($ss->exists())
		{
			return $this->ok_error("The subscription already exists between these two scenes.");
		}
		
		$ss->insert();
		
		
		
		return $this->ok_success("Successfully created Scene Subscription.");
	}
	
	
	/**	!Route GET, unsubscribe
		*/
		
	function unsubscribe()
	{
		
		$this->setBasicHTTPAuth();
			
		try
		{
			$subscriptionId = InputSafety::cleanse($this->request->data('subscription_id'),'integer');
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		
		$sub = new SceneSubscription($subscriptionId);
		
		$sub = $sub->select()->first();
		
		if(!$sub)
		{
			return  $this->ok_notFound("No such subscription exists.");
		}
		
		$scene = $sub->scene();
		
		
		if($scene->exists() && $scene->user != CurrentUser::getInstance()->getUser()->id)
		{
			return $this->ok_unauthorized("This subscription doesn't belong to you.");
		}
		
		
		try
		{
			if($sub->delete())
			{
			
				return $this->ok_success("Success");
			}
		}catch(Exception $e)
		{
			return $this->ok_error($e->getMessage());
		}
		
		return $this->ok_error("Unknown Error.");
	}

}
?>