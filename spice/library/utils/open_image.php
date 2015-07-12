<?php

	function open_image ($file) {
	        // Get extension
	        $extension = strrchr($file, '.');
	        $extension = strtolower($extension);

	        switch($extension) {
	                case '.jpg':
	                case '.jpeg':
	                        $im = @imagecreatefromjpeg($file);
	                        break;
	                case '.gif':
	                        $im = @imagecreatefromgif($file);
	                        break;

	               case '.png':
							$im = @imagecreatefrompng($file);
							break;

	                default:
	                        $im = false;
	                        break;
	        }

	        return $im;
	}
	

?>