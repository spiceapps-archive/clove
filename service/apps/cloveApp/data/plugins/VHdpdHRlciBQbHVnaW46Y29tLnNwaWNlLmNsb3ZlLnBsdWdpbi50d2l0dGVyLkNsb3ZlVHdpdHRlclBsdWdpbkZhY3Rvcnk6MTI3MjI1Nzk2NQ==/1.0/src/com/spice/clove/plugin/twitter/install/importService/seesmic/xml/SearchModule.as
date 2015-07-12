package com.spice.clove.plugin.twitter.install.importService.seesmic.xml
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	
	public class SearchModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var searchTerms:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function SearchModule()
		{
			
			this.nodeEvaluator.addHandler("savedSearch",this.addSearchStack);
			
			this.searchTerms = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
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
        
        /*
		 */
		
		private function addSearchStack():void
		{
			this.evaluatedNode.pause();
			
			for each(var child:BridgeNode in this.evaluatedNode.childNodes)
			{
				searchTerms.push(child.firstChild.nodeValue);
			}
		}

	}
}