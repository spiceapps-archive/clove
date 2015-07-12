<?php

	require_once(dirname(__FILE__).'/UserService.php'); 
	 //we use the htmlpath utility for converting local paths into paths that can be accessed
	//using a browser
	import_utility('htmlpath');
	import_utility('local_path');
	
	class LibraryService extends EdgarConnection
	{
		
		var $_userService;
		
		
		function LibraryService()
		{
			parent::__construct();
			
			
			$this->_userService = new UserService();
		}
		
		function loadImages($id)
		{
			
			return $this->loadLibraryItems('images',$id);
		}
		
		function addImage($projectID,$filePath,$iconPath)
		{
			return $this->insertLibraryItem($filePath,$iconPath,'images','',$projectID);
		}
		
		
		function loadMusic($id)
		{	
			return $this->loadLibraryItems('music',$id);
		}
		
		function addMusic($projectID,$name,$filePath)
		{
			return $this->insertLibraryItem($filePath,'','music',$name,$projectID);
		}
		
		
		function createProject($name,$data="")
		{
			
			$this->verifyLogin();
			
			$uniqueFileName = microtime().".videoProj";
			
			
			$path = $this->addLibraryFile($uniqueFileName,$data);
			
			$result = $this->insertLibraryItem($path,"",'project',$name);
			
			
			if(!$result)
			{
				throw new Exception("Unable to create new project.");
			}
			
			$data = $this->loadLibraryItemByPath(htmlpath($path));
			//we need to grab the new UID
			return $data[0];

		}
		
		
		function saveProject($id,$name,$saveData="")
		{
			
			$this->verifyLogin();
			
			$data = $this->loadLibraryItem($id,$id);
			
			if(!$data)
			{
				throw new Exception("No project with the ID of ".$id." exists.");
			}
			
			$localPath = local_path($data[0]["filePath"]);
			
			$handle = fopen($localPath,"wb");
			fwrite($handle,$saveData);
			fclose($handle);
			
			return $localPath;
		}
		
		
		function loadLibraryItem($id,$projectID = 0)
		{
			$this->verifyLogin();
			
			$owner = $this->_userService->loggedInUser();
			
			
			
			return self::$connection->getResult(get_query('SELECT_LIBRARY_ITEM'),array($owner["user_id"],$id,$projectID));
				
		}
		
		function loadLibraryItemByPath($path)
		{
			$this->verifyLogin();
			
			$owner = $this->_userService->loggedInUser();
			
			
			
			return self::$connection->getResult(get_query('SELECT_LIBRARY_ITEM_BY_FILE_PATH'),array($owner["user_id"],$path));
				
		}
		
		
		function loadProjects()
		{
			return $this->loadLibraryItems('project');
		}
		
		
		
		function getUserLibrary()
		{
			$this->verifyLogin();
			
			$userInfo = $this->_userService->loggedInUser();
			
		 	return $GLOBALS["library_folder"].$userInfo['email']."_".$userInfo["user_id"]."/";
		}
		
		function addLibraryFile($name,$data = "")
		{
			
			
			$libDir = $this->getUserLibrary();
			
			//if this is the first file the user is uploading, then create a directory
			//for that user
			if(!file_exists($libDir))
			{
				@chmod($GLOBALS["library_folder"],0777);
				
				mkdir($libDir,0410,true);
				chmod($libDir,0777);
			}
			
			$libFile = $libDir.$name;
			
			
			//upload the file to the server
			$handle = fopen($libFile,'wb');
			$success = fwrite($handle,$data);
			fclose($handle);
			
			return $libFile;
		}
		
		
		
		function loadLibraryItems($group,$id = -1)
		{
			
			$this->verifyLogin();
			
			$info = $this->_userService->loggedInUser();
			
			return self::$connection->getResult(get_query("SELECT_LIBRARY_ITEMS"),array($info["user_id"],$id,$group));
		}
		
		
		
		
		private function insertLibraryItem($filePath,$iconPath,$group,$name="",$projectID=-1)
		{
			$this->verifyLogin();
			
		    //get the logged in user info
			$info = $this->_userService->loggedInUser();
			
			
			
			$result = self::$connection->execute(get_query("INSERT_LIBRARY_ITEM"),array($group,$info["user_id"],htmlpath($filePath),htmlpath($iconPath),$name,$projectID));
			
			if(!$result)
			{
				//throw new Exception("Unable to upload library item $filePath.");
			}
			
			return true;
		}
		
		
		/**
		 * verifies the login credentials and throws an error if no session is found
	     */
	
		private function verifyLogin()
		{
			$loggedIn = $this->_userService->isLoggedIn();
			
			if(!$loggedIn)
			{
				throw new Exception("You must be login before accessing your library.");
			}
			
			return true;
		}
		
		
		
	}
	
?>