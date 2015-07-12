<?php

	class ErrorLog
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Singleton
        //
        //--------------------------------------------------------------------------
        
        private static $error_log;
        
		//--------------------------------------------------------------------------
   	    //
        //  Public Static Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function add_error($message,$type = E_ALL)
		{
			self::init();
			
			if(self::$error_log[(string)$type] == null)
			{
				self::$error_log[(string)$type] = array();
			}
			
			
			self::$error_log[(string)$type][] = $message;
				
		}
		
		/**
		 */
		
		public static function get_errors($type = E_ALL)
		{
			$result = array();
			
			self::init();
			
			if(count(self::$error_log) > 0)
				if($type == E_ALL)
				{
					foreach(self::$error_log as $key => $value)
					{
						for($j = 0; $j < count($value); $j++)
						{
							$result[] = $value[$j];
						}
					}
				}
				else
				{
					$result = self::$error_log[(string)$type];
				}
			
			
			return $result;
			
		}
		
		/**
		 */
		
		public static function has_errors()
		{
			return count(self::$error_log) > 0;
		}
		
		
		/**
		 */
		
		public static function flush()
		{
			$error_log = array();
		}
		
		/**
		 */
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private static function init()
		{
			if(self::$error_log == null)
			{
				self::flush();
			}
		}
		
		
	}

?>