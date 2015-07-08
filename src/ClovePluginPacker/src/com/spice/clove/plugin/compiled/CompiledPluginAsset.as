package com.spice.clove.plugin.compiled
{
	import flash.utils.ByteArray;
	
	
	
	[Bindable] 
	[RemoteClass(alias='CompiledPluginAsset')]
	public class CompiledPluginAsset
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public var isSource:Boolean;
        public var data:ByteArray;
        public var name:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CompiledPluginAsset(name:String = null,
									 bytes:ByteArray = null,
									 isSource:Boolean = false)
		{
			this.name = name;
			this.data = bytes;
			this.isSource = isSource;
		}

	}
}