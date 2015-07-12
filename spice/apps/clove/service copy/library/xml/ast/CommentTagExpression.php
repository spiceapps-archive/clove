<?php

	
	class CommentTagExpression extends ExpressionTreeNode
	{
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
			
			$this->init();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function init()
		{
			$buffer = $this->getBuffer();
			
			
			while(!strpos($buffer,"-->"))
			{
				$buffer .= $this->getScanner()->nextChar();
			}
			
			$this->setBuffer($buffer);
		}
		
	}
	
	
	function CommentTagExpression_test($scan)
	{
		$char = $scan->getString(4);
		
		if($char == "<!--")
		{
			return $char;
		}
		
		return null;
	}


?>