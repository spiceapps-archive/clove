package com.spice.clove.fantasyVictory.impl
{
	import com.spice.clove.fantasyVictory.impl.content.control.FantasyVictoryContentControllerFactory;
	import com.spice.clove.fantasyVictory.impl.service.FantasyVictoryService;
	import com.spice.clove.fantasyVictory.impl.views.FantasyFootballButton;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.root.core.calls.CallRootPluginType;
	import com.spice.impl.queue.Queue;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class FantasyVictoryPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _queue:Queue;
		private var _service:FantasyVictoryService;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FantasyVictoryPlugin(factory:FantasyVictoryPluginFactory)
		{
			super("Fantasy Victory","com.spice.clove.fantasyVictory",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
			
			this.setContentControllerFactory(new FantasyVictoryContentControllerFactory(this));
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
		
		/**
		 */
		
		public function getService():FantasyVictoryService
		{
			if(!_service)
			{
				_service = new FantasyVictoryService();
			}
			return this._service;
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
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			var button:FantasyFootballButton = new FantasyFootballButton();
			button.plugin = this;
			
			ProxyCallUtils.quickCall(CallRootPluginType.ROOT_PLUGIN_ADD_FOOTER_BUTTON,this.getPluginMediator(),button);
		}
		
	}
}