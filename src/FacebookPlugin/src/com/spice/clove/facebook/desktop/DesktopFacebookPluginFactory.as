package com.spice.clove.facebook.desktop
{
	import com.spice.clove.facebook.desktop.views.installer.FacebookInstaller;
	import com.spice.clove.facebook.impl.FacebookPlugin;
	import com.spice.clove.facebook.impl.FacebookPluginFactory;
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class DesktopFacebookPluginFactory extends FacebookPluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DesktopFacebookPluginFactory()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		override protected function getNewPluginInstaller(plugin:IPlugin):IClovePluginInstaller
		{
			return new FacebookInstaller(FacebookPlugin(plugin));
		}
	}
}