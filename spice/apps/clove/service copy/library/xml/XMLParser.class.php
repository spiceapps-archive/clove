<?php

	require_once(dirname(__FILE__)."/../eval/Parser.class.php");
	
	require_once(dirname(__FILE__).'/../eval/ast/EqualsExpression.class.php');
	require_once(dirname(__FILE__).'/../eval/ast/StringExpression.class.php');
	
	
	$list = scandir(dirname(__FILE__).'/ast/');
	
	foreach($list as $key => $file)
	{
		if($file == "." || $file == "..")
			continue;
			
		require_once(dirname(__FILE__).'/ast/'.$file);
		
		
	}

	
	
	class XMLParser extends Parser
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		
		public $nodeClass;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function __construct($nodeClass = 'XMLNode')
		{
			parent::__construct();
			
			//the node class every lexeme calls when instantiating a new instance of a node
			$this->nodeClass = $nodeClass;
			
			//handles strings that are enclosed in nodes >DATA<
			$this->addLexemeHandler('NodeStringExpression');
			
			//handles cdata information
			$this->addLexemeHandler('CdataTagOpenExpression');
			
			//handles comments
			$this->addLexemeHandler('CommentTagExpression');
			
			//handles strings enclosed in ' or "
			$this->addLexemeHandler('StringExpression');
			
			//handles node tags, attributes, and child nodes
			$this->addLexemeHandler('NodeTagOpenExpression');
			
			//handles closing tags > /> and </...>
			$this->addLexemeHandler('NodeTagCloseExpression');
			
			//handles attribute names and node names
			$this->addLexemeHandler('VariableNameExpression');
			
			//handles assignment between attribute name and its value
			$this->addLexemeHandler('EqualsExpression');
			
			
		
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function parseXML($value)
		{
			
			$this->compile($value);
			return $this->evaluate();
			
			
		}
		
		/**
		 */
		
		public function toString()
		{
			return $this->evaluate();
		}
	}
	

?>