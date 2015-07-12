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

	//headers need to be included here
	
	
	require_once dirname(__FILE__)."/../../library/remote/Message.class.php";
	
	abstract class Service
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
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		protected function executeQuery($query,$params= null)
		{
			return self::$connection->execute($query,$params ? $params : array());
		}
		
		
		/**
		 */
		
		protected function getResult($query,$params = null)
		{
			return self::$connection->getResult($query,$params ? $params : array());
		}
		
		
		/**
		*/
	
		protected function getSingleResult($query,$params = null)
		{
			$result = $this->getResult($query,$params ? $params : array())->toAssocArray();
			
			return $result ? $result[0] : null;
		}
		
		/**
		 */
		
		protected function getQuery($query,$params = null)
		{
			return self::$connection->getQuery($query,$params ? $params : array());
		}
	}
	
?>