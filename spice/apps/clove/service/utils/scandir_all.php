<?php

	function scandir_all($source)
	{
		
		$dirname         = basename(realpath($source));

		$res[ $dirname ] = scandir($source);

		
		$new_source;
		
		$newRes = array();
		
		//list all the files
		foreach($res[$dirname] as $key => $file)
		{
			if($file == "." || $file == "..")
			{
				unset($res[$dirname][$key]);
				continue;
			}
			
			  
			
			$new_source = $source."/".$file;
			
			if(is_dir($new_source))
			{	
				
				
				$ar = scandir_all($new_source);
				
				$newF = $ar[$file];
				
				if(!is_array($newF))
				{
					$newF = array();
				}
				
				$newRes[ $dirname ][$file] = $newF;
				
				
				unset($res[$dirname][$key]);
				
				//$res[$dirname][ $key ] = scandir_all($new_source);
			}
			else
			{
				$newRes[$dirname][] = $res[$dirname][$key];
			}
		}
		
		return $newRes;
	}


?>