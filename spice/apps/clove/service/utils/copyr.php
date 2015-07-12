<?php

	function copyr($source,$dest,$variables = null)
	{
		
		
		//if source is file
		
		if(is_file($source))
		{
			$cont = file_get_contents($source);
			
			if($variables != null)
				foreach($variables as $k => $v)
				{
					$cont = str_replace($k,$v,$cont);
				}
			

			$handle = fopen($dest,"w");
			fwrite($handle,$cont);
			fclose($handle);
			//fwrite(resource handle, string string [, int length])
			//file_put_contents("TEST",$dest);
			
			
			//$c = copy($source,$dest);
			
			//chmod($dest,0777);
			
			return $c;
		}
		
		//make the directory
		
		if(!is_dir($dest))
		{
			$oldumask = umask(0);

			mkdir($dest,0777);
			
			umask($oldumask);
		}
		
		//echo 
		
		$dir = dir($source);
		
		while(false !== $entry = $dir->read())
		{
			if($entry == "." || $entry == "..")
				continue;
				
			if($dest !== "$source/$entry")
			{
				copyr("$source/$entry","$dest/$entry",$variables);
			}
			
			
		}
		
		$dir->close();
		
		return true;
		
		
	}

?>