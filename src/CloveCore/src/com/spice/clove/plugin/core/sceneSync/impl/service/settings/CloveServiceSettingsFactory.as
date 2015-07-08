package com.spice.clove.plugin.core.sceneSync.impl.service.settings
{
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.sceneSync.core.service.data.SceneSubscriptionData;
	import com.spice.clove.sceneSync.core.service.data.ScreenData;
	import com.spice.clove.sceneSync.core.service.settings.CloveServiceSettingType;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.list.StringListSetting;

	public class CloveServiceSettingsFactory extends BasicSettingFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveServiceSettingsFactory()
		{
			super();
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
				case CloveServiceSettingType.SCREEN_DATA: return new ScreenData(name,type);
				case CloveServiceSettingType.SCENE_DATA: return new SceneData(type,0,name);
				case CloveServiceSettingType.SUBSCRIPTION_DATA: return new SceneSubscriptionData(name,type);
				case CloveServiceSettingType.SYNC_LIST: return new SyncListSetting(name,type);
			}
			
			return super.getNewSetting(type,name);
		}
		
		/**
		 */
		
		public static function getInstance():CloveServiceSettingsFactory
		{
			return Singleton.getInstance(CloveServiceSettingsFactory);
		}
	}
}