<?php

ini_set("memory_limit","50M");

echo "uploading";

/*

require_once(dirname(__FILE__)."/../../libraries/amfphp/services/UserService.php");



//$GLOBALS["INSERT_LIBRARY_ITEM"]		  = "INSERT INTO $libraryTable (`name`,`group`,`description`,`data`,`icon`) VALUES('#anything','#anything','#anything','#anything','#anything')";








$data = file_get_contents($name);


$connection = get_mysql_connection();
$result = $connection->execute(get_query("INSERT_LIBRARY_ITEM"),array($name,$username,$group,$description,$data,''));

exit();*/


$method = $_POST;



if(!$method)
	exit("no post data");
	
	

require_once(dirname(__FILE__)."/../../library/amfphp/services/UserService.php");
require_once(dirname(__FILE__).'/../make_thumb.php');
require_once(dirname(__FILE__).'/../../library/image/SimpleImage.class.php');


$ext = explode(".",$_FILES['Filedata']['name']);

$type = $ext[1];

$name        = time().".$type"; //ext $type


while(is_file($name))
{
	$name = time()."$type";
}


$username    = $method["email"];
$password    = $method["password"];  
//$group       = $method["filters"];
//$description = $method["description"]; 
$filePath 	 = $GLOBALS["image_folder"].'/'.$name;

//authenticate the user credentials



$u = new UserService();

$loginInfo = $u->login($username,$password);

if(!$loginInfo || !$username || !$password)
	exit("the username/password specified is incorrect.");


//$GLOBALS["INSERT_LIBRARY_ITEM"]		  = "INSERT INTO $libraryTable (`name`,`group`,`description`,`data`,`icon`) VALUES('#anything','#anything','#anything','#anything','#anything')";

if(
  isset($_FILES['Filedata']) &&
  is_array($_FILES['Filedata']) &&
  isset(
      $_FILES['Filedata']['tmp_name'],
      $_FILES['Filedata']['name'],
      $_FILES['Filedata']['size'],
      $_FILES['Filedata']['error']
  ) &&
  intVal($_FILES['Filedata']['error']) === 0
) {
  if(move_uploaded_file($_FILES['Filedata']['tmp_name'],$filePath)) {
      $result = "
          Date: ".date('Y-m-d H:i:s')."
          File: {$_FILES['Filedata']['name']}
          Size: {$_FILES['Filedata']['size']}
          Successfull uploaded.
      ";
  }
  else {
      $result = "
          Date: ".date('Y-m-d H:i:s')."
          File: {$_FILES['Filedata']['name']}
          Size: {$_FILES['Filedata']['size']}
          Error: {$_FILES['Filedata']['error']}
          Unable to move file.
      ";
  }
  if(@$fp = fopen($destination_dir.'upload.txt', 'w')) {
      fwrite($fp, $result);
      fclose($fp);
  }
}



sleep(1);
        
$thumb_dir = dirname($filePath)."/thumb/$name";



$connection = get_mysql_connection();


//$GLOBALS["INSERT_LIBRARY_ITEM"]		  = "INSERT INTO $libraryTable (`name`,`owner`,`group`,`description`,`filePath`,`iconPath`) VALUES('#anything','#anything','#anything','#anything','#anything','#anything')";

$result = $connection->execute(get_query("INSERT_LIBRARY_ITEM"),array($name,$username,null,null,htmlpath($filePath),htmlpath($thumb_dir)));


$sim = new SimpleImage();
$sim->load($filePath);

/*
$save = false;

if($sim->getWidth() > $GLOBALS["max_image_width"])
{
	$sim->resizeToWidth($GLOBALS["max_image_width"]);
	$save = true;	
}

if($sim->getHeight() > $GLOBALS["max_image_height"])
{
	$sim->resizeToHeight($GLOBALS["max_image_height"]);
	$save = true;
}

if($save)
{
	$sim->save($filePath);
}
*/


$sim->resizeToWidth(400);

$sim->save($thumb_dir);








?>