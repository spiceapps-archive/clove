<?php


	class NodeTagCloseExpression extends ExpressionTreeNode
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private $nodeName;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function __construct($buffer,$scanner,$symbolTable)
		{
			parent::__construct($buffer,$scanner,new SymbolTable());
			
			$this->init();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getNodeName()
		{
			return $this->nodeName;
		}
		
		public function hasNodeName()
		{
			return $this->nodeName != null;
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
			
			if($this->getBuffer() == "</")
			{
				
				$this->nodeName = $this->getScanner()->nextLexeme($this->getSymbolTable())->getBuffer();
				
				$close = $this->getScanner()->nextLexeme($this->getSymbolTable());
				
				
			}
			
			
		}
		
		
		
	}
	
	
	function NodeTagCloseExpression_test($scan)
	{
		$char = $scan->nextChar();
		
		if($char == ">")
		{
			return $char;
		}
		
		$char = $char.$scan->nextChar();
		
	
		
		if($char == "/>")
		{
			return $char;
		}
		else
		if($char == "</")
		{
			return $char;
		}
		
		return null;
	}



?>