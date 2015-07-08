package com.spice.clove.plugin.gdgt
{
	import com.spice.clove.events.ApplicationEvent;
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.gdgt.column.factory.GDGTControllerFactory;
	
	public class CloveGDGTPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CloveGDGTPlugin()
		{
			super(new CloveGDGTPluginSettings());
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function initialize(controller:IPluginController):void
		{
			super.initialize(controller);
			
			var feed:String = "http://www.dapper.net/transform.php?dappName=GDGTuserpage&transformer=Atom&extraArg_title=products&extraArg_content[]=products&extraArg_extendedFields=1&applyToUrl=http%3A%2F%2Fuser.gdgt.com%2Farchitectd%2F";
			
			this.addAvailableColumnController(new GDGTControllerFactory("Latest Products",controller,feed));
			
			this.complete();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		override protected function onApplicationInitialized(event:ApplicationEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onApplicationInitialized);
			
			
//			new GetAdditionalInfoCall("macbook pro").dispatch();
		}

	}
}