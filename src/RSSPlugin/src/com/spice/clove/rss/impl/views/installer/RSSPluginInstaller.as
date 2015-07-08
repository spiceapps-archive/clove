package com.spice.clove.rss.impl.views.installer
{
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.install.IClovePluginInstallerViewController;
	import com.spice.clove.plugin.impl.install.ClovePluginInstaller;
	import com.spice.clove.rss.impl.RSSPlugin;

	public class RSSPluginInstaller extends ClovePluginInstaller implements IClovePluginInstallerViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RSSPluginInstaller(plugin:RSSPlugin)
		{
			super(plugin,this);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setView(value:ICloveViewTarget):void
		{
			this.notifyCompletion();
		}
		
		
	}
}