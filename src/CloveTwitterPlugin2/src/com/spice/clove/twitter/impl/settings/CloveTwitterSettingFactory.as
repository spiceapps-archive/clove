package com.spice.clove.twitter.impl.settings
{
	import com.spice.clove.twitter.impl.account.settings.TwitterAccountSettingType;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.child.ChildSettingTable;
	import com.spice.vanilla.impl.settings.list.NumberListSetting;
	import com.spice.vanilla.impl.settings.list.StringListSetting;
	

	public class CloveTwitterSettingFactory extends BasicSettingFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveTwitterSettingFactory()
		{
			super();
			
			this.addAvailableSettings([ TwitterAccountSettingType.OAUTH_TOKEN ]);
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
				case TwitterAccountSettingType.OAUTH_TOKEN: return new OAuthTokenSetting(name,type);
				case TwitterAccountSettingType.STRING_LIST: return new StringListSetting(name,type);
				case TwitterAccountSettingType.NUMBER_LIST: return new NumberListSetting(name,type);
				case TwitterAccountSettingType.CHILD_SETTING_TABLE: return new ChildSettingTable(name,type,new SettingTable(this));
			}
			
			return super.getNewSetting(type,name);
		}
		/**
		 */
		
		public static function getInstance():CloveTwitterSettingFactory
		{
			return Singleton.getInstance(CloveTwitterSettingFactory);
		}
	}
}