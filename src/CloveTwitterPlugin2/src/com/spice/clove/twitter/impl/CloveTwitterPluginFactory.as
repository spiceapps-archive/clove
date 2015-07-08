package com.spice.clove.twitter.impl
{
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.twitter.impl.views.assets.TwitterAssets;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class CloveTwitterPluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveTwitterPluginFactory()
		{
			this.setIcon16( TwitterAssets.TWITTER_16_ICON);
			this.setIcon32( TwitterAssets.TWITTER_32_ICON);
			this.setHasUserAccount(true);
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
			return new TwitterPlugin(null,this);
		}
	}
}