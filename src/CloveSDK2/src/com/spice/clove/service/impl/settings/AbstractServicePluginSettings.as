package com.spice.clove.service.impl.settings
{
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;

	public class AbstractServicePluginSettings extends ClovePluginSettings
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _accountList:AccountList;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractServicePluginSettings(settingFactory:ServiceSettingFactory)
		{
			super(settingFactory);
			
			
			_accountList = AccountList(this.getNewSetting(ServiceSettingType.ACCOUNT_LIST,"accountList"));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAccountList():AccountList
		{
			return this._accountList;
		}
		
		
		
	}
}