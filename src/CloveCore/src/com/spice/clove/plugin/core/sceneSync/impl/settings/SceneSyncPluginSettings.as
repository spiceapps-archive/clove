package com.spice.clove.plugin.core.sceneSync.impl.settings
{
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPluginFactory;
	import com.spice.clove.plugin.core.sceneSync.impl.service.settings.CloveServiceSettings;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.service.impl.settings.AbstractServicePluginSettings;
	import com.spice.clove.service.impl.settings.ISettingAccountFactory;
	import com.spice.clove.service.impl.settings.ServiceSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	import com.spice.vanilla.impl.settings.child.ChildSettingTable;
	import com.spice.vanilla.impl.settings.list.StringListSetting;

	public class SceneSyncPluginSettings extends AbstractServicePluginSettings
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _serviceSettings:CloveServiceSettings;
		private var _banner:StringSetting;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncPluginSettings(factory:ISettingAccountFactory)
		{
			super(new SceneSyncPluginSettingsFactory(factory));
			
			_banner =  StringSetting(this.getNewSetting(BasicSettingType.STRING,"sceneSyncBanner"));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getPublicServiceSetting():CloveServiceSettings
		{
			if(!_serviceSettings)
			{
				_serviceSettings = ChildSettingTable(this.getNewSetting(SceneSyncPluginSettingsType.SERVICE_SETTINGS,"cloveServiceSettings")).getData() as CloveServiceSettings;
			}
			return _serviceSettings;
		}
		
		
		/**
		 */
		
		public function getBanner():StringSetting
		{
			return this._banner;
		}
	}
}