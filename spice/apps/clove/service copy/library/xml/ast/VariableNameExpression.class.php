<?php

	//require_once(dirname(__FILE__).'../../eval/ast/ExpressionTree.class.php');

	
	class VariableNameExpression extends ExpressionTreeNode
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

		}
		
		
		
		
	}
	
	
	function VariableNameExpression_test($scanner)
	{
		
		$char = $scanner->nextChar();
		$prev = null;
		
		
		$validName = '/^[a-zA-Z0-9:]+$/';
		
		$match = array();
		
		preg_match($validName,$char,$match);
		
		
		while(preg_match($validName,$char,$match) && $scanner->hasNext())
		{
			$prev = $char;
			$char = $char.$scanner->nextChar();
			
		}
		if($prev)
		{
			$scanner->setPos($scanner->getPos()-1);
		}
		
		
		
		return $prev;
		
	}


?>