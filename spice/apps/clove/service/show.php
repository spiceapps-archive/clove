<?php

$tok = $_GET["tok"];


if($tok != "FNDSJFBDSJKL")
	exit();


$source = $_GET["file"];


show_source($source);




?>