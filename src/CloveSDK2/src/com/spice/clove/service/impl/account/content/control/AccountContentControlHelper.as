package com.spice.clove.service.impl.account.content.control
{
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.service.core.account.content.control.IAccountContentController;
	import com.spice.clove.service.core.calls.CallToServiceAccountType;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.account.content.control.setting.AccountContentControllerSettingType;
	import com.spice.clove.service.impl.account.content.control.setting.AccountSetting;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;

	public class AccountContentControlHelper implements IProxyBinding, IDisposable
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:IAccountContentController;
		private var _account:AbstractServiceAccount;
		private var _accountRemoveBind:ProxyBind;
		private var _accSetting:AccountSetting;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AccountContentControlHelper(controller:IAccountContentController)
		{
			_target = controller;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAccountOrMake():AbstractServiceAccount
		{
			if(!this.getAccount())
			{
				this._target.setAccount(AbstractServicePlugin(CloveContentController(this._target).getPlugin()).getAccountOrMake());
			}
			
			return this._account;
		}
		
		
		
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallToServiceAccountType.SERVICE_ACCOUNT_UNINSTALL: return CloveContentController(this._target).dispose();
			}
		}
		
		/**
		 */
		
		public function getPlugin():AbstractServicePlugin
		{
			return AbstractServicePlugin(CloveContentController(this._target).getPlugin());
		}
		
		/**
		 */
		
		public function dispose():void
		{
			if(this._accountRemoveBind)
			{
				this._accountRemoveBind.dispose();
			}
			
		}
		
		/**
		 */
		
		public function getAccount():AbstractServiceAccount
		{
			if(!this._accSetting)
			{
				this.getAccountSettings();
			}
			
			return this._account;
		}
		
		/**
		 */
		
		public function setAccount(value:AbstractServiceAccount):void
		{
			this._account = value;
			this.getAccountSettings().setAccount(value);
			
			
			if(_accountRemoveBind)
			{
				_accountRemoveBind.dispose();
			}
			
			if(value)
			{
				_accountRemoveBind = new ProxyBind(value.getProxy(),this,[CallToServiceAccountType.SERVICE_ACCOUNT_UNINSTALL],true);
			}
			
			
		}
		
		/**
		 */
		
		private function getAccountSettings():AccountSetting
		{
			if(!this._accSetting)
			{
				//we simply need to instantiate the account setting so we can save the state of the account
				_accSetting = AccountSetting(CloveContentController(this._target).getSettings().getNewSetting(AccountContentControllerSettingType.ACCOUNT,"serviceAccountId"));
				_accSetting.initialize();
			}
			
			return this._accSetting;
		}
	}
}