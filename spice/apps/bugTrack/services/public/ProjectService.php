<?php
	
	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	require_once dirname(__FILE__)."/../includes/headers.inc.php";
	
	require_once dirname(__FILE__)."/BugTrackingUserService.php";
	

	class ProjectService extends Service
	{
	
	
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_userService;
		
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
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function createProject($name,$description)
		{
		
			$this->_userService->verifySession();
			
			if($this->projectExistsByName($name))
			{
				throw new Exception("Project ".$name." already exists.");
			}
			
			
			$query = "INSERT INTO `projects` (`name`,`description`,`owner`) VALUES(:0,:1,:2)";
			
			
			
			$this->executeQuery($query,array($name,$description,$this->_userService->userId()));
			
			
			
			return self::$connection->getLastInsertedId();
		}
		
		/**
		 */
		
		public function projectExistsById($id)
		{
			return count($this->getProjectById($id)) > 0;
		}
		
		/**
		 */
		
		public function projectExistsByName($name)
		{
			return count($this->getProjectByName($name)) > 0;
		}
			
		
		/**
		 */
		
		public function getProjectById($id)
		{
			$query = "SELECT * FROM `projects` WHERE `id` = :0 LIMIT 1";
			
			$info = $this->getResult($query,array($id))->toAssocArray();
			
			return $info[0]; 
		}
		
		/**
		 */
		
		public function getProjectByName($name)
		{
			$query = "SELECT * FROM `projects` WHERE `name` = :0 LIMIT 1";
			
			$info = $this->getResult($query,array($name))->toAssocArray();
			
			return $info[0]; 
		}
		
		/**
		 */
		
		public function getProjectCompanyId($projectId)
		{
			$query = "SELECT * FROM `accounts` WHERE `id` = (
																	SELECT `company` FROM `users` WHERE `id` = (
																												 SELECT `owner` FROM `projects` WHERE `id` = :0
																												)
																) LIMIT 1";
			$result = $this->getResult($query,array($projectId))->toAssocArray();
			
			return $result[0]["id"];
		}
		
	}
	


?>