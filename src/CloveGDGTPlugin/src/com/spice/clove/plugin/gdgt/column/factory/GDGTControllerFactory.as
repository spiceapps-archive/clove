package com.spice.clove.plugin.gdgt.column.factory
{
	import com.spice.clove.plugin.column.control.ColumnControllerFactory;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.gdgt.column.controls.GDGTFeedColumnController;
	
	public class GDGTControllerFactory extends ColumnControllerFactory
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		
		public var feed:String;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function GDGTControllerFactory(name:String,controller:IPluginController,feed:String)
		{
			super(name,controller,GDGTFeedColumnController);
			
			this.feed = feed;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function newInstance():*
		{
			var instance:GDGTFeedColumnController = super.newInstance();
			
			instance.feed = this.feed;
			
			return instance;
		}

	}
}