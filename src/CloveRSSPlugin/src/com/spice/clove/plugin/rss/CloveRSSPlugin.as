package com.spice.clove.plugin.rss
{
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.column.control.ColumnControllerFactory;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.rss.column.control.RSSFeedColumnController;
	import com.spice.clove.plugin.rss.column.control.views.RSSFeedColumnControllerView;
	
	public class CloveRSSPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _settings:CloveRSSPluginSettings;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CloveRSSPlugin()
		{
			_settings = new CloveRSSPluginSettings();
			
			super(_settings);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		[Bindable(event="settingsChange")]
		public function get settings():CloveRSSPluginSettings
		{
			return this._settings;
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
			
			this.addAvailableColumnController(new ColumnControllerFactory("RSS Feed",controller,RSSFeedColumnController,RSSFeedColumnControllerView));
			
			this.complete();
		}
		
		/*
		 */
		
		public function addFeed(name:String,feed:String):void
		{
			//nothing for now
		}

	}
}