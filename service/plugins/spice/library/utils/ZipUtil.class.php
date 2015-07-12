<?php


class ZipUtil
{
	public static function zipAll($baseFile,$zipFile,$curZipPath = "",&$zip = null)
	{
		if(!$zip)
		{
			$zip = new ZipArchive();
			if(($error = $zip->open($zipFile,file_exists($zipFile) ? ZIPARCHIVE::OVERWRITE : ZIPARCHIVE::CREATE)) !== TRUE)
			{
				die($error);
				return false;
			}
		}
		
		if(is_dir($baseFile))
		{
			$files = scandir($baseFile);
			
			foreach($files as $file)
			{
				if($file == "." || $file == "..") continue;
								
				ZipUtil::zipAll(realpath($baseFile."/".$file),$zipFile,$curZipPath."/".$file,$zip);
				
			}
		}
		else
		{
			//$zip->addFile($curZipPath,$baseFile);	
			$zip->addFromString($curZipPath,file_get_contents($baseFile));
		}
		
		return $zip;
	}
	
	public static function errorToString($error)
	{
		switch($error)
		{
		
			case ZIPARCHIVE::ER_EXISTS:
				return "exists";
			break;
			case ZIPARCHIVE::ER_INCONS:
				return "incons";
			break;
			case ZIPARCHIVE::ER_MEMORY:
				return "memory";
			break;
			case ZIPARCHIVE::ER_NOENT:
				return "noent";
			break;
			case ZIPARCHIVE::ER_OPEN:
				return "open";
			break;
			case ZIPARCHIVE::ER_READ:
				return "read";
			break;
			case ZIPARCHIVE::ER_SEEK:
				return "seek";
			break;
		}
	}		
}

?>