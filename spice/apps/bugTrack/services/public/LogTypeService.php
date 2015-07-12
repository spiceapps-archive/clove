<?php

	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	
	require_once dirname(__FILE__).'/ProjectService.php';
	
	
	class LogTypeService extends Service
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_userService;
		private $_projectService;
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
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function setProject($id)
		{
			$this->_project = $id;
		}
		
        /**
		 */
		
		public function addLogType($code,$description,$project = null)
		{
			$this->_userService->verifySession();
			
			$desc = $this->getLogTypeDescription($code,$project);
			
			
			if($desc)
			{
				throw new Exception("That code is already registered.");
			}
		
			$query = "INSERT INTO `logTypes` (`project`,`code`,`description`) VALUES(:0,:1,:2)";
			
			
			
			$this->executeQuery($query,array($project ? $project : $this->_project,$code,$description));
			
			
			
		}
		
		
		/**
		 */
		
		public function getLogTypeDescription($code,$project = null)
		{
			$query = "SELECT * FROM `logTypes` WHERE `project` = :0 AND `code` = :1 LIMIT 1";
		
			$result = $this->getResult($query,array($project ? $project : $this->_project,$code))->toAssocArray();
			
			return count($result) > 0 ? $result[0] : null;
		}
		
		
		
		
	}
	

?>