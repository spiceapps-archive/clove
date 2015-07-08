package com.spice.clove.gdgt.impl
{
	import com.spice.clove.gdgt.impl.content.attachment.GDGTAttachmentFactory;
	import com.spice.clove.gdgt.impl.content.control.GDGTContentControllerFactory;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class GDGTPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _attachmentFactory:GDGTAttachmentFactory;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GDGTPlugin(factory:GDGTPluginFactory)
		{
			super("GDGT","com.spice.clove.gdgt.impl",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
			
			
			this.setContentControllerFactory(new GDGTContentControllerFactory(this));
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
				case CallAppCommandType.GET_REGISTERED_DATA_ATTACHENT_FACTORIES: return this.respond(call,this.getAttachmentFactory());
			}
			
			super.answerProxyCall(call);
		}
		
		/**
		 */
		
		public function getAttachmentFactory():GDGTAttachmentFactory
		{
			if(!this._attachmentFactory)
			{  
				this._attachmentFactory = new GDGTAttachmentFactory(this);
			}
			
			return this._attachmentFactory;
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
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallAppCommandType.GET_REGISTERED_DATA_ATTACHENT_FACTORIES]);
		}
		
		
	}
}