package com.spice.clove.plugin.core.installer.settings
{
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.BooleanSetting;

	public class CloveInstallerPluginSettings extends ClovePluginSettings
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _showHelloScreenOnStartup:BooleanSetting;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveInstallerPluginSettings()
		{
			super(BasicSettingFactory.getInstance());
			
			this.getShowHelloScreenOnStartup().setData(true);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getShowHelloScreenOnStartup():BooleanSetting
		{
			return this.getNewSetting(BasicSettingType.BOOLEAN,"showHelloScreenOnStartup") as BooleanSetting;
		}
		
	}
}