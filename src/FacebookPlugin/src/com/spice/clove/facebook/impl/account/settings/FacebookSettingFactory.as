package com.spice.clove.facebook.impl.account.settings
{
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class FacebookSettingFactory extends BasicSettingFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookSettingFactory()
		{
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
				case FacebookSettingType.FACEBOOK_SESSION: return new FacebookSessionSetting(type,name);
				case FacebookSettingType.USER_INFO: return new FacebookUserInfoSetting(type,name);
			}
			
			return super.getNewSetting(type,name);
		}
		
		/**
		 */
		
		public static function  getInstance():FacebookSettingFactory
		{
			return Singleton.getInstance(FacebookSettingFactory);
		}
	}
}