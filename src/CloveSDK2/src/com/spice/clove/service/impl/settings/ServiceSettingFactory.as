package com.spice.clove.service.impl.settings
{
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.core.settings.ISettingFactory;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.AbstractSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class ServiceSettingFactory implements ISettingFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _accountFactory:ISettingAccountFactory;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ServiceSettingFactory(accountFactory:ISettingAccountFactory)
		{
			_accountFactory = accountFactory;    
		}
		
		public function getAvailableSettings():Vector.<int>
		{
			return new Vector.<int>();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getNewSetting(type:int, name:String):ISetting
		{
			switch(type)
			{
				case ServiceSettingType.ACCOUNT_LIST: return new AccountList(name,type,_accountFactory);
			}
			
			return BasicSettingFactory.getInstance().getNewSetting(type,name);
		}
		
	}
}