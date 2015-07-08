package com.spice.clove.facebook.impl.account.settings
{
	import com.facebook.air.SessionData;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;

	public class FacebookAccountSettings extends SettingTable
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _session:FacebookSessionSetting;
		private var _username:StringSetting;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookAccountSettings()
		{  
			super(FacebookSettingFactory.getInstance());
			
			_session = FacebookSessionSetting(this.getNewSetting(FacebookSettingType.FACEBOOK_SESSION,'facebookSession'));
			_username = StringSetting(this.getNewSetting(BasicSettingType.STRING,'username'));
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function getSession():FacebookSessionSetting
		{
			return this._session;
		}
		
		/**
		 */
		
		public function getUsername():String
		{
			return this._username.getData();
		}
		
		/**
		 */
		
		public function setUsername(value:String):void
		{
			this._username.setData(value);
		}
		
		
	}
}