<?php

	require_once(dirname(__FILE__)."/TreeNode.class.php");
	
	class Tree extends TreeNode
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private $_lastNode;
        private $_firstNode;
		private $_currentNode;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function __construct()
		{
			parent::__construct();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setFirstNode($newNode)
		{
			$this->_firstNode = $newNode;
		}
		
		public function getFirstNode()
		{
			return $this->_firstNode;
		}
		
		/**
		 */
		
		public function setLastNode($newNode)
		{
			$this->_lastNode = $newNode;
		}
		
		public function getLastNode()
		{
			return $this->_lastNode;
		}
		
	   
		
		/**
		 */
		
		public function getNextNode()
		{   
			if($this->_currentNode == $this->getLastNode())
				return null;
				
			if(!$this->_currentNode)
				return $this->_currentNode = $this->getFirstNode();
			else
				return $this->_currentNode = $this->_currentNode->getNextSibling();
			
			
		}
		
		/**
		 */
		
		public function getPreviousNode()
		{
			if(!$this->_currentNode)
				return null;
			
			return $this->_currentNode = $this->_currentNode->getPreviousSibling();
		} 
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function evaluate2()
		{
			
			$child  = $this->getFirstNode();
		
			$result = null;
			
			while($child)
			{
			
				$result = $child->evaluate();
				
				
				$child = $child->getNextSibling();
				
				
			}
			
			
			
			return $result;
		
		}

		
		/**
		 */
		
		public function insertAfter($afNode,$newNode)
		{
			
			$newNode->delink();

			
			//this would result in an infinite loop
			if($afNode->getNextSibling() == $newNode)
				return;
			
			
			
			$newNode->setPreviousSibling($afNode);
			$newNode->setNextSibling($afNode->getNextSibling());
			
			
			

			if($afNode->getNextSibling() == null)
			{
				$this->setLastNode($newNode);
			}
			else
			{
				$afNode->getNextSibling()->setPreviousSibling($newNode);
			}
			
			
			$afNode->setNextSibling($newNode);
			$newNode->setParent($this);
			
			
		}
		
		/**
		 */
		
		public function insertBefore($bfNode,$newNode)
		{
			
			$newNode->delink();
			
			
			//this would result in an infinite loop
			if($bfNode->getPreviousSibling() == $newNode)
				return;
			
			
			$newNode->setPreviousSibling($bfNode->getPreviousSibling());
			$newNode->setNextSibling($bfNode);
			
			if($bfNode->getPreviousSibling() == null)
			{
			
				$this->setFirstNode($newNode);
			}
			else
			{
				$bfNode->getPreviousSibling()->setNextSibling($newNode);
			}
			
			$bfNode->setPreviousSibling($newNode);
			$newNode->setParent($this);
			

			
		}
		
		/**
		 */
		
		public function insertBeginning($newNode)
		{
		
			
			//if($newNode != null)
				$newNode->delink();
				
			if($this->getFirstNode() == null)
			{
				$this->setFirstNode($newNode);
				$this->setLastNode($newNode);
				
				$newNode->setPreviousSibling(null);
				$newNode->setNextSibling(null);
				
				
			}
			else
			{
				$this->insertBefore($this->getFirstNode(),$newNode);
			}
			
			//$newNode->symbolTable = symbolTable;
			
			$newNode->setParent($this);
			
		}
		
		/**
		 */
		
		public function insertEnd($newNode)
		{

			if($this->getLastNode() == null)
			{
				$this->insertBeginning($newNode);
			}
			else
			{
				$this->insertAfter($this->getLastNode(),$newNode);
			}
		}
		
		/**
		 */
		
		public function remove($node)
		{
			
			
			if($node->getPreviousSibling() == null)
			{
				$this->setFirstNode($node->getNextSibling());
			}
			else
			{
				
				$node->getPreviousSibling()->setNextSibling($node->getNextSibling());
			}
			
			
			if($node->getNextSibling() == null)
			{
				$this->setLastNode($node->getPreviousSibling());
			}
			else
			{
				$node->getNextSibling()->setPreviousSibling($node->getPreviousSibling());
			}
			
			
			$node->setParent(null);
			
			
			
		}
		
		
	}
?>