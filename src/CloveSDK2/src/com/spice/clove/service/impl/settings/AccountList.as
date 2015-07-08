package com.spice.clove.service.impl.settings
{
	import com.spice.clove.service.core.account.IServiceAccount;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.observer.IObserver;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.core.settings.ISettingFactory;
	import com.spice.vanilla.impl.settings.Setting;
	import com.spice.vanilla.impl.settings.basic.IntSetting;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class AccountList extends Setting implements IObserver
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _factory:ISettingAccountFactory;
		private var _list:Vector.<IServiceAccount>;
		private var _noi:Vector.<String>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AccountList(name:String,type:int,factory:ISettingAccountFactory)
		{
			super(name,type);
			
			_factory = factory;
			_list = new Vector.<IServiceAccount>();
			_noi = new Vector.<String>(1,true);
			_noi[0] = SettingChangeNotification.CHANGE;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getNotificationsOfInterest():Vector.<String>
		{
			return this._noi;
		}
		
		/**
		 */
		
		public function notifyObserver(n:INotification):void
		{
			switch(n.getType())
			{
				case SettingChangeNotification.CHANGE: return this.notifyChange();
			}
			
		}
		/**
		 */
		
		public function addAccount():AbstractServiceAccount
		{
			var s:AbstractServiceAccount = _factory.getNewServiceAccount();
			
			this.linkAccount(s);
			
			_list.push(s);
			
			this.notifyChange();
			
			
			return s;
		}
		
		
		
		/**
		 */
		
		public function removeAccountAt(index:int):AbstractServiceAccount
		{
			var s:IServiceAccount = _list[index];
			_list.splice(index,1);
			return AbstractServiceAccount(s);
		}
		
		
		/**
		 */
		
		public function removeAccount(value:AbstractServiceAccount):AbstractServiceAccount
		{
			var i:int = this._list.indexOf(value);
			
			if(i > -1) this._list.splice(i,1);
			
			this.notifyChange();
			return value;
		}
		
		/**
		 */
		
		public function getAccountAt(index:int):AbstractServiceAccount
		{
			return AbstractServiceAccount(_list[index]);
		}
		
		
		
		/**
		 */
		public function getAccounts():Vector.<IServiceAccount>
		{
			return this._list;
		}
		
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(_list.length);
			
			for each(var setting:AbstractServiceAccount in _list)
			{
				
				var ba:ByteArray = new ByteArray();
				setting.getSettings().writeExternal(ba);
				
				output.writeUnsignedInt(ba.length);
				
				if(ba.length)
				{
					output.writeBytes(ba,0,ba.length);
				}
			}
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			var n:int = input.readUnsignedInt();
			
			for(var i:int = 0; i < n; i++)
			{
				var ba:ByteArray = new ByteArray();
				
				var a:int = input.readUnsignedInt();
				
				var account:AbstractServiceAccount = _factory.getNewServiceAccount();
				
				if(a) input.readBytes(ba,0,a);
				else
					continue;
				
				account.getSettings().readExternal(ba);
				
				this.linkAccount(account);
				
				_list.push(account);
			}
			
			this.notifyChange();
		}
		
		
		
		/**
		 */
		
		protected function linkAccount(acc:AbstractServiceAccount):void
		{
			acc.getSettings().addObserver(this);
		}
		
	}
}