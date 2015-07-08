package com.spice.clove.plugin.impl.install
{
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.calls.CallUserPassInstallerViewControllerType;
	import com.spice.clove.plugin.impl.install.ClovePluginInstaller;
	import com.spice.clove.plugin.impl.views.install.RegisteredPluginInstallerViewController;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	
	public class AbstractUserPassPluginInstaller extends ClovePluginInstaller
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractUserPassPluginInstaller(plugin:IPlugin,mediator:IProxyMediator)
		{
			super(plugin,new RegisteredPluginInstallerViewController(CallRegisteredViewType.GET_NEW_REGISTERED_USER_PASS_INSTALLER_VIEW_CONTROLLER,mediator,this,this));
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
				case CallUserPassInstallerViewControllerType.GET_TITLE: return this.respond(call,this.getTitle());
				case CallUserPassInstallerViewControllerType.SET_USERNAME: return this.setUsername(call.getData());
				case CallUserPassInstallerViewControllerType.SET_PASSWORD: return this.setPassword(call.getData());
					
			}
			
			super.answerProxyCall(call);
		}
		
		
		/**
		 */
		public function getTitle():String
		{
			return null;
		}
		
		/**
		 */
		
		public function setUsername(value:String):void
		{	
		}
		
		
		/**
		 */
		public function setPassword(value:String):void
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallUserPassInstallerViewControllerType.GET_TITLE,
				CallUserPassInstallerViewControllerType.SET_USERNAME,
				CallUserPassInstallerViewControllerType.SET_PASSWORD]);
		}
	}
}