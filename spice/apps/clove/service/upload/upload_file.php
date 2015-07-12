<?php

error_reporting(E_ALL);

echo "UP";

print_r($GLOBALS);

print_r($_FILES);

if(!isset($_FILES) || !isset($_POST))
{
	exit('No file is being uploaded.');
}


require_once(dirname(__FILE__)."/../library/amfphp/services/UserService.php");
require_once(dirname(__FILE__)."/../library/amfphp/services/LibraryService.php");
require_once(dirname(__FILE__)."/../includes/conf.inc.php");
require_once(dirname(__FILE__)."/../utils/htmlpath.php");
require_once(dirname(__FILE__)."/../utils/make_thumb.php");

//get the asset directory
$upload_dir = $GLOBALS["library_folder"];

$fileData = $GLOBALS['HTTP_RAW_POST_DATA'];
$fileName = $_GET["name"];
$projectID = $_GET["projectId"];



preg_match('/(.*?)(\.\w+)$/',$fileName,$matches);

$namePart = $matches[1];
$extension =$matches[2];
 

echo "UPLOADING ";


$serv = new UserService();
$serv->login($_GET["email"],$_GET["pass"]);

//if the user is not logged in then exit the script
if(!$serv->isLoggedIn())
	exit('You are not logged in.');
	
	

$inf = $serv->loggedInUser();


//if the extension is NOT a video project, then upload the item as a new UID, otherwise
//use the same name it was given (still UID on creation)
$uid = $extension != "videoProj" ? microtime() : $fileName;

echo $uid;

$lib = new LibraryService();

//create the unique id for the uploaded file
$uniqueFileName = $uid.$extension;

$iconName = $uid."_thumb".$extension;


$filePath = $lib->addLibraryFile($uniqueFileName,$fileData);

print_r($_FILES);
echo $filePath." ".$_FILES['Filedata']['tmp_name']."\n";
//if success, then add the item to the library
if(true)
{
	switch(strtolower($extension))
	{
		case ".jpg":
		case ".jpeg":
		case ".png":
		case ".gif":
			//create the thumb of the image
			
			$iconPath = $lib->addLibraryFile($iconName);
			make_thumb($filePath,$iconPath);
			$lib->addImage($projectID,$filePath,$iconPath);
		break;
		case ".mp3":
			echo "ADDING MP3 \n".$filePath."\n";
			$success = move_uploaded_file($_FILES['Filedata']['tmp_name'],$filePath);
		
			
			$lib->addMusic($projectID,$namePart,$filePath);	
			chmod($filePath,0777);
		break;
		
		//the video project 
		case ".videoProj":
			
			$lib->saveProject($filePath,'nothing');
		break;
	}
}

echo $success ? $fileName : 'FAILED';



?>