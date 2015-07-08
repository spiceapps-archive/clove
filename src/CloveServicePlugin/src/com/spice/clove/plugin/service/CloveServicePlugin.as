package com.spice.clove.plugin.service
{
	import com.spice.air.utils.appStorage.ZipShip;
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.control.IPluginController;

	public class CloveServicePlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _settings:CloveServiceSettings;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveServicePlugin()
		{
			_settings = new CloveServiceSettings();
			
			super(_settings);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function initialize(controller:IPluginController) : void
		{
			super.initialize(controller);
			
			
		}
	}
}