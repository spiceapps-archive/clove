package com.spice.clove.plugin.content.data
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.core.calls.CallCloveDataType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.vanilla.core.notifications.Notification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.settings.ISettingFactory;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.proxy.ConcreteProxyController;
	import com.spice.vanilla.impl.settings.SettingTable;

	public class CloveAppData implements ICloveData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
	
		//for sqlite
		public var uid:String;
		public var icon:String;
		public var title:String;
		public var message:String;
		public var dateAdded:Number;
		public var datePosted:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _disposed:Boolean;
		private var _responder:CloveAppDataProxyResponder;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		/** 
		 * the proxy to allow other objects to bind to this data
		 */
		
		private var _proxy:ConcreteProxyController;
		
		/**
		 * the column this data is sitting in. we use this to figure out what item renderer
		 * to use 
		 */
		
		private var _column:ClovePluginColumn;
		
		/**
		 * contains settings 
		 */		
		
		private var _settingTable:ISettingTable;
		
		/**
		 * renders THIS app data. 
		 */		
		
		private var _itemRenderer:ICloveDataRenderer;
		
		/**
		 * builds each setting value from attachments, to simple data like strings, and ints 
		 */		
		
		private var _settingFactory:ISettingFactory;
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getProxy():IProxy
		{
			if(!_proxy)
			{
				_proxy = new ConcreteProxyController();
				_responder = new CloveAppDataProxyResponder(this);
				_proxy.addProxyCallObserver(_responder);
			}
			
			return _proxy;
		}
		
		/**
		 */
		
		public function getUID():String
		{
			return this.uid;
		}
		
		
		/**
		 */
		public function setUID(value:String):void
		{
			this.uid = value;
		}
		
		/**
		 */
				
		public function getIcon():String
		{
			return this.icon;
		}
		
		/**
		 */
		
		
		public function setIcon(value:String):void
		{
			this.icon = value;
		}
		
		/**
		 */
		
		
		public function getTitle():String
		{
			return this.title;
		}
		
		/**
		 */
		
		public function setTitle(value:String):void
		{
			this.title = value;
		}
		
		
		/**
		 */
		
		public function getMessage():String
		{
			return this.message;
		}
		
		/**
		 */
		
		public function setMessage(value:String):void
		{
			this.message = value;
		}
		
		/**
		 */
		
		public function getDatePosted():Number
		{
			return this.datePosted;
		}
		
		/**
		 */
		
		public function setDatePosted(value:Number):void
		{
			this.datePosted = value;
		}
		
		/**
		 */
		
		public function getItemRenderer():ICloveDataRenderer
		{
			return this._itemRenderer;
		}
		
		/**
		 */
		
		public function setItemRenderer(value:ICloveDataRenderer):void
		{
			this._itemRenderer = value;
		}
		
		/**
		 */
		
		public function getColumn():ClovePluginColumn
		{
			return this._column;
		}
		
		/**
		 */
		
		public function setColumn(value:ClovePluginColumn):void
		{
			_column = value;
			
			
			if(value)
				this.setItemRenderer(value.itemRenderer);
			else
				this.setItemRenderer(null);
		}
		
		/**
		 */
		
		public function disposed():Boolean
		{
			return this._disposed;
		}
		
		
		/**
		 */
		
		public function registerSettingFactory(value:ISettingFactory):void
		{
			this._settingFactory = value;
		}
		
		
		/**
		 */
		
		public function getSettingTable():ISettingTable
		{
			if(!_settingTable)
			{
				
				this._settingTable = new SettingTable(this._settingFactory);	
			}
			
			return this._settingTable;
		}
		
		
		/**
		 */
		
		public function construct(uid:String      = null,
								  datePosted:Date = null, 
								  title:String    = null,
								  message:String  = null,
								  icon:String 	  = null,
								  settingFactory:ISettingFactory = null):ICloveData
		{

			this.uid 	    = uid;
			
			if(datePosted)
				this.datePosted = datePosted.time;
			
			this.title	    = title;
			this.message    = message;
			this.icon 	    = icon;
			
			
			//the setting factory may already be registered, so do NOT overwrite if it exists
			if(settingFactory)
				this._settingFactory = settingFactory;
			
			return this;
		}
		
		/**
		 */
		
		public function updateData():void
		{ 
			
			ConcreteProxyController(this.getProxy()).notifyBoundObservers(new Notification(CallCloveDataType.UPDATE_CLOVE_DATA));
			//abstract   
			
		}
		
		/**
		 */
		
		public function deleteData():void
		{
			ConcreteProxyController(this.getProxy()).notifyBoundObservers(new Notification(CallCloveDataType.DELETE_CLOVE_DATA));
			//abstract
		}
		
		
		/**
		 */
		
		public function dispose():void
		{
			this._disposed = true;
			
			
			this.setColumn(undefined);
			this.setDatePosted(NaN);
			this.setIcon(undefined);
			this.setTitle(undefined);
			this.setMessage(undefined);
			this.setUID(undefined);
			
			if(this._settingTable)
			{
				this._settingTable.dispose();
				this._settingFactory = null;
			}
			
			if(this._responder)
			{
				this._responder.dispose();
			}
			
			if(this._proxy)
			{
				this._proxy.dispose();
				this._proxy = null;
			}
			
		}
	}
}