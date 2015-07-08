package com.spice.clove.plugin.impl.settings
{
	import com.spice.vanilla.core.plugin.settings.IPluginSettings;
	import com.spice.vanilla.core.settings.ISettingFactory;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.BooleanSetting;
	
	

	public class ClovePluginSettings extends SettingTable implements IPluginSettings
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _installed:BooleanSetting;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ClovePluginSettings(factory:ISettingFactory)
		{
			super(factory);	
			
			_installed = BooleanSetting(this.getNewSetting(BasicSettingType.BOOLEAN,"installed"));
			
//			if(!_firstTimeInitialized.getData())
//			{
//				_firstTimeInitialized.setData(true);
//			}
//			else
//			{
//				_firstTimeInitialized.setData(false);
//			}
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function installed():BooleanSetting
		{
			return this._installed;
		}
		
		
		
	}
}