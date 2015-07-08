package com.spice.clove.fantasySports.impl
{
	import com.spice.clove.brand.impl.BrandPlugin;
	import com.spice.clove.fantasySports.impl.views.assets.FantasySportsAssets;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class FantasySportsPlugin extends BrandPlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FantasySportsPlugin(factory:FantasySportsPluginFactory)
		{
			super("Fantasy Sports","com.spice.clove.fantasySports","fantasySports",factory);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getBrandHeader():Class
		{
			return FantasySportsAssets.LEAGUE_SAFE_HEADER;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			
			
			
		}
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			
			
		}
		
	}
}