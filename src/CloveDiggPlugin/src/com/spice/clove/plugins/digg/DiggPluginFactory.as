package com.spice.clove.plugins.digg
{
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugins.digg.icon.DiggIcons;
	import com.spice.clove.plugins.digg.installer.DiggPluginInstaller;

	public class DiggPluginFactory extends PluginFactory implements IPluginFactory
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		[Bindable]	
		public var installer:IServiceInstaller = new DiggPluginInstaller();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggPluginFactory()
		{
			super({name:"Digg",favicon: DiggIcons.DIGG_16_ICON});
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
			return new DiggPlugin();
		}
	}
}