<?php

	require_once(dirname(__FILE__)."/../notifications/Notification.class.php");
	require_once(dirname(__FILE__)."/INotifier.interface.php");

	class Notifier implements INotifier
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private $observers;
        private $increm;
        private $target;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function __construct(INotifier $target = null)
		{
			$this->target = $target == null ? $this : $target;
		
			$this->observers = array();	
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function toString()
		{
			return "";	
		}
		
		/**
		 */
		
		public function notifyObservers(Notification $note)
		{
			
			$type = $note->type;
			
			$note->target = $this->target;
			
			
			if(@array_key_exists($type,$this->observers))
			{
			
			
				$observers = $this->observers[$type];
				
				foreach($observers as $value)
				{	
					
					$observer = $value["object"];
					$function = $value["function"];
					
					
					if($observer != null)
					{
						$observer->$function($note);
					}
					else
					{
						$function($node);
					}
				}
			}
		}
		
		
		/**
		 */
		
		public function registerObserver($type,$callback,$observer = null)
		{
			
			
			if(!is_array($this->observers[$type]))
			{
				$this->observers[$type] = array();
			}
			
			$this->observers[$type][] = array("object"=>$observer,"function"=>$callback); 
		}
		
		/**
		 */
		
		public function removeObserver($type,$callback,$observer = null)
		{
			for($i = 0; $i < count($this->observers[$type]); $i++)
			{
				if($this->observers[$type][$i]["object"] == $observer && $this->observers[$type][$i]["function"] == $callback)
				{
					unset($this->observers[$type][$i]);
					break;
				}
			}
		
		}
	}


?>