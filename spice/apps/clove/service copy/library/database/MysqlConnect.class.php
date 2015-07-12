<?php

	class MysqlConnect
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        var $mysql_con;
        var $db_con;
        var $query;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		function __construct($server,$user,$pass,$database = null)
		{
			$this->mysql_con = mysql_connect($server,$user,$pass,$database);
			
			if(!$this->mysql_con)
			{
				ErrorLog::add_error(mysql_error());
			}
			
			$this->set_database($database);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         */
		
		function prepare($query)
		{
			$this->query = $query;
		}
		
        /**
		 */
		
		function set_database($database)
		{
			if($database != null)
			{
				$this->db_con = mysql_select_db($database);
				
				
				if(!$this->db_con)
				{
					ErrorLog::add_error(mysql_error());
				}
			}
		}
		
		/**
		 */
		
		function execute($query,$values = null)
		{
			
		
			$method    = '/#\w+/';
			$new_query = $query;
			$new_value = $values;
			$error     = false;
			$string_type;
			$string_pattern;
			
			
			if($values)
				foreach($values as $key => $value)
				{
					preg_match($method,$new_query,$matches);
				
				
				
					$string_type = $matches[0];
				//	echo $string_type."<BR>";
					$string_pattern = $this->get_regex($string_type);
				
				
				
					$new_value = InputSaftey::cleanse($value,$string_pattern);
				
			
					//replace the old value so that the datatype is taken out
					$new_query = preg_replace("/".$string_type."/",$new_value,$new_query,1);
				
					//ErrorLog::add_error($new_query); 
					//ErrorLog::add_error($new_value == FALSE); 
				
					if($new_value == FALSE)
					{
						ErrorLog::add_error($value." is an invalid input.",E_WARNING);
						$error = true;
					}
				}
			
			$result = mysql_query($new_query,$this->mysql_con);
			
			
			if(!$result)
			{
				ErrorLog::add_error(mysql_error());
			}
			
			return $error ? false : $result;
		}
		
		/**
	     */
	    
	    function getResult($query,$values = null)
	    {
	    	$result = $this->execute($query,$values);
	    	
	    	
	    	if(!$result)
	    		return false;
	    	
			$res = array();
			
	    	while($data = mysql_fetch_array($result))
	    	{
	    		$res[] = $data;
	    	}

	    	return $res;
	    }
	
		/**
		 */
		
		function getAssoc($query,$values = null)
		{
			$result = $this->execute($query,$values);
			
			if(!$result)
				return false;
			
			$res = array();
			
			while($data = mysql_fetch_assoc($result))
			{
				$res[] = $data;
			}
			
			return $res;
		}
		
		/**
		 */
		
		/*function getLength($query,$values = null)
		{
			$result = $this->execute($query,$values);
			
			if(!$result)
				return false;
			
			$res = array();
			
			while($data = mysql_fetch_assoc($result))
			{
				$res[] = $data;
			}
			
			return $res;
		}*/
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function get_regex($type)
		{

			switch($type)
			{
				case "#string":
					return InputSaftey::$STRING;
				break;
				case "#email":
					return InputSaftey::$EMAIL;
				break;
				case "#integer":
					return InputSaftey::$INTEGER;
				break;
				case "#number":
					return InputSaftey::$NUMBER;
				break;
				case "#anything":
					return null;
				break;
			}
			
			throw new Exception("Unable to resolve MySQL parameter type: ".$type);
		}
		
        /**
		 */
		
		function __destruct()
		{
			mysql_close($this->mysql_con);
		}
		
	}
	
	


?>