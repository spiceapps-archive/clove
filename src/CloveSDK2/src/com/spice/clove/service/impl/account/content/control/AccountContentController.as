package com.spice.clove.service.impl.account.content.control
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.service.core.account.content.control.IAccountContentController;
	import com.spice.clove.service.core.calls.CallToServiceAccountType;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.account.content.control.setting.AccountContentControllerSettingFactory;
	import com.spice.clove.service.impl.account.content.control.setting.AccountContentControllerSettingType;
	import com.spice.clove.service.impl.account.content.control.setting.AccountSetting;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	import com.spice.vanilla.impl.settings.SettingTable;

	public class AccountContentController extends CloveContentController implements IAccountContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _accunt:AbstractServiceAccount;
		private var _initialized:Boolean;
		private var _plugin:AbstractServicePlugin;
		private var _helper:AccountContentControlHelper;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AccountContentController(factoryName:String,
												 plugin:ClovePlugin,
												 itemRenderer:ICloveDataRenderer,
												 settings:AccountContentControllerSettingFactory = null)
		{
			
			_plugin = AbstractServicePlugin(plugin);
			super(factoryName,plugin,itemRenderer,new SettingTable(settings || new AccountContentControllerSettingFactory(this.getHelper())));
			
			
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAccount():AbstractServiceAccount
		{
			return this.getHelper().getAccount();
		}
		
		
		/**
		 */
		
		public function getHelper():AccountContentControlHelper
		{
			if(!_helper)
			{
				_helper= new AccountContentControlHelper(this);
				this.addDisposable(_helper);
			}
			return _helper;
		}
		
		
		/**
		 */
		
		public function getAccountOrMake():AbstractServiceAccount
		{
			return this.getHelper().getAccountOrMake();
		}
		
		
		
		/**
		 */
		override public function setBreadcrumb(controller:ICloveContentController):void
		{
			  
			if(controller is IAccountContentController)
			{
				IAccountContentController(controller).setAccount(this.getAccount());
			}
			
			super.setBreadcrumb(controller);
			
		}
		
		/**
		 */
		
		public function setAccount(value:AbstractServiceAccount):void
		{
			this.getHelper().setAccount(value);
			
			if(!_initialized)
			{
				this._initialized = true;
				this.initialize(value);
			}
		}
		
		/**
		 */
		
		protected function initialize(value:AbstractServiceAccount):void
		{
			//abstract
		}
		
		
	}
}