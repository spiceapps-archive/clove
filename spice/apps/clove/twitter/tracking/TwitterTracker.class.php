<?php
	
	require_once(dirname(__FILE__)."/Twitter.class.php");
	
	class TwitterTracker 
	{
		
		private $_twitter;
		private $_cacheDir;
		
		
		function __construct($cacheDir)
		{
			$this->_twitter  = new Twitter();
			$this->_cacheDir = $cacheDir;
		}
		
		
		function track($id,&$conversation = null)
		{
			
			
			
			$cacheFile = $this->_cacheDir."/".$id.".json";
			
			if(file_exists($cacheFile))
			{
				
				$cached = file_get_contents($cacheFile);
				
				if(isset($conversation))
				{
					$conversation = json_decode($cached);
				}
				
				return $cached;
			}
			
			
			
			//set the current ID to the one being selected
			$currentID = $id;
			
			
			$conversation = $conversation ? $conversation : array();
			
			
			while(true)
			{
				$xml = $this->_twitter->showStatus($currentID);
				
				$currentID =  $xml->in_reply_to_status_id;
				
				echo $xml->asXML()."<BR>";
				
			    $conversation[] = array("name"=>$xml->user->name."",
										"screenName"=>$xml->user->screen_name."",
										"text"=>$xml->text."",
										"createdAt"=>$xml->created_at."",
										"id"=>$xml->id."",
										"source"=>$xml->source."");
			
			
				if($currentID == "")
					break;
			}

			$conversationJSON = json_encode($conversation);
			
			file_put_contents($cacheFile,$conversationJSON);
			
			return $conversationJSON;
			
		}
		
		
		function getConversationLength($id)
		{
			$conversation = array();
			
			$this->track($id,$conversation);
			
			
			return count($conversation);
		}
		
		function hasConversation($id)
		{
			return $this->getConversationLength($id) > 1;
		}
		
		
	}
?>