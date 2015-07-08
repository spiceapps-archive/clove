package com.spice.clove.plugin.bestBuy
{
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.PluginFactoryMetadataType;
	import com.spice.clove.plugin.bestBuy.install.BestBuyServiceInstaller;
	import com.spice.clove.plugin.install.IServiceInstaller;
	
	
	[Bindable] 
	public class CloveBestBuyPluginFactory extends PluginFactory implements IPluginFactory
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public var installer:IServiceInstaller = new BestBuyServiceInstaller();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveBestBuyPluginFactory()
		{
			
			var meta:Object = {};
			meta[PluginFactoryMetadataType.NAME] = "Best Buy";
			
			super(meta);
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function newPlugin():IClovePlugin
		{
			return new CloveBestBuyPlugin();
		}
		

	}
}