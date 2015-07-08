package com.spice.clove.vo
{
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.net.FileReference;
	
	
	[Bindable] 
	public class PluginVO
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


		public var name:String;
        public var uploadProgess:int;
        public var reference:FileReference;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PluginVO(ref:FileReference)
		{
			this.reference = ref;
			this.name = ref.name;
		}
		
		
		
		

	}
}