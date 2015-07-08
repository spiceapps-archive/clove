package com.spice.clove.twitter.desktop.views.installer
{
	import com.spice.clove.plugin.core.calls.CallCloveOAuthType;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.impl.install.ClovePluginInstaller;
	import com.spice.clove.plugin.impl.views.install.RegisteredPluginInstallerViewController;
	import com.spice.clove.twitter.desktop.CloveTwitterDesktopPluginFactory;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.clove.twitter.impl.views.oauth.CloveTwitterOAuthViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;

	public class CloveTwitterDesktopPluginInstaller extends ClovePluginInstaller
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		// 
		//--------------------------------------------------------------------------
		
		private var _pin:String;
		private var _plugin:TwitterPlugin;
		//private var _pin:StringSetting = new StringSetting("pin");
		private var _oauth:CloveTwitterOAuthViewController;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveTwitterDesktopPluginInstaller(plugin:TwitterPlugin,mediator:IProxyMediator,factory:ClovePluginFactory)
		{
			_plugin = plugin
			
			var oauthController:CloveTwitterOAuthViewController = new CloveTwitterOAuthViewController(factory);
			oauthController.getProxy().bindObserver(new CallbackObserver(CallCloveOAuthType.GET_ACCESS_TOKEN,onGetAccessToken));
			
			super(plugin,new RegisteredPluginInstallerViewController( CallRegisteredViewType.GET_NEW_REGISTERED_OAUTH_VIEW_CONTROLLER,mediator,this,oauthController));
		
			
//			super(new Regis
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onGetAccessToken(target:CallbackObserver,n:INotification):void
		{
			n.getTarget().removeObserver(target);
			   
			var account:TwitterPluginAccount = TwitterPluginAccount(this._plugin.addAcount());
			account.getTwitterSettings().getAccessToken().setData(n.getData());
			account.connection.verifyLogin();
			this.notifyCompletion();
		}
		
		
		
	}
}