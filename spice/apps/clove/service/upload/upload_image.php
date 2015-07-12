<?php

	require_once(dirname(__FILE__).'/upload_script.php');
	
	
	
	return;

	
	
	//find the file that the data was uploaded to
	//require_once "$dirnm/make_icon.php";
	
	//opens any kind of image
	require_once(dirname(__FILE__).'/../make_thumb.php');
	

	
	//$image = open_image($_FILES['image']['tmp_name']);
	//$image = imagecreatefrompng("http://localhost/moap/service/farm/patterns/eyes/eye-1.png");
	
	//$thumb_dir = dirname($destination_dir)."/thumb";
	
	//@mkdir($thumb_dir);
	
	//$handle = "$thumb_dir/".$_FILES['Filedata']['name'];
	
	
	$connection = get_mysql_connection();
	
	$connection->execute(get_query("INSERT_LIBRARY_ITEM"),array($_FILES['Filedata']['name'],$siteDir["group"],'null',$_FILES['Filedata'][''],""));
	
	//echo $destination_dir."\n\n\n\n";
	make_thumb($destination_dir,$handle);
	

	

	
	/*$width  = imagesx($image);
	$height = imagesy($image);
	
	$new_width  = 150;
	$new_height =  round(($new_width * $height) / $width); 
	
	
	$image_resized = imagecreatetruecolor($new_width,$new_height);
	imagecopyresampled($image_resized,$image,0,0,0,0,$new_width,$new_height,$width,$height);
	*/
	
/*	header('Content-Type:image/png');
	imagepng($image);
	imagedestroy($image);*/
	//

?>