package com.spice.clove.bing.impl
{
	import com.spice.clove.bing.impl.content.control.BingContentControllerFactory;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.impl.queue.Queue;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class BingPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _queue:Queue;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BingPlugin(factory:BingPluginFactory)
		{
			super("Bing","com.spice.clove.plugin.bing",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
			
			
			this.setContentControllerFactory(new BingContentControllerFactory(this));
			
			
			
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
				this._queue = new Queue();
				this._queue.start();
			}
			
			return this._queue;
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