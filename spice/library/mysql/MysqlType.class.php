<?php
	
	
	/**
	 * returns the query type
	 */
	 
	class MysqlType
	{
	
	
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		
		public static function getType($query)
		{
			$types = array("SELECT","DELETE","UPDATE","INSERT");
			
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