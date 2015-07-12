<?php
	
	$method = $_GET["type"];
	
	
	switch($method)
	{
		case "install":
		
			$app = $_GET["app"];
			
			$baseDir = dirname(__FILE__)."/../apps/$app/";
			
			$headers = realpath("$baseDir/includes/headers.inc.php");
			
			
			$installDir = "$baseDir/install/";
			require_once($headers);
			
			
			$mysql = get_mysql_connection();
			
			
			foreach(scandir($installDir) as $file)
			{
				if(strstr($file,".sql") !== FALSE)
				{
					$sqlFile = $installDir.$file;
					
					foreach($mysql->executeSQLFile($sqlFile) as $result)
					{
						echo $result."<BR>";
					}
				}
			}
		break;
	}
?>