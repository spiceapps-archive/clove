<?php

	class NamespaceUtil
	{
		
		public static function addNamespace($ns,$value)
		{
			if(count($ns) > 0 && !strstr($value,$ns.":"))
			{
				return $ns.":".$value;
			}   
			
			return $value;
		}            
		
		public static function removeNamespace($ns,$value)
		{
			#var reg:RegExp = new RegExp("^"+ns+":*","x");
			
			#return value.replace(reg,"");
		}
		
		public static function removeNamespaceIfPresent($nodeName)
		{
		   $reg = "/[^\s]+:/";
		
			
			if($replace = preg_replace($reg,"",$nodeName))
			{
				return $replace;
			}
			
			return $nodeName;
		
		}
		
		public static function getNamespace($value)
		{
           
			
			if(!$value)
				return "";
			
			preg_match("/\w+/i",$value,$match);
			
			
			if(!$match)
				return "";    
				
			return $match[0]; 
		}
		
		public static function getNamespaceIfPresent($value)
		{
			//FIX LATER
		   

		   $result = preg_match("/^\w*(?=:.*)/i",$value);
		   
			
			if($result == null)
				return "";
			
			return $result[0];

		}

		
		public static function hasNamespace($ns,$value)
		{
			   
			$match = preg_match($ns."(?=:)((?=[^=]*))?",$value);

			
			return $match != null && count($match) > 0 || $ns == $value;  
		}

	}
?>