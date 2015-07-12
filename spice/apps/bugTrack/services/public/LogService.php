<?php

	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	
	require_once dirname(__FILE__).'/LogTypeService.php';
	
	
	class LogService extends Service
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_userService;
		private $_projectService;
		private $_logTypeService;
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
			
			
			$this->_userService = new BugTrackingUserService();
			
			$this->_projectService = new ProjectService();
			
			
			$this->_logTypeService = new LogTypeService();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         */
        
        public function setProject($project)
        {
        	$this->_project = $project;
        	
        	$this->_logTypeService->setProject($project);
        }
        
        /**
		 */
		
		public function log($code,$description,$metadata,$project = null)
		{
		
			
			$projectInfo = $this->_projectService->getProjectById($project);
			
			
			if(!$this->_logTypeService->getLogTypeDescription($code,$project))
			{
				throw new Exception("The code ".$code." is not defined in the database.");
			}
		
			$query = "INSERT INTO `logs` (`project`,`type`,`description`,`metadata`) VALUES(:0,:1,:2,:3)";
			
			
			$newMetadata = $metadata;
			
			if(is_array($metadata))
			{
				$newMetadata = json_encode($metadata);
			}
			
			$this->executeQuery($query,array($project ? $project : $this->_project,$code,$description,$newMetadata));
			
			return true;
		}
		
		
		/**
		 */
		
		public function getLogsByType($code,$project= null)
		{
			
			$query = "SELECT * FROM `logs` WHERE `project` = :0 AND `type` = :1";
			
			
			return $this->getResult($query,array($project ? $project : $this->_project,$code))->toAssocArray();
		}
		
		
	}
	
	


?>