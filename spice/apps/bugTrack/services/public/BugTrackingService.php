<?php

	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	
	require_once dirname(__FILE__).'/BugPriorityService.php';
	
	
	class BugTrackingService extends Service
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_userService;
		private $_projectService;
		private $_bugPriorityService;
		private $_project;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		function __construct()
		{
			parent::__construct();
			
			
			$this->_userService        = new BugTrackingUserService();
			$this->_projectService     = new ProjectService();
			$this->_bugPriorityService = new BugPriorityService();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        

        /**
		 */
		
		public function report($description,$priority,$project = null,$tags = null)
		{
		
			
			//if theproject is NOT present, then go to the set project in the class
			$project = $project ? $project : $this->_project;
			
			
			$projectInfo = $this->_projectService->getProjectById($project);
			
			$company = $this->_projectService->getProjectCompanyId($project);
			
			if(!$projectInfo)
			{
				throw new Exception("No project with the id of ".$project." exists");
			}
			
			//if the 
			
			$priorityName = $this->_bugPriorityService->getPriorityName($priority,$company);
			
			if(!$priorityName)
			{
				throw new Exception("The priority code ".$priority." is not defined in the database.");
			}
		
			$query = "INSERT INTO `bugs` (`project`,`description`,`priority`,`tags`,`owner`) VALUES(:0,:1,:2,:3,:4)";
			
			//assign the owner as the logged in user if there IS a logged in user
			$owner = $this->_userService->userId();
			
			//if the user is NOT logged in, then give an anyonymous flag
			$owner = $owner ? $owner : -1;
			
			$newTags = $tags;
			
			//serialize the tags so they're SQL friendly
			if(is_array($tags))
			{
				$newTags = json_encode($newTags);
			}
			
			//next email the developers that are in charge ofthis particular bug
			$this->emailDeveloperBug($priority,$priorityName,$projectInfo["name"],$company,$description);
			
			//insert the bug into the database so it can easily be tracked
			$this->executeQuery($query,array($project,$description,$priority,$newTags,$owner));
			
			return true;
		}
		
		/**
		 */
		
		public function getBugs($project,$priority = -1)
		{
			$query = "SELECT * FROM `bugs` WHERE `project` = :0";
			
			//if the priority is greater then -1 (All errors), then drill down to the selected
			//bug
			if($priority > -1)
			{
				$query .= " AND `priority` = :1";	
			}
			
			
			$result = $this->getResult($query,array($project,$priority))->toAssocArray();
			
			return $result;
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function emailDeveloperBug($code,$priorityName,$projectName,$company,$message)
		{
		
		
			//fetch the list of users that should be notified about this error
			$handlers = $this->_bugPriorityService->getBugHandler($code,$company);
			
			
			$handlers2 = array();
			
			//construct the get query so we have the persons email
			foreach($handlers as $handler)
			{
				$handlers2[] = "`id` = '$handler'";
			}
			
			//construct the select query
			$query = "SELECT `email` FROM `users` WHERE ".implode(" OR ",$handlers2);
			
			
			$emails = array();
			
			$result =  $this->getResult($query);
			
			
			//fetch all the emails, and send off a message to all the bug handlers about the issue
			while($data = $result->fetchAssoc())
			{
				$email = $data["email"];
				
				mail($email,"A \"$priorityName\" error has been submitted for the application $projectName","Error Type: $priority\n\nMessage:\n$message");
				
				//"from:noreply@spiceapps.com\n\r reply-to:noreply@spiceapps.com")
			}
			
			
		}
		
		
	}
	
	


?>