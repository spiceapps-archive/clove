<?php

/******************************************************************
 * Author: Craig Condon
 * 
 * Purpose: minimize the amount of MySQL connections to the database
 * 
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/

	$dir = dirname(__FILE__);
	
	
	require_once($dir."/../../includes/headers.inc.php");
	
	
	abstract class MysqlConnector
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        protected static $connection;
        
	
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		function __construct()
		{
			if(self::$connection == null)
			{
				self::$connection = get_mysql_connection();
			
				if(!self::$connection)
				{
					throw new Exception("unable to establish a connection with the MySQL database");
				}
			}
		}
	}
	
?>