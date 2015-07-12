<?php

	function mysqlQueryType($query)
	{
		$types = array("SELECT","DELETE","UPDATE","INSERT","CREATE TABLE");
		
		foreach($types as $type)
		{
			if(preg_match("/^$type/i",$query))
			{
				return $type;
			}
		}
		
		return null;
		
	}

?>