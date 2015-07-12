<?php

	//require_once(dirname(__FILE__).'../../eval/ast/ExpressionTree.class.php');
	
	require_once(dirname(__FILE__).'/../XMLNode.class.php');
	require_once(dirname(__FILE__).'/../../patterns/observer/Notification.class.php');
	
	class NodeTagOpenExpression extends ExpressionTree
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		
		private $node;
		private $nodeName;
		private $attributes;
		private $children;
		
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
			
			$this->attributes = array();
			$this->children   = array();
		
			
			$this->registerObserver(Notification::ADDED,$this,'onAdded');
			
			
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
			$this->node->nodeName = $this->nodeName->evaluate();
			
			
			//$attrs = $this->node->getAttributes();
			
			foreach($this->attributes as $key => $value)
			{
				$this->node->attributes[$key] = $value->evaluate();
				
			}
			
			//$chld =& $this->node->getChildren();
			
			
			foreach($this->children as $key => $value)
			{
				//$chld[] = $value->evaluate();
				$this->node->insertEnd($value->evaluate());
				
			
			}
			
			
			
		//	echo count($this->node->children);
			
			//echo count($chld).$this->nodeName->getBuffer();
			
			
			return $this->node;
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		
		
		protected function onAdded($event = null)
		{
			$this->removeObserver(Notification::ADDED,$this,'onAdded');
			
			
			$nodeClass = $this->getRoot()->nodeClass;
			$this->node = new $nodeClass();
			
			$this->nodeName = $child = $this->getScanner()->nextLexeme($this->getSymbolTable());
			
			
			
			while($child != null)
			{
				
			//	echo $child->getBuffer()."<BR>";
				
				
				/*if($child is GroupExpression && GroupExpression(child).buffer == ")")
				{
					break;
				}*/
				
				$this->insertEnd($child);
				
				if(is_a($child,'EqualsExpression'))
				{
				//	echo $child->getLeft()->getBuffer();
					
				//	echo $child->getLeft()->getBuffer()." "
					$this->attributes[$child->getLeft()->getBuffer()] = $child;
					
				
				}
				else
				if(is_a($child,'NodeTagCloseExpression'))
				{
					
					
					//if the closing tag has a node name then check if name matches
					//if the name does not match then throw an exception
					
					
					if($child->hasNodeName())
					{
						
					//	echo $child->getNodeName()." ".$this->nodeName->getBuffer();
						
						if($child->getNodeName() != $this->nodeName->getBuffer())
						{
							
							trigger_error("Node ".$this->nodeName->getBuffer()." does not have a closing tag.", E_NOTICE);
							
						}
					}
					
					if($child->getBuffer() != ">")
					{
						break;
					}
				}
				else
				if(is_a($child,'NodeTagOpenExpression')  || 
				   is_a($child,'CdataTagOpenExpression') || 
				   is_a($child,'NodeStringExpression'))
				{
					
					$this->children[] = $child;	
				}
				
				
				
				
			
				$child = $this->getScanner()->nextLexeme($this->getSymbolTable());
				
			
				
			}
			
			
		}
		
		
		
		
		
		
	}
	
	
	
	function NodeTagOpenExpression_test($scanner)
	{
		
		$char = $scanner->nextChar();
		
		$notEnd = $char.$scanner->nextChar();
		
		//echo $char;
	
		if($char == "<" && $notEnd != "</" && $notEnd != "<!")
		{
			$scanner->setPos($scanner->getPos()-1);
		
			return $char;
		}
		
		return null;
		
	}


?>