package com.spice.clove.service.impl.account.content.control.setting
{
	import com.spice.clove.service.core.account.content.control.IAccountContentController;
	import com.spice.clove.service.impl.account.content.control.AccountContentControlHelper;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.core.settings.ISettingFactory;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class AccountContentControllerSettingFactory implements ISettingFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _helper:AccountContentControlHelper;
		private var _basicSettingFactory:BasicSettingFactory;
		private var _available:Vector.<int>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AccountContentControllerSettingFactory(helper:AccountContentControlHelper)
		{
			_helper = helper;
			_basicSettingFactory = BasicSettingFactory.getInstance();
			_available = _basicSettingFactory.getAvailableSettings().concat()
			_available.push(AccountContentControllerSettingType.ACCOUNT);
			_available.fixed= true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAvailableSettings():Vector.<int>
		{
			return _available;	
		}
		/**
		 */
		
		public function getNewSetting(type:int, name:String):ISetting
		{
			switch(type)
			{
				case AccountContentControllerSettingType.ACCOUNT: return new AccountSetting(name,type,_helper);
			}
			
			return _basicSettingFactory.getNewSetting(type,name);
		}
		
	}
}