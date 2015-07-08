package com.spice.clove.plugin.core.attachment.impl
{
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class PostMenuOptionsPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function PostMenuOptionsPlugin(factory:PostMenuOptionsPluginFactory)
		{
			super("Attachments Plugin","com.spice.clove.plugin.core.attachment",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
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
			
//			new Regist
			
			this.finishInitialization();
		}
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
		}
	}
}