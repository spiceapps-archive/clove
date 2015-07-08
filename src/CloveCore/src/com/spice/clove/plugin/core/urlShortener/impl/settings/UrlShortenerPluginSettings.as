package com.spice.clove.plugin.core.urlShortener.impl.settings
{
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;

	public class UrlShortenerPluginSettings extends ClovePluginSettings
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _defaultShortener:StringSetting;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UrlShortenerPluginSettings()
		{
			super(BasicSettingFactory.getInstance());
			
			this._defaultShortener = this.getNewSetting(BasicSettingType.STRING,"defaultShortener") as StringSetting;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getDefaultShortener():StringSetting
		{
			return this._defaultShortener;
		}
	}
}