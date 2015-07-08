package com.spice.clove.plugin.youtube.impl
{
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.youtube.impl.assets.YoutubeAssets;
	import com.spice.clove.plugin.youtube.impl.installer.CloveYoutubePluginInstaller;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class CloveYoutubePluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveYoutubePluginFactory()
		{
			this.setIcon16(YoutubeAssets.YOUTUBE_16_ICON);
			this.setIcon32(YoutubeAssets.YOUTUBE_32_ICON);
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
			return new CloveYoutubePlugin(this);
		}
		
		/**
		 */
		
		override protected function getNewPluginInstaller(plugin:IPlugin):IClovePluginInstaller
		{
			return new CloveYoutubePluginInstaller(plugin);
		}
	}
}