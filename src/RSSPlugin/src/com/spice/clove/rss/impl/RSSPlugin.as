package com.spice.clove.rss.impl
{
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.rss.impl.content.control.RSSContentControllerFactory;
	import com.spice.clove.rss.impl.settings.RSSPluginSettings;
	import com.spice.impl.queue.Queue;

	public class RSSPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _settings:RSSPluginSettings;
		private var _queue:Queue;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RSSPlugin(factory:RSSPluginFactory)
		{
			super("RSS","com.spice.clove.rss",(_settings = new RSSPluginSettings()),factory);
			
			
			this.setContentControllerFactory(new RSSContentControllerFactory(this));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getQueue():Queue
		{
			if(!_queue)
			{
				_queue = new Queue();
				_queue.start();
			}
			
			return _queue;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.finishInitialization();
		}
		
	}
}