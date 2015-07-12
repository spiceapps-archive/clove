<?php
	function read_ini_file($file, $process_sections = false) {
	  $process_sections = ($process_sections !== true) ? false : true;

	  $ini = file($file);
	  if (count($ini) == 0) {return array();}

	  $sections = array();
	  $values = array();
	  $result = array();
	  $globals = array();
	  $i = 0;
	  foreach ($ini as $line) {
	    $line = trim($line);
	    $line = str_replace("\t", " ", $line);

	    // Comments
	    if (!preg_match('/^[a-zA-Z0-9[]/', $line)) {continue;}

	    // Sections
	    if ($line{0} == '[') {
	      $tmp = explode(']', $line);
	      $sections[] = trim(substr($tmp[0], 1));
	      $i++;
	      continue;
	    }

	    // Key-value pair
	    list($key, $value) = explode('=', $line, 2);
	    $key = trim($key);
	    $value = trim($value);
	    if (strstr($value, ";")) {
	      $tmp = explode(';', $value);
	      if (count($tmp) == 2) {
	        if ((($value{0} != '"') && ($value{0} != "'")) ||
	            preg_match('/^".*"\s*;/', $value) || preg_match('/^".*;[^"]*$/', $value) ||
	            preg_match("/^'.*'\s*;/", $value) || preg_match("/^'.*;[^']*$/", $value) ){
	          $value = $tmp[0];
	        }
	      } else {
	        if ($value{0} == '"') {
	          $value = preg_replace('/^"(.*)".*/', '$1', $value);
	        } elseif ($value{0} == "'") {
	          $value = preg_replace("/^'(.*)'.*/", '$1', $value);
	        } else {
	          $value = $tmp[0];
	        }
	      }
	    }
	    $value = trim($value);
	    $value = trim($value, "'\"");

	    if ($i == 0) {
	      if (substr($line, -1, 2) == '[]') {
	        $globals[$key][] = $value;
	      } else {
	        $globals[$key] = $value;
	      }
	    } else {
	      if (substr($line, -1, 2) == '[]') {
	        $values[$i-1][$key][] = $value;
	      } else {
	        $values[$i-1][$key] = $value;
	      }
	    }
	  }

	  for($j = 0; $j < $i; $j++) {
	    if ($process_sections === true) {
	      $result[$sections[$j]] = $values[$j];
	    } else {
	      $result[] = $values[$j];
	    }
	  }

	  return $result + $globals;
	}

	function write_ini_file($path, $assoc_array)
	{
	    $content = '';
	    $sections = '';

	    foreach ($assoc_array as $key => $item)
	    {
	        if (is_array($item))
	        {
	            $sections .= "\n[{$key}]\n";
	            foreach ($item as $key2 => $item2)
	            {
	                if (is_numeric($item2) || is_bool($item2))
	                    $sections .= "{$key2} = {$item2}\n";
	                else
	                    $sections .= "{$key2} = \"{$item2}\"\n";
	            }      
	        }
	        else
	        {
	            if(is_numeric($item) || is_bool($item))
	                $content .= "{$key} = {$item}\n";
	            else
	                $content .= "{$key} = \"{$item}\"\n";
	        }
	    }      

	    $content .= $sections;

	    if (!$handle = fopen($path, 'w'))
	    {
	        return false;
	    }

	    if (!fwrite($handle, $content))
	    {
	        return false;
	    }

	    fclose($handle);
	    return true;
	}

	function beginsWith( $str, $sub ) {
	    return ( substr( $str, 0, strlen( $sub ) ) === $sub );
	}
?>