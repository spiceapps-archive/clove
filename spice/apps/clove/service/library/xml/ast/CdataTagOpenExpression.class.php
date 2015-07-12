<?php

	require_once(dirname(__FILE__).'/../XMLNode.class.php');
	require_once(dirname(__FILE__).'/../../patterns/observer/Notification.class.php');

	class CdataTagOpenExpression extends ExpressionTreeNode
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        public $node;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function __construct($buffer,$scanner,$table)
		{
			parent::__construct($buffer,$scanner,$table);
			
			$this->node = new XMLNode();
			
			
			$this->registerObserver(Notification::ADDED,$this,'onAdded');
			
			//$this->init();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function evaluate()
		{
		   // $this->node->nodeValue = $this->getBuffer();
			
			
			return $this->node;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		protected function onAdded($event)
		{
			
			$this->removeObserver(Notification::ADDED,$this,'onAdded');
			
			$buffer = $this->getBuffer();
			
		
			
			while(!strpos($buffer,"]]>"))
			{   
				
				$buffer .= $this->getScanner()->nextChar();
			}
			
		   
			$this->setBuffer($buffer);
			
			
		    $this->node->nodeValue = preg_replace("/<\!\[CDATA\[(.*?)\]\]>/is","$1",$buffer);
			
			$this->node->hasCDATA = true;
		}
	}
	
	
	function CdataTagOpenExpression_test($scan)
	{
		$char = $scan->getString(9);
		
		if($char == "<![CDATA[")
		{
			return $char;
		}
		
		
		
		
		return null;
	}


?>