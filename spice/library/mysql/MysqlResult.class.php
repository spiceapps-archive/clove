<?php
	
	
	
	class MysqlResult
	{
	
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_result;
		private $_assocArrayCache;
		private $_rowArrayCache;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		function __construct($result)
		{
			$this->_result = $result;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function fetchRow()
		{
			return mysql_fetch_row($this->_result);
		}
		
		/**
		 */
		
		public function fetchAssoc()
		{
			return mysql_fetch_assoc($this->_result);
		}
		
		/**
		 */
		
		public function fetchArray()
		{
			return mysql_fetch_array($this->_result);
		}
		
		/**
		 */
		
		public function toAssocArray()
		{
			if($this->_assocArrayCache)
				return $this->_assocArrayCache;
				
			$this->_assocArrayCache = $stack = array();
			
			while($data = $this->fetchAssoc())
			{
				$stack[] = $data;
			}
			
			return $stack;
		}
		
		/**
		 */
		
		public function toArray()
		{
			if($this->_rowArrayCache)
				return $this->_rowArrayCache;
			
			$this->_rowArrayCache =  $stack = array();
			
			while($data = $this->fetchRow())
			{
				$stack[] = $data;
			}
			
			return $stack;
		}
		
		
	}

?>