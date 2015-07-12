<?php

	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	
	require_once dirname(__FILE__).'/ProjectService.php';
	
	
	class BugPriorityService extends Service
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
		
		public function addPriorityLevel($name,$priority,$styling = "[NAME]")
		{
			$this->_userService->verifySession();
			
			if($this->hasPriority($name,$priority))
			{
				throw new Exception("The priority name ".$name.", or id ".$priority." already exists.");
			}
			
		
			$query = "INSERT INTO `bugPriority` (`priority`,`name`,`styling`,`company`,`reportTo`) VALUES(:0,:1,:2,:3,:4)";
			
			
			$reportTo = json_encode(array($this->_userService->userId()));
			
			$this->executeQuery($query,array($priority,$name,$styling,$this->_userService->getUserCompany(),$reportTo));
			
			return true;
		}
		
		/**
		 */
		
		public function getPriorityLevels($company = -1)
		{
			
			
			$query = "SELECT * FROM `bugPriority` WHERE `company` = :1";
			
			$result = $this->getResult($query,array($this->getCompany($company)))->toAssocArray();
			
			return $result;
		}
		
		
		/**
		 */
		
		public function getPriorityName($id,$company = -1)
		{
		
			
			$query = "SELECT `name` FROM `bugPriority` WHERE `priority` = :0 AND `company` = :1 LIMIT 1";
			
			$result = $this->getResult($query,array($id,$this->getCompany($company)))->toAssocArray();
			
			return $this->getResultValue($result);
		}
		
		/**
		 */
		
		public function getPriorityId($name,$company = -1)
		{
			$query = "SELECT * FROM `bugPriority` WHERE `name` = :0 AND `owner` = `company` = :1 LIMIT 1";
			
			
			$result = $this->getResult($query,array($name,$this->getCompany($company)))->toArray();
			return $result;
			
			return $this->getResultValue($result);
		}
		
		/**
		 */
		
		public function hasPriority($name,$id,$company = -1)
		{
			
			$query = "SELECT * FROM `bugPriority` WHERE `name` = :0 OR `priority` = :1 AND `company` = :2 LIMIT 1";
			
			$result = $this->getResult($query,array($name,$id,$this->getCompany($company)))->toAssocArray();
			
			return $this->getResultValue($result);
		}
		
		
		/**
		 */
		
		public function getBugHandler($code,$company = -1)
		{
			$query = "SELECT `reportTo` FROM `bugPriority` WHERE `priority` = :0 AND `company` = :1 LIMIT 1";
			
			$result = $this->getResult($query,array($code,$this->getCompany($company)))->toAssocArray();
			
			$info = $this->getResultValue($result);
			
			
			return json_decode($info["reportTo"]);
		}
		
		private function getCompany($owner)
		{
			return  $owner > -1 ? $owner : $this->_userService->getUserCompany();
		}
		
		
		private function getResultValue($result)
		{
			return count($result) > 0 ? $result[0] : null;
		}
		
	}
	
	
?>