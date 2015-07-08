package com.spice.clove.plugin.service
{
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.install.IServiceInstaller;

	public class CloveServicePluginFactory extends PluginFactory implements IPluginFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		public var installer:IServiceInstaller = null;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveServicePluginFactory()
		{
			super({name:'Clove Servie'});
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
			return new CloveServicePlugin();
		}
	}
}