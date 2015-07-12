<?php

	require_once(dirname(__FILE__).'/UserService.php');
	
	import_utility('htmlpath');
	import_utility('local_path');
	
	class PluginService extends MysqlConnector
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
		
		
		
		function addPlugin($name = null,
						   $type = null,
						   $description = null)
		{
			$pluginFolder = $GLOBALS["plugin_folder"];
			
			
			$pluginFile = $pluginFolder.$name.'.cPlugin';
			
			
			if($this->hasPlugin($name) || file_exists($pluginFile))
			{
				throw new Exception("That plugin name has already been taken");
			}
			
			
			file_put_contents($pluginFile,'');
			
			$pluginRemotePath = htmlpath($pluginFile);
	
			
			$result = self::$connection->execute(get_query("INSERT_PLUGIN"),array($name,$type,$description,$pluginRemotePath,$this->getUserID()));
			
			
			return mysql_insert_id();
		}
		
		/**
		 */
		
		function getPluginByName($name)
		{
			$inf = self::$connection->getResult(get_query("SELECT_PLUGIN_BY_NAME"),array($name));
			
			return $inf[0];
		}
		
		/**
		 */
		
		function getPluginById($id)
		{
		
			$inf = self::$connection->getResult(get_query("SELECT_PLUGIN_BY_ID"),array($id));
			
			return $inf[0];
		}
		
		/**
		 */
		
		
		function hasPlugin($name)
		{
			return $this->getPluginByName($name) != null;
		}
		
		/**
		 */
		
		
		function getPluginList()
		{
			return self::$connection->getResult(get_query("SELECT_PLUGINS"),array($this->getUserID()));
			
		}
		
		/**
		 */
		
		
		function savePlugin($id,$name,$description,$pluginBa)
		{

			
			$result = self::$connection->execute(get_query("UPDATE_PLUGIN"),array($name,$description,$id,$this->getUserID()));
		
			
			
			$pluginInfo = $this->getPluginByID($id);
			
			$remotePath = $pluginInfo["filePath"];
			
			$localpath = local_path($remotePath);
			
			
			try
			{
				file_put_contents($localpath, gzuncompress($pluginBa->data));
			}catch(Exception $e)
			{
			}
			
			
			return true;
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