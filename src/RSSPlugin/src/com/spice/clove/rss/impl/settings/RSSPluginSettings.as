package com.spice.clove.rss.impl.settings
{
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.BooleanSetting;

	public class RSSPluginSettings extends ClovePluginSettings
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _autoExpandFeeds:BooleanSetting;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RSSPluginSettings()
		{
			super(BasicSettingFactory.getInstance());
			
			this._autoExpandFeeds = this.getNewSetting(BasicSettingType.BOOLEAN,"autoExpandFeeds") as BooleanSetting;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAutoExpandFeeds():BooleanSetting
		{
			return this._autoExpandFeeds;
		}
		
		
	}
}