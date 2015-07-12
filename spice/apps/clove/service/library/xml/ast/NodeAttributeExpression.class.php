<?php

	//require_once(dirname(__FILE__).'../../eval/ast/ExpressionTree.class.php');

	
	class NodeAttributeExpression extends ExpressionTree
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function __construct($buffer,$scanner,$symbolTable)
		{
			parent::__construct($buffer,$scanner,$symbolTable);
			
			
			$this->init();
			
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
			
		}
		
		
		
		
		
		
	}
	
	
	
	function NodeAttributeExpression_test($scanner)
	{
		
	}


?>