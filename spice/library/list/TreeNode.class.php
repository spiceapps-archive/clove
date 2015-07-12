<?php
	
	
	require_once(dirname(__FILE__).'/LinkedNode.class.php');
	
	class TreeNode extends LinkedNode 
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private variables
        //
        //--------------------------------------------------------------------------
        
        private $_parent; 
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructror
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
		 
        public function setParent($value)
		{
			$this->_parent = $value;
		
			
			if($value != null)
			{
//				$this->notifyObservers(new Notification(Notification::ADDED));
			}
			else
			if($this->_parent != null)
			{
//				$this->notifyObservers(new Notification(Notification::REMOVED));
			}
		}
		
		public function getParent()
		{
			return $this->_parent;
		}
		
		
		/**
		 */
		
		public function getRoot()
		{
			$parent = $this;
			
			
			while($parent->getParent())
			{
				$parent = $parent->getParent();
			}
			
			return $parent;
		}
    
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------	
    
		/**
		 */
		
		public function delink()
		{
			
			
			//if the parent is not null then we use the remove method since the parent
			//has reference to this node firstNode and lastNode - they need to be
			//dereferenced
			if($this->getParent() != null)
				$this->getParent()->remove($this);
				
			//if the parent does not exist then we can super delink this object so all
			//siblings have no reference to this
			else
			{
				parent::delink();
				
				//finally destroy the parent if it exists
				$this->setParent(null);
			}
			
		}
		
		/**
		 */
		
		public function trade($newNode)
		{
			

			//if the parent is present then we need to also dereference
			//firstNode and last node
			
			//trace(parent,newNode);

			if($this->getParent() != null)
			{

				$this->getParent()->insertAfter($this,$newNode);

				$this->getParent()->remove($this);
				
				
				//trace(parent.firstNode);

			}
			
			//if the parent is not present then
			else
			{
				parent::trade($newNode);
				$newNode->setParent($parent);
			}
				
			
			//swap the parents
			
			
			
		}


	}


?>