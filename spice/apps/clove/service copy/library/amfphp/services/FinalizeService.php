<?php
	
	require_once(dirname(__FILE__).'/LibraryService.php');
	require_once(dirname(__FILE__).'/../../export/VideoAS3Builder.class.php');

	class FinalizeService extends EdgarConnection
	{
		
		var $_userService;
		var $_libraryService;
		
		function FinalizeService()
		{
			parent::__construct();
			
			$this->_userService = new UserService();
			$this->_libraryService = new LibraryService();
			
		}
		
		
		function finalize($projectID)
		{
			
			$this->_userService->verifySession();
			
			$info = $this->_userService->loggedInUser();
			
			
			
			
			$libInfo = $this->_libraryService->loadLibraryItem($projectID,-1);
			
			$projectPath = $libInfo[0]["filePath"];
			
			$builder = new VideoAS3Builder(local_path($projectPath));
			
			
			$projDir = $this->_libraryService->getUserLibrary()."/$projectID/";
			
			@mkdir($projDir,0777,true);
			
			return $builder->compile($projDir);
			
			if($this->getProjectOwner($projectID))
			{
				throw new Exception("Your project is already being finalized.");
			}
			
			$result = self::$connection->execute(get_query('FINALIZE_PROJECT'),array($info["user_id"],$projectID));
			
			
			
		 	return "We'll email you when your video is done encoding.";
		}
		
		
		function notifyCompletion($projectID,$directory)
		{
			$this->_userService->verifySession(5);
			
			//destroy the project info
			
			$info = self::$connection->getResult(get_query('PROJECT_OWNER_INFO'),array($projectID));
			
			
			
			
			$email = $info[0]["email"];
			
			mail($email,"Edgar Video Complete","Your video has been encoded. You can view it here:".htmlpath($directory));
			
			return self::$connection->execute(get_query('FLV_COMPLETE'),array(htmlpath($directory),$projectID));
			
		}
		
		
		function getFinalizedProjects()
		{
			$result = self::$connection->getResult(get_query('SELECT_FINALIZED_PROJECTS'));
			
			
			
			return $result;
		}
		
		function getProjectOwner($projectID)
		{
			$data = self::$connection->getResult(get_query('SELECT_PROJECT_OWNER'),array($projectID));
			
			
			if(!$data)
				return false;
				
			return $data[0];
		}
		
	}
	
	
?>