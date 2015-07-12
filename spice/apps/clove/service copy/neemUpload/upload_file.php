<?php

require_once(dirname(__FILE__).'/htmlpath.php');
$destination_dir = realpath(dirname(__FILE__).'/files/');


$file = $destination_dir."/".$_FILES['Filedata']['name'];

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
  if(move_uploaded_file($_FILES['Filedata']['tmp_name'], $file)) {
	  
      $result = "
          Date: ".date('Y-m-d H:i:s')."
          File: {$file}
          Size: {$_FILES['Filedata']['size']}
          Successfull uploaded.
      ";

	 $path = urlencode(htmlpath(dirname(__FILE__).'/show.php').'?file='.$_FILES['Filedata']['name']);
	 $newURL = file_get_contents("http://tinyurl.com/api-create.php?url={$path}");
	

	 $result="<e><mediaurl>{$newURL}</mediaurl></e>";
  }
  else {
	  $error = true;
      $result = "
          Date: ".date('Y-m-d H:i:s')."
          File: {$file}
		  TMP: {$_FILES['Filedata']['tmp_name']}
          Size: {$_FILES['Filedata']['size']}
          Error: {$_FILES['Filedata']['error']}
          Unable to move file.
      ";

	  $result = "<e><error>unable to upload file</error></e>";
  }

	echo $result;
}

?>