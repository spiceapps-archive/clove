<?php
	require_once dirname(__FILE__).'/../security/InputSafety.class.php';
	require_once dirname(__FILE__).'/../log/Logger.class.php';
	require_once dirname(__FILE__).'/MysqlResult.class.php';
	require_once dirname(__FILE__).'/mysqlQueryType.func.php';
	require_once dirname(__FILE__).'/../exceptions/MysqlConnectException.class.php';
	
	class MysqlConnect
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
       	private $mysql_con;
        private $db_con;
        private $query;
        private $_inputSafety;
        private $_regexpHandler;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		function __construct($server,$user,$pass,$database = null)
		{
			$this->mysql_con = @mysql_connect($server,$user,$pass,$database);
			
			if(!$this->mysql_con)
			{
				$this->logMysqlError();
			}
			
			$this->_inputSafety = InputSafety::getInstance();
			
			
			//used for custom regexp
			$this->_regexpHandler = new RegexpSafetyHandler();
			
			$this->setDatabase($database);
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
		
		function setDatabase($database)
		{
			if($database != null)
			{
				$this->db_con = @mysql_select_db($database,$this->mysql_con);
				
				
				if(!$this->db_con)
				{
					$this->logMysqlError();
				}
			}
		}
		
		/**
		 */
		
		function execute($query,$values = null)
		{
			
		
			
			$new_query = $this->getQuery($query,$values);
				
			$result = mysql_query($new_query,$this->mysql_con);
			
			
			if(!$result)
			{
				$this->logMysqlError();
				return false;
			}
			
			return $result;
		}
		
		/**
		 */
		
		function executeMult($query,$values = null,&$queries = null)
		{
			
			$queries = explode(";",$query);
			
			$result = array();
			
			foreach($queries as $query)
			{
				$result[] = $this->execute($query,$values);
			}
			
			
			return $result;
		}
		
		
		
		/**
		 * returns the fixed Mysql query with the changed parameters
		 */
		
		function getQuery($query,$values = null)
		{
			
			$new_query = $query;
			
			$offset = 0;
			
				
			if($values)
			{
			
				$method    = '/(?!=\')(#.*?)?:(\w+)(?!\')/'; //matches SELECT * FROM ... WHERE .. = string:0 or :i
				$new_value = $values;
				
				do
				{					
					if(!preg_match($method,$new_query,$matches,PREG_OFFSET_CAPTURE,$offset))
						break;
					
					
					$type = $matches[1][0];
					//has specific type-- email, string, etc
					$typeHandle = substr($type,1);
					$index = $matches[2][0];
					
					$charPos = $matches[0][1];
					
					//if the first char is a #, then we are using a custom regular expression
					if($typeHandle[0] == "#")
					{
						$this->_regexpHandler->regexp = "/".substr($typeHandle,1)."/";//set the regexp
						
						$typeHandle = $this->_regexpHandler;
					}
					
					
					
					$value = $values[$index];
					
					
					try
					{
						//convert into mysql safe chars
						$new_value = $type != '' ? $this->_inputSafety->cleanse($value,$typeHandle) : $value;
					}
					catch(InputSafetyException $e)
					{
						Logger::logError($e);
						return false;
					}
					
					$new_value = "'".@addslashes($new_value)."'";
					
					
					
					//we add an offset so that we don't reprocess the value
					$offset = $charPos + strlen($new_value);
					
					
					$replaceText = $matches[0][0];
					
					//replace the old value so that the datatype is taken out
//					echo strlen($new_query)." ".$charPo." ".$new_value;
					
					
					$new_query = substr_replace($new_query,$new_value,$charPos,strlen($replaceText));
						
				}
				while(true);
			}
			
			return $new_query;
		}
		
		
		
		/**
	     */
	    
	    function getResult($query,$values = null)
	    {
	    	$result = $this->execute($query,$values);
	    	
	    	
	    	$mres = new MysqlResult($result);
	    	
	    	

	    	return $mres;
	    }
	    
	    /**
	     */
	    
	    function getResults($query,$values = null)
	    {
	    	$results = $this->executeMult($query,$values,$queries);
	    	
	    	
	    	
	    	$mres = array();
	    	for($i = 0; $i < count($results); $i++)
	    	{
	    		$result = $results[$i];
	    		
	    		if(mysqlQueryType($queries[$i]) == "SELECT")
	    		{
	    			$mres[] = new MysqlResult($result);
	    		}
	    		else
	    		{
	    			$mres[] = $result;
	    		}
	    	}
	    	

	    	return $mres;
	    }
	    
	    
	    /**
		 */
		
		function getLastInsertedId()
		{
			return mysql_insert_id();
		}
		
		/**
		 */
		
		
		function getQueryType($query)
		{
			return mysqlQueryType($query);
		}
		
		
		/**
		 * executes a SQL file
		 */
		
		public function executeSQLFile($dir)
		{
			//taken from http://www.hotscripts.com/forums/php/27124-run-sql-file-through-php.html
			
			
			//get the contents of the SQL file
			$content = file($dir);
			
			
			//the queries to execute
			$queries = array();
			
			//the execution results
			$result = array();
			
			//TRUE if there is a query currently being executed
			$found = false;
			
			//the query index
			$i = 0;
			
			
			$queries[$i] = "";
			
			
			foreach($content as $line)
			{
				if(trim($line) != "" &&
				   strpos($line,"--") === false)
				{
				
					//flag found so that we preserve the current query
					$found = true;
					
					$queries[$i] .= $line;
				}
				else
				if($found)
				{
					
					//execute the query
					try
					{
						$result[$i] = $this->execute($queries[$i]);
					}catch(Exception $e)
					{
						$result[$i] = $e;
					}
					
					
					
					$found = false;
					$i++;
					
					//initialize the next query
					$queries[$i] = "";
				}
					
			}
			
			try
			{
				$result[$i] = $this->execute($queries[$i]);
			}catch(Exception $e)
			{
				$result[$i] = $e;
			}
			
			//return the results. Exceptions and successes
			return $result;
			
		}
		
	   
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
       	
       
		
        /**
		 */
		
		function __destruct()
		{
			if($this->mysql_con)
				mysql_close($this->mysql_con);
		}
		
		
		/**
		 */
		
		private function logMysqlError()
		{
			$e = mysql_error();
			
			if($e)
			{
				Logger::log($e,E_ERROR);
			}
		}
		
	}
		
?>