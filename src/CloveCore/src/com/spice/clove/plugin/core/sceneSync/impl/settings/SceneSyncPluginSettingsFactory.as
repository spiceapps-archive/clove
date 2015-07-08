package com.spice.clove.plugin.core.sceneSync.impl.settings
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.settings.CloveServiceSettings;
	import com.spice.clove.service.impl.settings.ISettingAccountFactory;
	import com.spice.clove.service.impl.settings.ServiceSettingFactory;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.child.ChildSettingTable;
	import com.spice.vanilla.impl.settings.list.StringListSetting;

	public class SceneSyncPluginSettingsFactory extends ServiceSettingFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncPluginSettingsFactory(factory:ISettingAccountFactory)
		{
			super(factory);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getNewSetting(type:int, name:String):ISetting
		{
			switch(type)
			{
				case SceneSyncPluginSettingsType.SERVICE_SETTINGS: return new ChildSettingTable(name,type,new CloveServiceSettings());
			}
			
			return super.getNewSetting(type,name);
		}
		
		/**
		 */
		
		public static function getInstance():SceneSyncPluginSettingsFactory
		{
			return Singleton.getInstance(SceneSyncPluginSettingsFactory);
		}
	}
}