package com.spice.clove.nectars.impl
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.nectars.impl.content.control.render.NectarsDataRenderer;
	import com.spice.clove.nectars.impl.data.attachment.NectarsDataAttachmentFactory;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class CloveNectarsPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _longUrlDataRenderer:ICloveDataRenderer;
		private var _longUrlAttachmentFactory:NectarsDataAttachmentFactory;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveNectarsPlugin(factory:CloveNectarsPluginFactory)
		{
			super("Url Expander","com.spice.clove.nectars",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
			
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
				case CallAppCommandType.GET_REGISTERED_CLOVE_DATA_RENDERERS: return this.respond(call,this.getLongUrlDataRenderer());
				case CallAppCommandType.GET_REGISTERED_DATA_ATTACHENT_FACTORIES: return this.respond(call,this.getLongUrlAttachmentFactory());
			}
			
			super.answerProxyCall(call);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			
			
			
			//this 
			this.finishInitialization();
		}
		
		/**
		 */
		
		protected function getLongUrlDataRenderer():ICloveDataRenderer
		{
			if(!_longUrlDataRenderer)
			{
				this._longUrlDataRenderer = new NectarsDataRenderer(this.getLongUrlAttachmentFactory());  
			}
			
			return this._longUrlDataRenderer; 
		}
		
		
		/**
		 */
		
		protected function getLongUrlAttachmentFactory():NectarsDataAttachmentFactory
		{
			if(!_longUrlAttachmentFactory)
			{
				this._longUrlAttachmentFactory = new NectarsDataAttachmentFactory(this.getPluginMediator());
			}
			
			
			return this._longUrlAttachmentFactory;
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			
			this.addAvailableCalls([CallAppCommandType.GET_REGISTERED_CLOVE_DATA_RENDERERS,
									CallAppCommandType.GET_REGISTERED_DATA_ATTACHENT_FACTORIES]);
		}
	}
}