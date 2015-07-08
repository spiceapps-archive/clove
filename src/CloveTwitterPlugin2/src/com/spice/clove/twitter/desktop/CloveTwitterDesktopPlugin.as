package com.spice.clove.twitter.desktop
{
	import com.architectd.service.oauth.OAuthDesktopLoginHelper;
	import com.spice.clove.root.core.calls.CallRootPluginType;
	import com.spice.clove.twitter.desktop.views.footer.FXShareAppButton;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;

	public class CloveTwitterDesktopPlugin extends TwitterPlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveTwitterDesktopPlugin(factory:CloveTwitterDesktopPluginFactory)
		{
			super(new OAuthDesktopLoginHelper(),factory);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
		
			var button:FXShareAppButton = new FXShareAppButton();
			button.plugin = this;
			
			ProxyCallUtils.quickCall(CallRootPluginType.ROOT_PLUGIN_ADD_FOOTER_BUTTON,this.getPluginMediator(),button);
		}
		
	}
}