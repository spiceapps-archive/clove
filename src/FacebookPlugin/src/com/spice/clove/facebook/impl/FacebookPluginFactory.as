package com.spice.clove.facebook.impl
{
	import com.spice.clove.facebook.impl.views.assets.FacebookAssets;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class FacebookPluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookPluginFactory()
		{
			this.setIcon16(FacebookAssets.FACEBOOK_16);
			this.setIcon32(FacebookAssets.FACEBOOK_32);
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
			return new FacebookPlugin(this);
		}
	}
}