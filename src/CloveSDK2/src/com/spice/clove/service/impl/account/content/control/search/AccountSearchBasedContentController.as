package com.spice.clove.service.impl.account.content.control.search
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.search.CloveSearchBasedContentController;
	import com.spice.clove.service.core.account.content.control.IAccountContentController;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.account.content.control.AccountContentControlHelper;
	import com.spice.clove.service.impl.account.content.control.setting.AccountContentControllerSettingFactory;
	import com.spice.clove.service.impl.account.content.control.setting.AccountContentControllerSettingType;
	import com.spice.clove.service.impl.account.content.control.setting.AccountSetting;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	import com.spice.vanilla.impl.settings.SettingTable;
	
	public class AccountSearchBasedContentController extends CloveSearchBasedContentController implements IAccountContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _initialized:Boolean;
		private var _account:AbstractServiceAccount;
		private var _plugin:AbstractServicePlugin;
		private var _accountRemoveBind:ProxyBind;
		private var _helper:AccountContentControlHelper;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AccountSearchBasedContentController(factoryName:String,
															plugin:ClovePlugin,
															itemRenderer:ICloveDataRenderer,
															namePrefix:String = null,
															keywordSearch:String = null)
		{
			
			
			_plugin = AbstractServicePlugin(plugin);
			super(factoryName,plugin,itemRenderer,new SettingTable(new AccountContentControllerSettingFactory(this.getHelper())),namePrefix,keywordSearch);
			
			
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
			
			if(!_initialized && value)
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