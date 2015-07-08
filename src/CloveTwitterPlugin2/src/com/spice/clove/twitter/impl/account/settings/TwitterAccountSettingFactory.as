package com.spice.clove.twitter.impl.account.settings
{
	import com.spice.clove.twitter.impl.settings.CloveTwitterSettingType;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.child.ChildSettingTable;
	import com.spice.vanilla.impl.settings.list.NumberListSetting;
	import com.spice.vanilla.impl.settings.list.StringListSetting;
	

	public class TwitterAccountSettingFactory extends BasicSettingFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterAccountSettingFactory()
		{
			super();
			
			this.addAvailableSettings([ CloveTwitterSettingType.OAUTH_TOKEN ]);
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
				case CloveTwitterSettingType.OAUTH_TOKEN: return new OAuthTokenSetting(name,type);
				case CloveTwitterSettingType.STRING_LIST: return new StringListSetting(name,type);
				case CloveTwitterSettingType.NUMBER_LIST: return new NumberListSetting(name,type);
				case CloveTwitterSettingType.CHILD_SETTING_TABLE: return new ChildSettingTable(name,type,new SettingTable(this));
			}
			
			return super.getNewSetting(type,name);
		}
		
		/**
		 */
		
		public static function getInstance():TwitterAccountSettingFactory
		{
			return Singleton.getInstance(TwitterAccountSettingFactory);
		}
	}
}