package com.spice.clove.plugin.core.root.impl.settings
{
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.GroupColumn;
	import com.spice.clove.plugin.column.HolderColumn;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.list.StringListSetting;
	import com.spice.vanilla.impl.settings.list.StringTreeListSetting;

	public class RootPluginSettingsFactory extends BasicSettingFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RootPluginSettingsFactory()
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
				case RootPluginSettingType.BASE_COLUMN: return new ColumnSetting(name,type,this,CloveColumn);
				case RootPluginSettingType.GROUP_COLUMN: return new ColumnSetting(name,type,this,GroupColumn);
				case RootPluginSettingType.HOLDER_COLUMN: return new ColumnSetting(name,type,this,HolderColumn);
				case RootPluginSettingType.PLUGIN_COLUMN: return new ColumnSetting(name,type,this,ClovePluginColumn);
				case RootPluginSettingType.STRING_LIST: return new StringListSetting(name,type);
				case RootPluginSettingType.SCENE_SYNC_SUBSCRIPTION_LIST: return new SceneSyncSubscriptionList(name,type);
				case RootPluginSettingType.STRING_TREE_LIST: return new StringTreeListSetting(name,type);
			}
			
			return super.getNewSetting(type,name);
		}
		
		/**
		 */
		
		public static function getInstance():RootPluginSettingsFactory
		{
			return Singleton.getInstance(RootPluginSettingsFactory);
		}
	}
}