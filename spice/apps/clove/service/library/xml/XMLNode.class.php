<?php

	require_once(dirname(__FILE__)."/../util/NamespaceUtil.class.php");
	
	class XMLNode
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
	
		public $attributes;
		public $children;
		public $nodeValue; 
		public $parent;   
		public $hasCDATA;
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private $_nodeName;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function __construct()
		{
			
			$this->attributes = array();
			$this->children   = array();
			$this->nodeName   = null;
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function __get($name)
		{
			if($name == "firstChild")
			{
				return $this->children[0];
			}
			
			if($name == "nodeName")
			{
				return NamespaceUtil::removeNamespaceIfPresent($this->_nodeName);
			}
			
			if($name == "nodeNameAndNamespace")
			{
				return $this->_nodeName;
			}
			
			if($name == "namespace")
			{
				return NamespaceUtil::getNamespace($this->_nodeName);
			}
		}
		
		public function __set($name,$value)
		{
			if($name == "nodeName")
			{
				$this->_nodeName = $value;
			}
		}
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function insertEnd(XMLNode $node)
		{
			$this->children[] = $node;
			$node->parent = $this;
		}
		
		/**
		 */
		
		public function insertBeginning(XMLNode $node)
		{
			
		}
		
		/**
		 */
		
		public function getNode($name)
		{   
			$nodes = array();
			
			foreach($this->children as $child)
			{
				if($child->nodeName == $name)
				{
				    return $child;
				}
			}
			
			return $nodes;
		}
		
		/**
		 */
		
		public function getNextSibling()
		{   
		     

			$children = $this->parent->children;
			                
			
			//FIX ME: make it faster
			for($i = 0; $i < count($children); $i++)
			{
				if($children[$i] == $this)
				{
					$siblingIndex = $i;
					break;
				}
			}   
			
			//next sibl;ing doesn't exist
			if(!array_key_exists($siblingIndex+1,$this->parent->children))
				return FALSE;

			return $this->parent->children[$siblingIndex+1];
		}
		
		
		
		
		/**
		 */
		
		public function hasChildNodes()
		{
			return (bool)count($this->children) > 0;
		}
		
		
		
		/**
		 * prints the this xml node
		 */
		
		public function __tostring()
		{
			return $this->getNodeString($this);
		}
		
		/**
		 */
		
		public function getNodeString($node,$tab="")
		{    
			if($node->nodeName == null)
			{    
				//add the CDATA is it exists
				
				$data = $node->nodeValue;
				
				if($node->hasCDATA)
				{
					$data =  "<![CDATA[".$data."]]>\n";
				}
				
				return "$data\n"; 
				
				
			}
			
			if($node->hasChildNodes())
			{
			
				return $tab.$this->getNodeStringChildren($node);
			}
			else
			{
				return $tab.$this->getNodeStringNoChildren($node);
			}
		}
		
		/**
		 */
		
		public function getNodeStringNoChildren($node)
		{
		
			return $this->getNodeProperties($node)." />\n";
			
			
		}
		
		/**
		 */
		
		public function getNodeStringChildren($node)
		{
		
			$init = $this->getNodeProperties($node).">\n";
			
			
			
			foreach($node->children as $key => $child)
			{
				$init .= $this->getNodeString($child,"\t");
				
			}
			
			$init .= "</".$node->nodeName.">\n";
			
			return $init;
		}
		
		/**
		 */
		
		public function getNodeProperties($node)
		{
			$init = "<".$node->nodeName." ";
			//echo $node->nodeName;
			
			
			foreach($node->attributes as $key => $value)
			{
				$init .= $key."=\"".$value."\" ";
			}
			
			//echo "GOGO".$init.$node->nodeName;
			
			return $init;
		}
		
	}
	
	
?>