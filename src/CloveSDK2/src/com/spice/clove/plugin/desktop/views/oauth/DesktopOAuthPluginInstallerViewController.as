package com.spice.clove.plugin.desktop.views.oauth
{
	import com.spice.clove.plugin.core.calls.CallCloveOAuthType;
	import com.spice.clove.plugin.core.views.oauth.IOAuthViewController;
	import com.spice.clove.plugin.flash.views.install.FLPluginInstallerViewController;
	import com.spice.clove.plugin.impl.views.content.oauth.OAuthViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyPassThrough;

	public class DesktopOAuthPluginInstallerViewController extends FLPluginInstallerViewController implements IOAuthViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _viewController:IOAuthViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DesktopOAuthPluginInstallerViewController(controller:IOAuthViewController)
		{
			super(DesktopOAuthHTMLView);
			
			_viewController = controller;
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
			
			new ProxyPassThrough(this._viewController.getProxy(),this.getProxyController());
			
		}
	}
}