<?php

	//require_once(dirname(__FILE__).'../../eval/ast/ExpressionTree.class.php');

	
	class NodeStringExpression extends ExpressionTreeNode
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
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	
		
		
		public function evaluate()
		{
			$nodeClass = $this->getRoot()->nodeClass;
			
			$node = new $nodeClass();
			$node->nodeValue = $this->getBuffer();
			
			return $node;
		}
		
		
		
	}
	
	
	function NodeStringExpression_test($scanner)
	{
		
		if(!$scanner->hasPrevious())
			return;
		
		$lex = $scanner->prevChar();
		
		if($lex != ">")
		{
			return;
		}
		
	
		$scanner->nextChar();$scanner->nextChar();
		
		
		$char = $scanner->nextChar();
		$prev = null;
		
		
		$validName = '/^[^<>=]+$/';
		
		$match = array();
		
		preg_match($validName,$char,$match);
		
		
		while(preg_match($validName,$char,$match) && $scanner->hasNext())
		{
			$prev = $char;
			$char = $char.$scanner->nextChar();
			
		}
		
		//make sure that we're not matching just white space
		if(!preg_match('/[^\n\t\r\s]+/',$prev))
		{
			return null;
		}
		
		
		
		if($prev)
		{
			$scanner->setPos($scanner->getPos()-1);
		}
		
		
		return $prev;
		
	}


?>