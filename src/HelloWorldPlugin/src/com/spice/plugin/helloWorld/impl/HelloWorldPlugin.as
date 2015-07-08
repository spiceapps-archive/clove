package com.spice.plugin.helloWorld.impl
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class HelloWorldPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function HelloWorldPlugin(factory:ClovePluginFactory)
		{
			super("Hello World","com.spice.clove.plugin.helloWorld",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
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
			new ProxyCall(CallAppCommandType.SHOW_ALERT,this.getPluginMediator(),"hello world!").dispatch().dispose();
		}
	}
}