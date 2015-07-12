<?php

class FileUtils
{
	public static function rmdir_r ( $dir, $DeleteMe = TRUE )
	{
		if ( ! $dh = @opendir ( $dir ) ) return;
		while ( false !== ( $obj = readdir ( $dh ) ) )
		{
			if ( $obj == '.' || $obj == '..') continue;
			if ( ! @unlink ( $dir . '/' . $obj ) ) self::rmdir_r ( $dir . '/' . $obj, true );
		}
		
		closedir ( $dh );
		if ( $DeleteMe )
		{
			@rmdir ( $dir );
		}
	}
	
	public static function chmod_r($path, $filemode) 
	{
		if (!is_dir($path))
			return chmod($path, $filemode);
		
		$dh = opendir($path);
		while (($file = readdir($dh)) !== false) 
		{
			if($file != '.' && $file != '..') 
			{
				$fullpath = $path.'/'.$file;
				if(is_link($fullpath))
					return FALSE;
				elseif(!is_dir($fullpath) && !chmod($fullpath, $filemode))
					return FALSE;
				elseif(!self::chmod_r($fullpath, $filemode))
					return FALSE;
			}
		}
		
		closedir($dh);
		
		if(chmod($path, $filemode))
			return TRUE;
		else
			return FALSE;
	}
	
	
	public static function find_files($path, $pattern, &$files = null) 
	{
		if(!$files)
			$files = array();
			
		$path = rtrim(str_replace("\\", "/", $path), '/') . '/';
		
		$matches = Array();
		$entries = Array();
		$dir = dir($path);
		
		while (false !== ($entry = $dir->read())) 
		{
			$entries[] = $entry;
		}
		$dir->close();
		foreach ($entries as $entry) 
		{
			$fullname = $path . $entry;
			if($entry != '.' && $entry != '..' && is_dir($fullname)) 
			{
				self::find_files($fullname, $pattern, $files);
			} 
			else 
			if(is_file($fullname) && preg_match($pattern, $entry)) 
			{
				$files[] = $fullname;
			}
		}
	}

}

?>