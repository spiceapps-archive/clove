package com.spice.clove.plugin.core.analytics.impl.settings
{
	import com.adobe.xml.syndication.rss.Guid;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.utils.GUID;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;

	public class AnalyticsPluginSettings extends ClovePluginSettings
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _guid:StringSetting;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AnalyticsPluginSettings()
		{
			super(BasicSettingFactory.getInstance());
			
			this._guid = this.getNewSetting(BasicSettingType.STRING,"userGUID") as StringSetting;
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getGuid():String
		{
			if(this._guid.getData() == "")
			{
				this._guid.setData(GUID.create());		
			}
			
			return this._guid.getData();	
		}
	}
}