<?php


	class LinkedNode
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private $_nextSibling;
        private $_previousSibling;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function __construct()
		{
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		/**
		 */
		
		public function setPreviousSibling($value)
		{
			$this->_previousSibling = $value;
		}
		
		public function getPreviousSibling()
		{
			return $this->_previousSibling;
		}
		
		/**
		 */
		
		public function setNextSibling($value)
		{
			$this->_nextSibling = $value;
		}
		
		public function getNextSibling()
		{
			return $this->_nextSibling;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * delinks the node from the list and joins the previous
         * and next node together to fill in the gap
		 */
		
		public function delink()
		{
			
			//if the node is not at the beginning
			if($this->_previousSibling != null)
			{
				$this->_previousSibling->setNextSibling($this->_nextSibling);
			}
			
			//if the node is not at the end
			if($this->_nextSibling != null)
			{
				$this->_nextSibling->setPreviousSibling($this->_previousSibling);
			}

		}
		
		/**
		 * swaps this linked node with a new linked node - this executes
		 * a delink on both sides
		 */
		 
		 public function trade($newNode)
		 {
		 	$newNode->setPreviousSibling($this->_previousSibling);
		 	
		 	if($this->_previousSibling != null)
		 	{
		 		$this->_previousSibling->setNextSibling($newNode);
		 	}
		 	
		 	
		 	$newNode->setNextSibling($this->_nextSibling);
		 	
		 	if($_nextSibling != null)
		 	{
		 		$this->_nextSibling->setPreviousSibling($newNode);
		 	}

		 	$newNode->trade($this);
		 	
		 }
		 
		
		
		
	}


?>