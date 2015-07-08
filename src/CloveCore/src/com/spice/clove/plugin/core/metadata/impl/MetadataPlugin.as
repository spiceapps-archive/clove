package com.spice.clove.plugin.core.metadata.impl
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.metadata.impl.content.data.MetadataItemRenderer;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class MetadataPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _renderer:MetadataItemRenderer;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function MetadataPlugin(factory:MetadataPluginFactory)
		{
			super("Metadata","com.spice.clove.core.metadata",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
		}
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallAppCommandType.GET_REGISTERED_CLOVE_DATA_RENDERERS: return this.respond(call,this.getMetadataRenderer());
			}
			
			return super.answerProxyCall(call);
		}
		
		
		/**
		 */
		
		public function getMetadataRenderer():MetadataItemRenderer
		{
			if(!_renderer)
			{
				this._renderer = new MetadataItemRenderer(this.getPluginMediator());
			}
			
			return this._renderer;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		override protected function initialize():void
		{
			super.initialize();
			this.finishInitialization();
		}
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallAppCommandType.GET_REGISTERED_CLOVE_DATA_RENDERERS]);
		}

	}
}