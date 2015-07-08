package com.spice.clove.plugin.column
{
	import com.hurlant.util.Base64;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.events.ColumnHistoryEvent;
	import com.spice.clove.events.ColumnMetaDataEvent;
	import com.spice.clove.plugin.column.crumb.CloveColumnCrumbController;
	import com.spice.clove.plugin.core.calls.CallCloveColumnType;
	import com.spice.clove.plugin.core.column.ICloveColumn;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.root.impl.settings.RootPluginSettingType;
	import com.spice.clove.view.column.ClovePluginColumnDataView;
	import com.spice.utils.GUID;
	import com.spice.utils.queue.cue.CueStateType;
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.flash.gc.Janitor;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.BooleanSetting;
	import com.spice.vanilla.impl.settings.basic.IntSetting;
	import com.spice.vanilla.impl.settings.basic.NumberSetting;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	[Event(name="collectionChange",type="mx.events.CollectionEvent")]
	
	
	
	/*
	  
	  @author craigcondon
	  
	 */	
	 
	public class CloveColumn extends EventDispatcher implements ICloveColumn, 
																		  IProxyResponseHandler, 
																		  IProxyResponder, 
																		  IProxyOwner, 
																		  IExternalizable, IDisposable
	{

		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		/*
		  child columns
		 */
		 
		private var _children:ArrayCollection;
		
		/*
		  the parent neem column
		 */
		 
		private var _parent:CloveColumn;
		
		/*
		  the stored information about the column saved to disk
		 */
		 
		private var _info:SettingTable;
		
		
		/*
		  the row history, along with deleted data
		 */
		
		
		private var _history:IColumnHistory;
		
		
		/*
		  the options to use for each rendered data
		 */
		
		private var _columnDataOptions:ArrayCollection;;
		
		
		/*
		 */
		
		private var _controller:ColumnHistoryController;
		
		
		/*
		 */
		
		private var _storedControllerData:ByteArray;
		
		
		/*
		 */
		
		protected var _title:StringSetting;
		
		
		/**
		 */
		
		private var _proxy:ProxyOwner;
		
		
		/**
		 */
		
		private var _uid:StringSetting;
		
		/**
		 */
		
		private var _itemRenderer:ICloveDataRenderer;
		
		/**
		 */
		
		protected var _janitor:Janitor;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		
        /**
         * TRUE if the parent can save the child
         */		
        public var allowTreeBuilding:Boolean;
        
        /**
         * TRUE if the current column can save the child column
         */
        
        public var allowChildBuilding:Boolean;
        
		
		public var currentErrorMessage:String;
        
        
        /**
         * used for marking the item read as well as caching the scroll position
         */
        
        [Bindable]
        [Setting]
        public var targetIndex:IntSetting;
        
		
		
		private var _breadcrumb:CloveColumnCrumbController;
		
		
		/**
		 * used for saving the column to disk 
		 */		
		
		private var _type:int;
        
		
		[Bindable] 
		public var loadState:int  = CueStateType.COMPLETE;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
		/*
		  Constructor
		  @param controller controls the column metadata and history manager
		  @param history history manager that caches all downloaded content
		  
		 */ 
		        
		public function CloveColumn(type:int = RootPluginSettingType.BASE_COLUMN,
									controller:ColumnHistoryController = null,
								    history:IColumnHistory = null)
		{
			
			super();
//			super(null,true);
			
			_type = type;
			
			_janitor = new Janitor();
			
			column_internal::historyController = controller;
			
			_breadcrumb = new CloveColumnCrumbController(this);
			
			_columnDataOptions = new ArrayCollection();
//			this.janitor.addDisposable(_columnDataOptions);
			
			this._children = new ArrayCollection();
			this._children.addEventListener(CollectionEvent.COLLECTION_CHANGE,onChildrenChange,false,9999,true);
			
			
			
//			_settingManager = new SettingManager(null,this);
//			this.janitor.addDisposable(this._settingManager);
			
			
			this.setColumnInfo(new SettingTable(BasicSettingFactory.getInstance()));
			this._info.addObserver(new CallbackObserver(SettingChangeNotification.CHANGE,this.onMetadataChange));
			
			
			this.allowTreeBuilding = true;
			this.allowChildBuilding = true;
			
			
			//this._renderer = new CloveColumnItemRenderer(this);
			//this.janitor.addDisposable(this._renderer);
			
			
			//options for each column row
			//_driver = new ColumnDataDriver(this._columnDataOptions);
			//this.janitor.addDisposable(_driver);
			
			
			
			_proxy = new ProxyOwner(this);
			this.setupAvailableProxyCalls();
				
				
			
			this.addEventListener(CloveColumnEvent.LOAD_STATE_CHANGE,onLoadStateChange);
			this.addEventListener(CloveColumnEvent.DISPLAY_ERROR_MESSAGE,onDisplayError);
			
		}
		
		
		/**
		 */
		
		public function addNumUnread(value:Number):void
		{
			this.getNumUnread().setData(this.getNumUnread().getData()+value);
			
			if(this._parent)
			{
				this._parent.addNumUnread(value);
			}
		}
		
		/**
		 */
		
		public function markAllRead():void
		{
			this.getNumUnread().setData(0);
			
			for each(var child:CloveColumn in this._children.source)
			{
				child.markAllRead();
			}
		}
		
		/**
		 */
		
		public function getNumUnread():NumberSetting
		{
			return NumberSetting(this.metadata.getNewSetting(BasicSettingType.NUMBER,ColumnMetaData.NUM_SUM_UNREAD));
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get type():int
		{
			return this._type;
		}
		
		/**
		 */
		
		public function get breadcrumbController():CloveColumnCrumbController
		{
			return this._breadcrumb;
		}
		
		public function get itemRenderer():ICloveDataRenderer
		{
			return this._itemRenderer;
		}
		
		public function set itemRenderer(value:ICloveDataRenderer):void
		{
			this._itemRenderer = value;
		}
		
		
		/**
		 */
		
		[Bindable(event="titleChange")]
		public function get title():String
		{
			return _title.getData();
		}
		
		/**
		 */
		
		public function set title(value:String):void
		{
			if(value == "" || value == "null" || !value)
			{
				value = "Untitled Column";
			}
			
			this._title.setData(value);
			
			this.dispatchEvent(new Event("titleChange"));
		}
		
		/**
		   
		  @return the root column
		  
		 */		
		
		public function get root():CloveColumn
		{
			while(this.parent)
			{
				return this.parent.root;
			}
			
			return this;
		}
		
		
		/**
		  
		  @return the cached column rows
		  
		 */		
		
		public function get dataProvider():IList
		{
			if(!_history)
				return null;
			
			return this._history.currentData;
		}
		
		
		
		/**
		 * The view that contains all the rows. This is by default the SmoothList
		 */
		/*[Bindable(event="rendererChange")]
		final public function get itemRenderer():CloveColumnItemRenderer
		{
			return _renderer;
		}*/

		
		/*
		  
		  @return the child columns
		  
		 */		
		
		public function get children():IList
		{
			return _children;
		}

		
		/*
		  
		  @return the parent column
		  
		 */		
		
		public function get parent():CloveColumn
		{
			return _parent;
		}
		
		/*
		 */
		
		/* public function get notificationClass():Class
		{
			return _notificationClass;
		} */
		
		/*
		 */
		
		/* public function set notificationClass(value:Class):void
		{
			_notificationClass = value;
		} */
		
		
		/*
		  the metadata stored in this column
		 */
		
		public function get metadata():SettingTable
		{
			return this._info;
		}
		
		/*
		  the unique column id
		 */
		
		
		public function get id():String
		{
			
			return this._history.id;
		}
		
		/*
		  returns this column + all the child columns as an array
		 */
		
		public function get flattenedColumns():Array
		{
			function filter():Boolean
			{
				return true;
			}
			
			return this.filterColumns(filter);
			
		}
		
		
		
		/*
		 */
		
		public function get dataOptions():IList
		{
			return _columnDataOptions;
		}
		
		
		/*
		 */
		
		/* public function markRead(data:RenderedColumnData):void
		{
			_history.markRead(data);
			
		} */
		
		/*
		 */
		
		/* public function markAllRead():void
		{
			_history.markAllRead();
			
			
			//FIXME: move to to hist manager and listen for mark read
//			for each(var d:RenderedData in this.renderedData.toArray())
//			{
//				d.read = true;
//				dispatchEvent(new ColumnHistoryEvent(ColumnHistoryEvent.MARK_READ,d));
//			}
			
		 
		}*/
		
		/*
		 */
		
		[Bindable(event="numUnreadChange")]
		public function get numUnread():int
		{
			if(!_history)
				return 0;
				
			return _history.numUnread;
		}
		
		
		/*
		 */
		
		public function get viewClass():Class
		{
			return ClovePluginColumnDataView;
		}
		
		/*
		 */
		
		public function get history():IColumnHistory
		{
			return _history;	
		}
		
		/*
		 */
		
		/*public function getRowDriver(data:RenderedColumnData):ColumnDataDriver
		{
			this._driver.data = data;
			return this._driver;
		}*/

		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		
		
		/**
		 */
		
		public function getUID():String
		{
			return this._uid.getData();
		}
		
		/**
		 */
		
		public function getAvailableCalls():Vector.<String>
		{
			return this._proxy.getAvailableCalls();
		}
		
		/**
		 */
		
		public function getProxy():IProxy
		{
			return this._proxy.getProxy();
		}
		
		
		
		/**
		 */
		public function handleProxyResponse(n:INotification):void
		{
			
		}
		/**
		 */
		
		public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallCloveColumnType.GET_CHILDREN:
					_proxy.respond(call,this._children);
				break;
				case CallCloveColumnType.GET_DATA_PROVIDER:
					_proxy.respond(call,this._itemRenderer);
				break;
			}
		}
		
		
        /*
          clears data from a row
		 */
		
		public function clearData():void
		{
			_history.removeAllItems();
		}
		
		/*
		 */
		
		/*public function flushAllData():void
		{
			this._history.removeAllItems();
		}*/
		
		
		/*
		  sets additional information about a column that's used for 
		  some other function, such as column color
		 */
		
//		public function setMetaData(name:String,value:Object):void
//		{
//			this._info.saveSetting(name,value);
//			
//			
//		}
		
		/*
		 */
		
//		public function removeMetaData(name:String):void
//		{
//			this._info.removeSetting(name);
//			
//			this.save();
//		}
		
		/*
		  returns additional information about the column not used
		  particularely in the column, by the view
		  @param name the column view *use constant* ColumnMetaDataInfo
		 */
		
		public function getMetaData(name:String):*
		{
			return this._info.getSetting(name);
		}
        
        
        /*
          trashes rendered data from a row
          @param data the data to trash
		 */
		
		/*public function trashData(data:RenderedColumnData):void
		{
			//_history.trash(data);
			//_history.rem
		}*/
		
		
		
		/*
		  dispatches an event, along with a save request
		 */
		
		public function dispatchBubbleEvent(event:Event):void
		{
			save();
			
			dispatchEvent(event);
			
		}
		
		/*
		 */
		
		override public function dispatchEvent(event:Event):Boolean
		{
			
			//we ahve the parent listen for when the event is dispatched so that
			//the view can stop propogating
			if(this.parent && event.bubbles)
			{
				this.addEventListener(event.type,onEventBubble,false);
			}
			
			
			return super.dispatchEvent(event);
			
			
		}
		
		
		/*
		  bubbles a save request to the root 
		 */
		
		public function save():void
		{			
			dispatchEvent(new CloveColumnEvent(CloveColumnEvent.CHANGE,"save",this));
		}
		
		/*
		  filters all child columns based on a rule function given
		 */
		 
		
		public function filterColumns(rule:Function,funcPushes:Boolean = false):Array
		{
			var cols:Array = [];
			
			if(funcPushes)
			{
				rule(this,cols);	
			}else
			if(rule(this))
			{
				cols.push(this);
			}
			
			if(_children)
			{
				
				for each(var col:CloveColumn in this._children.toArray())
				{
					if(!col)
						continue;
					
					cols = cols.concat(col.filterColumns(rule,funcPushes));
				}
			}
			
			
			return cols;
		}
		
		/*
		  finds ONE column
		 */
		
		public function findColumn(rule:Function):CloveColumn
		{
			if(rule(this))
			{
				return this;
			}
			else
			{
				var ccol:CloveColumn;
				
				for each(var col:CloveColumn in this._children.toArray())
				{
					ccol = col.findColumn(rule);
					
					if(ccol)
					{
						return ccol;
					}
				}
			}
			
			return null;
		}
		
		/*
		  adds a display in the column row users can interact with to invoke a command set by this column
		  opt the data option
		 */
		
		
		/*public function addDataOption(opt:ColumnDataOption):void
		{
			
			this.janitor.addDisposable(opt);
			
			//don't re-add elements, which can happen for plugins
			for(var i:int = 0; i < this._columnDataOptions.length; i++)
			{
				var op:ColumnDataOption = this._columnDataOptions.getItemAt(i) as ColumnDataOption;
				
				
				
				if(op.name == opt.name)
				{
					
					//REMOVE the item because a menu item may be used multiple times accross plugins
					this._columnDataOptions.removeItemAt(i);
					break;
				}
			}
			
			this._columnDataOptions.addItem(opt);
			
		}*/
		
		
		/*
		 */
		
		/*public function getDataOption(name:String):ColumnDataOption
		{
			//FIXME: TEMP --- THROW IN HASH MAP
			
			for each(var item:ColumnDataOption in this._columnDataOptions.source)
			{
				if(item.name == name)
					return item;
			}
			
			return null;
		}*/
		
		/*
		  Clones the column
		 */
		
//		public function clone():CloveColumn
//		{
//			return CloveColumn.fromXML(this.toXML().toString());
//		}
		
		
		
		/**
		 * reads only THIS column info. this is needed for sync
		 */
		
		public function readColumnInfo(input:IDataInput):Object
		{
//			var inObj:Object = input.readObject();
//			
//			
//			var inf:ColumnSettings = ColumnSettings(inObj.info);
//			
//			if(inf)
//				this.setColumnInfo(inf);
//				
//			this._info.addEventListener(SettingChangeEvent.CHANGE,onMetadataChange,false,0,true);
//			
//			
//			this._storedControllerData = inObj.controllerInfo;
			
//			return inObj;
			return null;
		}
		
		
		
		
		
		/*
		  @private
		 */
		
		public function setHistoryController(controller:ColumnHistoryController):void
		{
			this.column_internal::historyController = controller;
		}
		
		
		
		
		/*
		 */
		
		public function removeFromParent():void
		{
			if(!_parent)
				return;
				
			var index:int = this._parent.children.getItemIndex(this);
			
			
			if(index > -1)
				this._parent.children.removeItemAt(index);
			
			_parent = undefined;
		}
		
		/**
		 */
		
		public function readExternal(input:IDataInput):void
		{
			//flag
		}
		
		/**
		 */
		
		public function writeExternal(output:IDataOutput):void
		{
			//flag
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function resetUID():void
		{
			var old:String = this._uid.getData();
			
			this._uid.setData(GUID.create());
			
			if(old)
			{
				this.dispatchEvent(new CloveColumnEvent(CloveColumnEvent.ADD_DELETE_COL_UID,this,true,old));
			}
			
		}
		
		/**
		 */
		protected function getProxyTarget():ProxyOwner
		{
			return this._proxy;
		}
		
		/**
		 */
		
		protected function setupAvailableProxyCalls():void
		{
			this._proxy.addAvailableCalls([CallCloveColumnType.GET_CHILDREN,
										   CallCloveColumnType.GET_DATA_PROVIDER,
										   CallCloveColumnType.GET_PARENT,
										   CallCloveColumnType.GET_ROOT]);
		}
		
		/*
		 */
		
		//override protected function dispose2():void
		public function dispose():void
		{
//			super.dispose2();
			
			if(!_proxy)
				return;
			
			this._janitor.dispose();
			
			
			while(this._children.length > 0)
			{
				this.children.getItemAt(0).dispose();
			}
			
			this._children.removeAll();

			
			if(this._history)
				this._history.dispose();
			
			
			this._proxy.dispose();
			this._info.dispose();
			_breadcrumb.dispose();
			this.removeFromParent();  
			
			
			
			this._proxy				= undefined;
			this._breadcrumb		= undefined;
			this._info     			= undefined;
			this._history  			= undefined;
			this._controller 		= undefined;
			this._columnDataOptions = undefined;
			this._parent            = undefined;
		}
		
		/*
		 */
		
		protected function setColumnInfo(value:SettingTable):void
		{
			this._info = value;
			
			this._title = StringSetting(value.getNewSetting(BasicSettingType.STRING,"title"));
			this._uid = StringSetting(value.getNewSetting(BasicSettingType.STRING,ColumnMetaData.COLUMN_UID));
			
			
			if(!this.getUID())
			{
				this.resetUID();
			}
			
			
			BooleanSetting(value.getNewSetting(BasicSettingType.BOOLEAN,ColumnMetaData.GROUP_EXPANDED)).setData(false);
			
//			this._settingManager.settings = value;
			
		}
		
		column_internal function setHistorySettings(value:ByteArray):void
		{
			this._storedControllerData = value;
		}
		
        /*
		 */
		
		column_internal function get historyManager():IColumnHistory
		{
			return this._history;
		}
		
        /*
		 */
		 
		column_internal function get historyController():ColumnHistoryController
		{
			return _controller;
		}
		
		
		/**
		 */
		
		column_internal function hasReadFromExternal():void
		{
			
		}
		
		/*
		 */
		
		column_internal function set historyController(value:ColumnHistoryController):void
		{
			//controller can only be set once
			
			
			if(!_controller)
			{
				_controller = value;
				
				
				if(!value)
					return;
					
				if(this._storedControllerData)
				{
					this._history = _controller.build(this,_storedControllerData);
					
					
					_storedControllerData = null;
					
				
				}
				else
				{	
					//hist manager may contain a UID the column uses to retrieve and save data
					//so the controller acts as a singleton to manage each column
					this._history = _controller.getHistManager(this);
					
					
				}
				
				
					
				//some of the children might not have a controller. such as groups added on plugin
				//installation
				
				for each(var child:CloveColumn in this.children.toArray())
				{
					child.column_internal::historyController = value;
				}
				
				
				
				//initialize the history so that we can traverse through everything
				this._history.init();  
				
				
				//				this.janitor.addDisposable(this._history);
				
				this._janitor.addEventListener(this._history,ColumnHistoryEvent.HISTORY_CHANGE,this.onHistoryChange,false,0,true);
				
				this.dispatchEvent(new CloveColumnEvent(CloveColumnEvent.CONTROLLER_SET,this,false));
			}
		}
		
		/*
		 */
		
		protected function onMetadataChange(target:CallbackObserver,n:SettingChangeNotification):void
		{
//			this.dispatchEvent(event.clone())
//			this;
			this.dispatchBubbleEvent(new ColumnMetaDataEvent(ColumnMetaDataEvent.DATA_CHANGE(n.getType()),null,this));
			
		}
		
		/*
		 */
		
		protected function onChildrenChange(event:CollectionEvent):void
		{
		
			var bubble:Boolean = true;
			
			switch(event.kind)
			{
				case CollectionEventKind.ADD:
					this.childAdded(event);
				break;
				case CollectionEventKind.REPLACE:
					this.childAdded(event);
				break;
				case CollectionEventKind.REMOVE:
					this.childRemoved(event);
					
				break;
				default:
					bubble = false;
				break;
			}
			
			if(bubble)
			{
				
				//NOTE the event caught does not have bubbles enabled, so we set it
				this.dispatchBubbleEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,true,false,event.kind,event.location,event.oldLocation,event.items));
			}
		}
		
		/*
		 */
		
		protected function childAdded(event:CollectionEvent):void
		{
			this.linkColumn(event.items[0]);
			
		}
		
		/*
		 */
		
		protected function childRemoved(event:CollectionEvent):void
		{
			this.delinkColumn(event.items[0]);
		}
		
        /*
          fills a column with data from a stack
          @param data the data stack (usually array) to add to the column
          @param save some 
		 */
		
		protected function fillColumn(data:Array,saveFlags:int = ColumnSaveType.FILL_NEW,loadingOlder:Boolean = false):void
		{
			if(this._history)
				this._history.addHistory(data,saveFlags,loadingOlder);
		}
	
		
        /*
          sets the parent column
		 */
		 
		protected function setParent(parent:CloveColumn,build:Boolean = true):void
		{
			if(_parent && _parent != parent)
				this.removeFromParent();
				
			if(parent)
			{
				column_internal::historyController = parent.column_internal::historyController;
			}
			
			_parent = parent;
			
		}
		
		
		/*
		  sends a single notification to 
		 */
		
		/*protected function notifyNewData(data:RenderedColumnData):void
		{
			
			//abstract
		}*/ 
		
		/*
		  sends a notification on any updated data providing the old, and new parts
		 */
		
		/* protected function notifyUpdatedData(data:ColumnHistoryUpdate):void
		{
			//abstract
		} */
		
		/*
		  sends a notification on new data that exceeds the max number
		  that can be shown at the same time
		  @param length the number of new items sent
		 */
		
		/* protected function notifySingleMessage(length:int):void
		{
			var not:NotificationEvent = new this.notificationClass(this.title,"There are a number of new items in Neem.") as NotificationEvent;
			
			new MultiDataNotification(not,length);
			
			not.dispatch();
		} */
		
		/*
		  dispatches a notification to the desktop
		 */
		
		/* protected function notify(title:String,message:String):void
		{
			new this.notificationClass(title,message).dispatch();
		} */
		
		/*
		 */
		
		protected function onHistoryChange(event:CollectionEvent):void
		{
			
			switch(event.kind)
			{
				case CollectionEventKind.ADD:
				case CollectionEventKind.UPDATE:
					this.onNewData(event);
				break;
			}
			
			dispatchEvent(event.clone());
			
		}
		 
		/*
		 */
		
		protected function onNewData(event:CollectionEvent):void
		{
			
			/* var notifyFunc:Function = event.kind == ColumnHistoryChangeKind.NEW_DATA ? notifyNewData : notifyUpdatedData;
			
			//if the the number of new items exceeds the max notifications, 
			//notify a simple Item
			if(event.responseArray.length < CloveColumn.NOTIFY_MAX)
			{
				for each(var rdata: in event.responseArray)
				{
				
					notifyFunc(rdata);	
				}
			}
			else
			{
				this.notifySingleMessage(event.responseArray.length);
			} */
			
			
			
		}
		
		
		/*
		  called once plugin is removed. This strips away any blank columns so the user doesn't
		  have to do it manually
		 */
		
		protected function disposeIfBlank():void
		{
			//check for parent. This will also serve as a block so the root cannot be removed
			if(this.children.length == 0 && this.parent)
			{
				var parent:CloveColumn = CloveColumn(this.parent);
				
				this.dispose();
				
				CloveColumn(parent.disposeIfBlank());
			}
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function linkColumn(column:CloveColumn):void
		{
			
			if(column)
			{
				column.setParent(this);
			}
			
			//tell the root to remove the UID from the trashed history if it exists
			this.dispatchEvent(new CloveColumnEvent(CloveColumnEvent.REMOVE_DELETE_COL_UID,this,true,column.getUID()));
			
//			this.janitor.addDisposable(column);
			
		}
		
		/*
		 */
		private function delinkColumn(column:CloveColumn):void
		{
			if(!column)
				return;
			
			
			column.setParent(undefined);
			
			//tell the root to add the UID to the trashed history 
			this.dispatchEvent(new CloveColumnEvent(CloveColumnEvent.ADD_DELETE_COL_UID,this,true,column.getUID()));
			
//			this.janitor.removeDisposable(column);
			
		}
		
		/*
		 */
		
		private function onEventBubble(event:*):void
		{
			event.target.removeEventListener(event.type,onEventBubble);
			
			this.parent.dispatchEvent(event.clone());
		}
		
		
		
		
		
		/*
		 */
		
		/*column_internal function linkRenderedData(rData:RenderedColumnData):void
		{
			//this is needed to remove any specific data from a given row
			rData.column_internal::setColumn(this);
			
		}*/
		
		
		private function onDisplayError(event:CloveColumnEvent):void
		{
			this.currentErrorMessage = event.data;
		}
		
		/*
		 */
		
		private function onLoadStateChange(event:CloveColumnEvent):void
		{
			if(event.targetColumn == this)
				return;
			
			
			for each(var child:CloveColumn in Object(this.children).source)
			{
				if(child.loadState == CueStateType.ERROR)
				{
					this.loadState = CueStateType.ERROR;
					return;
				}
				else
					if(child.loadState == CueStateType.LOADING)
					{
						this.loadState = CueStateType.LOADING;
						return;
					}
			}
			
			
			this.loadState = CueStateType.COMPLETE;
		}
		
	}
}