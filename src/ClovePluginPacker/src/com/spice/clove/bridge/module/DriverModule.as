package com.spice.clove.bridge.module
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	
	public class DriverModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DriverModule(ns:String)
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("driver",setDriver);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		
		
		override public function get moduleType():Array
		{
			return [ModuleType.NODE_NAME];
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function setDriver():void
		{
			var node:BridgeNode = this.evaluatedNode;
			
			node.pause();
			
			var sc:BridgeNode = new BridgeNode();
			sc.nodeLibrary = node.rootNode.nodeLibrary;
			
			sc.parseXML(node.firstChild.toString());
			sc.restart();
			
			var script:String = sc.toStringFlatten();
			
			
			//for some reason the script returns the flattened script with decimal characters
			script = script.replace(/&#(.*?);/isg,replaceDec);
			script = script.split("[").join("{").split("]").join("}");
			
			node.rootNode.addVariable(node.attributes.id,script);
		}
		
		/**
		 */
		
		private function replaceDec(...params:Array):Object
		{
			return String.fromCharCode(params[1]);
		}
		
		

	}
}