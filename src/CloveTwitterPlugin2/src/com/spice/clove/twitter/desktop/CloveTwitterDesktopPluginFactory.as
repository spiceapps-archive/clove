package com.spice.clove.twitter.desktop
{
	import com.architectd.service.oauth.OAuthDesktopLoginHelper;
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.twitter.desktop.views.installer.CloveTwitterDesktopPluginInstaller;
	import com.spice.clove.twitter.impl.CloveTwitterPluginFactory;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.views.assets.TwitterAssets;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class CloveTwitterDesktopPluginFactory extends CloveTwitterPluginFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveTwitterDesktopPluginFactory()
		{
			super();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function newPlugin():IPlugin
		{  
			return new CloveTwitterDesktopPlugin(this);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getNewPluginInstaller(plugin:IPlugin):IClovePluginInstaller
		{
			return new CloveTwitterDesktopPluginInstaller(TwitterPlugin(plugin),this.getPluginMediator(),this);
		}
	}
}