package com.spice.clove.rss.impl.content.control
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;
	import com.spice.clove.rss.impl.RSSPlugin;

	public class RSSContentControllerFactory extends CloveContentControllerFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:RSSPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RSSContentControllerFactory(plugin:RSSPlugin)
		{
			var available:Vector.<String> = new Vector.<String>(1,true);
			available[0] = RSSContentControllerType.RSS_FEED;
			
			_plugin = plugin;
			
			super(available);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getNewContentController(name:String):ICloveContentController
		{
			switch(name)
			{
				case RSSContentControllerType.RSS_FEED: return new RSSFeedContentController(name,this._plugin,this._plugin.getQueue());
			}
			
			return super.getNewContentController(name);
		}
	}
}