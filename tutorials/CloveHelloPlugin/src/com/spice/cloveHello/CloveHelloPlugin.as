package com.spice.cloveHello
{
	import com.spice.clove.events.ApplicationEvent;
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.column.control.ColumnControllerFactory;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.cloveHello.columns.controller.HelloColumnController;
	
	import mx.controls.Alert;
	
	public class CloveHelloPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _settings:CloveHelloPluginSettings;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CloveHelloPlugin()
		{
			_settings = new CloveHelloPluginSettings();
			
			super(_settings);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get settings():CloveHelloPluginSettings
		{
			return _settings;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function initialize(controller:IPluginController):void
		{
			super.initialize(controller);
			
			
			this.addAvailableColumnController(new ColumnControllerFactory("Hello Column",controller, HelloColumnController,null));
			
			this.complete();
			
		}
		
		/**
		 */
		
		public function testHello():void
		{
			
			
			Alert.show("Hello "+_settings.username,"Hello");
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function onApplicationInitialized(event:ApplicationEvent):void
		{
			this.testHello();
		}
		
		
		

	}
}