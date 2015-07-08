package com.spice.clove.service.impl.account.content.control.setting
{
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.service.core.account.content.control.IAccountContentController;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.account.content.control.AccountContentControlHelper;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class AccountSetting extends Setting
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _controller:AccountContentControlHelper;
		private var _accountID:Number;
		private var _account:AbstractServiceAccount;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AccountSetting(name:String,type:int,controller:AccountContentControlHelper)
		{
			super(name,type);
			this._controller = controller;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function initialize():void
		{
			
			this._account = this._controller.getAccount();
			
			if(this._account)
			{
				this._accountID = this.getAccountIndex();
			}
		}
		/**
		 */
		
		public function getAccount():AbstractServiceAccount
		{
			return this._account;
		}
		
		/**
		 */
		
		public function setAccount(value:AbstractServiceAccount):void
		{
			this._account = value;
			
			this._accountID = this.getAccountIndex();
			
			this.notifyChange();
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			this._accountID = input.readUnsignedInt();
			
			_account = this.getAccountAtIndex();
			
			this._controller.setAccount(this._account);
			
			this.notifyChange();
		}
		
		/**
		 */
		
		
		override public function writeExternal(output:IDataOutput):void
		{
			this._account = this._controller.getAccount();
			this._accountID = this.getAccountIndex();
			output.writeUnsignedInt(this._accountID);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function getAccountIndex():int
		{
			return _controller.getPlugin().getAccountIndex(this._account);
		}
		
		/**
		 */
		
		public function getAccountAtIndex():AbstractServiceAccount
		{
			
			return _controller.getPlugin().getAccountAt(this._accountID);
		}
	}
}