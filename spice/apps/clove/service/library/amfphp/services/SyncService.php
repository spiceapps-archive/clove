<?php

	require_once(dirname(__FILE__).'/UserService.php');
	
	import_utility('htmlpath');
	import_utility('local_path');
	
	class SyncService extends MysqlConnector
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
			
			
			$this->_userService = new UserService();
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		function addHistory($data,$compressed = false)
		{
		
			if($compressed)
			{
				$b = gzuncompress($data->data);
			}
			else
			{
				$b = $data->data;
			}
			
			$syncFolder = $GLOBALS["sync_folder"];
			
			
			$syncFile = $syncFolder."/".microtime().".cHist";
			
			
			file_put_contents($syncFile,$b);
			
			$result = self::$connection->execute(get_query("ADD_HISTORY"),array($this->getUserID(),htmlpath($syncFile)));
			
			return true;
		}
		
		function getHistory($minutes,$hours,$month,$day,$year)
		{
//return strtotime($date);
			$date = "$year-$month-$day $hours:$minutes:00";//2009-08-10 17:27:08
			//"
			$date = strftime("%Y-%m-%d %H:%M:%S",mktime($hours,$minutes,0,$month,$day,$year));
			//$date = "2009-08-10 17:27:08
			
			return self::$connection->getResult(get_query("GET_HISTORY"),array($date,$this->getUserID()));
			
		}
		
		
		function getSyncData($minutes,$hours,$month,$day,$year)
		{
		
			$syncData = $this->getHistory($minutes,$hours,$month,$day,$year);
			
			if($syncData[0]["used"])
			{
				throw new Exception('No new data');
			} 
			
			return $syncData[0];
		
		}
			
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		private function getUserID()
		{
		
			$this->_userService->verifySession();
			$info = $this->_userService->loggedInUser();
			return $info["id"];
		}
		
		
		
		
		
		
		
		
		
	}
	
	
	
?>