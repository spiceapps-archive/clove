package com.spice.clove.plugin.core.root.impl.history
{
	import com.spice.clove.events.ColumnHistoryEvent;
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.IColumnHistory;
	import com.spice.clove.plugin.core.calls.CallCloveColumnType;
	import com.spice.clove.plugin.core.calls.CallCloveContentControllerType;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.root.impl.CloveRootPlugin;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.flash.gc.Janitor;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import mx.collections.IList;
	import mx.events.CollectionEvent;
	
	public class ConcreteColumnHistory extends EventDispatcher implements IColumnHistory, 
		IProxyResponseHandler, 
		IProxyBinding
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * the list holding all of the data 
		 */		
		private var _list:IList;
		
		/**
		 * the id of this history so we cna point to where the data is saved 
		 */		
		protected var _id:StringSetting;
		
		
		
		
		/**
		 * the metadata used to store anything needed by the hist such as the ID 
		 */		
		private var _settings:SettingTable;
		
		
		/**
		 * the target column that owns this history 
		 */		
		protected var _target:CloveColumn;
		
		/**
		 * the item renderer used to transform non-clove data, to clove data 
		 */		
		protected var _itemRenderer:ICloveDataRenderer;
		
		
		/**
		 * the content controller that loads information from the particular service, and bridges it to Clove 
		 */		
		protected var _contentController:ICloveContentController;
		
		
		/**
		 * the ROOT plugin that owns this history 
		 */		
		
		private var _plugin:CloveRootPlugin;
		
		
		/**
		 */
		
		protected var _janitor:Janitor;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function ConcreteColumnHistory(target:CloveColumn,plugin:CloveRootPlugin,data:ByteArray = null)
		{
			_target = target;
			
			_settings = new SettingTable(BasicSettingFactory.getInstance());
			_id = StringSetting(_settings.getNewSetting(BasicSettingType.STRING,"id"));
			
			_plugin = plugin;
			if(data)
			{
				data.position = 0;
				_settings.readExternal(data);
				
				
				//UID's must ALWAYS be unique. make sure the one read isn't already used. if it is, 
				//make a new one.
				this.resetUIDIfExists();
			}
			else
				//if this ID doesn't exist, then register it with the root column, so we
				//we don't get mixed up with other content belonging to other columns.
			{
				this.resetID();
				this.resetUIDIfExists();
			}
			
			
			_janitor = new Janitor();
			
			plugin.setHistoryController(this.id,this);
			
			//make the binding for the content controller so we can hook it up to the item renderer
			_janitor.addDisposable(new ProxyCall(CallCloveColumnType.GET_CONTENT_CONTROLLER,target.getProxy(),null,this,this).dispatch());
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		
		
		/**
		 */
		[Bindable(evnt="currentDataChange")]
		public function get currentData():IList
		{
			return this._list;
		}
		
		/**
		 */
		
		public function get id():String
		{
			return this._id.getData();
		}
		
		
		/**
		 */
		private function resetID():void
		{
			_id.setData(String(_plugin.getIncrementalUID()));
		}
		
		/**
		 */
		
		public function get numUnread():int
		{
			return 0;
		}
		
		/**
		 */
		
		public function get target():CloveColumn
		{
			return this._target;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function dispose():void
		{
			if(!this._janitor)
				return;
			
			this._janitor.dispose();

			var stack:Array = this._list.toArray();
			for each(var d:ICloveData in stack)
			{
				d.dispose();
			}
			
			
			if(this._list is IDisposable)
				IDisposable(this._list).dispose(); //sqlist
			else
				this._list.removeAll();
			  
			this._settings.dispose();
			this._plugin.removeHistoryController(this.id);
			
			
			
			this._list = undefined;
			this._target = undefined;
			this._contentController = undefined;
			this._id = undefined;
			this._itemRenderer = undefined;
			this._settings = undefined;
			
			
		}
		
		/**
		 */
		
		public function resetUIDIfExists():void
		{
			while(this._plugin.getHistoryController(this.id))
			{
				this.resetID();
			}
		}
		
		/**
		 */
		
		public function getItemRenderer():ICloveDataRenderer
		{
			return this._itemRenderer;
		}
		
		
		/**
		 */  
		
		public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallCloveColumnType.GET_CONTENT_CONTROLLER:
					
					if(_contentController)
					{
						this.removeAllItems();
					}
					
					this._contentController = n.getData();
					
					if(this._contentController)
					{
						ProxyCallUtils.quickCall(CallCloveContentControllerType.GET_ITEM_RENDERER,this._contentController.getProxy(),null,this);
						ProxyCallUtils.quickCall(CallCloveContentControllerType.GET_DATA_ORDER_BY,this._contentController.getProxy(),null,this);
					}
					
					break;
				case CallCloveContentControllerType.GET_ITEM_RENDERER:
					_itemRenderer = n.getData();
					break;
				case CallCloveContentControllerType.GET_DATA_ORDER_BY:
					this.setOrderBy(n.getData());
					break;
				case CallClovePluginType.APPLICATION_INITIALIZE:
					this.init2();
				break;
				
			}
		}
		
		/**
		 */
		
		public function readExternal(data:IDataInput):void
		{
			this._settings.readExternal(data);
		}
		
		/**
		 */
		
		public function writeExternal(data:IDataOutput):void
		{
			this._settings.writeExternal(data);
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			this.handleProxyResponse(n);
		}
		
		/**
		 */
		
		final public function init():void
		{
			
			_janitor.addEventListener(target,ColumnHistoryEvent.HISTORY_CHANGE,onChildrenHistoryChange,false,0,true);
			
			
			if(!_plugin.getApplicationInitialized())
			{
				
				//listen for app initialized, then remove the bindd (done automatically)
				_janitor.addDisposable(ProxyCallUtils.bind(this._plugin.getProxy(),this,[CallClovePluginType.APPLICATION_INITIALIZE],true));
			}
			else
			{
				this.init2();
			}
		}
		
		/**
		 */
		
		public function addHistory(data:Array,flags:int = 0,isOlder:Boolean = false):void
		{
			//OVERRIDE ME
		}
		
		/**
		 */
		
		public function removeAllItems(removeDeleted:Boolean = false):void
		{
			
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		protected function init2():void
		{
//			target.addEventListener(ColumnHistoryEvent.HISTORY_CHANGE,onChildrenHistoryChange,false,9,true);
			
			onChildrenChange();
			_janitor.addEventListener(target.children,CollectionEvent.COLLECTION_CHANGE,onChildrenChange,false,0,true);
		}
		
		/**
		 */
		
		protected function setOrderBy(value:Object):void
		{
		}
		
		
		
		/**
		 */
		
		protected function onChildrenChange(event:CollectionEvent = null):void
		{        
			if(event && this.target && this.target.parent)
				ConcreteColumnHistory(this.target.parent.history).onChildrenChange(event);
		}
		
		
		
		/**
		 */
	
		
		protected function onChildrenHistoryChange(event:CollectionEvent):void
		{
			//abstract
		} 
		
		
		/**
		 * takes the collection change event dispatched by the storage system (SQLite for desktop) and turns
		 * it into a bubbled up history change event read by other history controllers
		 */
		
		protected function bubbleUpHistoryChange(event:CollectionEvent):void
		{
			
			this.dispatchEvent(this.cloneCollectionEvent(ColumnHistoryEvent.HISTORY_CHANGE,event));
			
		}
		
		
		
		
		/**
		 */
		
		protected function cloneCollectionEvent(name:String,event:CollectionEvent):CollectionEvent
		{
			return new CollectionEvent(name,
									   true,
									   true,
									   event.kind,
									   event.location,
									   event.oldLocation,
									   event.items);
		}
		
		/**
		 */
		
		protected function setList(list:IList):void
		{
			this._list = list;
			
			this.dispatchEvent(new Event("currentDataChange"));
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		
	}
}