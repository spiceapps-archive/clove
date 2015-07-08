package com.spice.clove.plugin.impl.content.control
{
	import com.spice.clove.analytics.core.AnalyticsPluginHelper;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallCloveContentControllerType;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.column.ICloveColumn;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.notifications.FillColumnNotification;
	import com.spice.clove.plugin.core.views.content.ICloveContentPreferenceViewController;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionButtonViewController;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.core.queue.IQueue;
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyController;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCallObserver;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	import com.spice.vanilla.impl.proxy.responder.ReturnDataProxyResponder;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import mx.utils.StringUtil;

	public class CloveContentController extends ProxyOwner implements ICloveContentController
	{
		  
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _proxy:IProxyController;
		
		private var _plugin:ClovePlugin;
		
		
		
		private var _column:ICloveColumn;
		
		/**
		 * the factory name for this content controller. this is used to re-instantiate the controller
		 * after the application has been closed 
		 */		
		
		private var _factoryName:String;
		
		/**
		 * the icon rep of the content controller. this is displayed in the target column 
		 */		
		
		
		private var _contentName:String;
		
		private var _icon:*;
		private var _itemRenderer:ICloveDataRenderer;
		private var _prefViewController:ICloveContentPreferenceViewController;
		private var _dataOptionControllers:Vector.<IMenuOptionButtonViewController>
		private var _analyticsHelper:AnalyticsPluginHelper;
		
		private var _availableCalls:Vector.<String>;
		
		
		private var _settings:ISettingTable;
		
		private var _dataOrderBy:Object;
		
		private var _loadingState:int;
		
		private var _filter:StringSetting;
		private var _filters:Array = null;
		
		private var _getControllerPluginBind:ProxyCallObserver;
		
		
		internal var _loading:Boolean;
		private var _globalContentQueue:IQueue;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor 
		 * @param proxyController passed by the AbstractCloveServiceDelegateFactory. It contains a few
		 * additional details about the service delegate such as row views, column views, etc.
		 * 
		 */		
		
		public function CloveContentController(factoryName:String,
													   plugin:ClovePlugin,
													   itemRenderer:ICloveDataRenderer,
													   settings:ISettingTable = null)
		{
			this._itemRenderer = itemRenderer;
			
			_dataOptionControllers = new Vector.<IMenuOptionButtonViewController>();
			
			this._plugin 	  = plugin;
			this._factoryName = factoryName;
			this._dataOrderBy = {key:"datePosted",asc:false};
			_settings = settings || new SettingTable(BasicSettingFactory.getInstance());
			
			//set the 16 px icon
			this.setIcon16(plugin.getPluginFactory().getIcon16());
			
			
			//get the global content controller queue so we don't load everything at once
			this._globalContentQueue = ProxyCallUtils.getFirstResponse(CallAppCommandType.GET_GLOBAL_CONTENT_LOADER_QUEUE,plugin.getPluginMediator());
			
			//YUCK  
			this._getControllerPluginBind = new ProxyCallObserver(new ReturnDataProxyResponder(this,CallClovePluginType.GET_LOADED_CONTENT_CONTROLLERS));
			
			this._plugin.getProxyController().addProxyCallObserver(this._getControllerPluginBind);
			  
			plugin.linkNewContentController(this);
			//plugin.answerProxyCall(CallClovePluginType.NEW_CONTENT_CONTROLLER,this);
			
			
			_filter = _settings.getNewSetting(BasicSettingType.STRING,CloveContentControllerSettingType.FILTER) as StringSetting;
			
			_filter.addObserver(new CallbackObserver(SettingChangeNotification.CHANGE,onFilterChange));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			
			switch(call.getType())
			{
				case CallCloveContentControllerType.GET_NAME: 		   return this.respond(call,this.getName());
				case CallCloveContentControllerType.SET_COLUMN:	       return this.setColumn(call.getData());
				case CallCloveContentControllerType.LOAD_OLDER:        return this.loadOlder(call.getData());
				case CallCloveContentControllerType.LOAD_NEWER: 	   return this.loadNewer(call.getData());
				case CallCloveContentControllerType.GET_PLUGIN:		   return this.respond(call,this._plugin);
				case CallCloveContentControllerType.GET_ICON_16:       return this.respond(call,this.getIcon16());
				case CallCloveContentControllerType.GET_SETTINGS: 	   return this.respond(call,this._settings);
				case CallCloveContentControllerType.GET_FACTORY_NAME:  return this.respond(call,this._factoryName);
				case CallCloveContentControllerType.GET_LOADING_STATE: return this.respond(call,this._loadingState);
				case CallCloveContentControllerType.GET_DATA_ORDER_BY: return this.respond(call,this._dataOrderBy);
				case CallCloveContentControllerType.GET_ITEM_RENDERER: return this.respond(call,this.getItemRenderer());
				case CallCloveContentControllerType.GET_DATA_OPTION_CONTROLLERS: return this.respond(call,this.getDataOptionControllers());
				case CallCloveContentControllerType.GET_PREFERENCE_VIEW_CONTROLLER: return this.respond(call,this._prefViewController);
			}
		}
		
		/**
		 */
		
		public function getFilters():Array
		{
			return this._filters;
		}
		
		/**
		 */
		
		public function hasFilters():Boolean
		{
			return this._filters != null;
		}
		
		
		
		
		/**
		 */
		public function getPlugin():ClovePlugin
		{
			return this._plugin;
		}
		
		/**
		 */
		public function addDataOptionController(controller:IMenuOptionButtonViewController):void
		{
			_dataOptionControllers.push(controller);
			
			this.notifyChange(CallCloveContentControllerType.GET_DATA_OPTION_CONTROLLERS,_dataOptionControllers);
		}
		
		
		/**
		 */
		public function getDataOptionControllers():Vector.<IMenuOptionButtonViewController>
		{
			return this._dataOptionControllers;
		}
		
		
		/**
		 */
		public function getLoadingState():int
		{
			return this._loadingState;
		}
		
		/**
		 */
		
		public function setLoadingState(value:int):void
		{
			this._loadingState = value;
			
			this.notifyChange(CallCloveContentControllerType.GET_LOADING_STATE,value);
		}
		
		
		
		/**
		 */
		
		public function getDataOrderBy():Object
		{
			return this._dataOrderBy;
		}
		
		/**
		 */
		
		public function setDataOrderBy(value:Object):void
		{
			this._dataOrderBy = value;
			
			this.notifyChange(CallCloveContentControllerType.GET_DATA_ORDER_BY,value);
		}
		
		/**
		 */
		
		final public function loadOlder(data:ICloveData = null):void
		{
			this.setLoadingState(CloveContentControllerState.LOADING);
			
			
			if(this._loading)
				return;
			
			this._loading = true;
			
			this.loadOlder2(data);
			
//			this._globalContentQueue.addCue(new ContentControllerCue(this,data,true));
		}
		
		/**
		 */
		
		internal function internalLoadOlder(data:ICloveData = null):void
		{			
			this.loadOlder2(data);
		}
		
		/**
		 */
		
		final public function loadNewer(data:ICloveData = null):void
		{
			this.setLoadingState(CloveContentControllerState.LOADING);
			//abstract
			
			if(this._loading)
				return;
			
			this._loading = true;
			
			
			this.loadNewer2(data);
//			this._globalContentQueue.addCue(new ContentControllerCue(this,data));
		}
		
		/**
		 */
		
		internal function internalLoadNewer(data:ICloveData = null):void
		{
			this.loadNewer2(data);
		}
		
		/**
		 */
		
		final public function getIcon16():*
		{
			return _icon;
		}
		
		
		/**
		 */
		public function setIcon16(value:*):void
		{
			_icon = value;
			
			this.notifyChange(CallCloveContentControllerType.GET_ICON_16,value);
		}
		
		
		/**
		 */
		
		final public function getSettings():ISettingTable
		{
			return this._settings;
		}
		
		/**
		 */
		
		final public function getColumn():ICloveColumn
		{
			return this._column;
		}
		
		/**
		 */
		
		public function setColumn(value:ICloveColumn):void
		{
			this._column = value;
			
			
			this.notifyChange(CallCloveContentControllerType.SET_COLUMN,value);
		}
		
		/**
		 */
		
		final public function getName():String
		{
			return this._contentName;
		}
		
		/**
		 */
		
		final public function getFactoryName():String
		{
			return this._factoryName;
		}
		
		/**
		 */
		
		
		public function setName(value:String):void
		{
			this._contentName = value;
			
			this.notifyChange(CallCloveContentControllerType.GET_NAME,value);
		}
		
		/**
		 */
		
		final public function getItemRenderer():ICloveDataRenderer
		{
			return this._itemRenderer;
		}
		
		/**
		 */
		
		public function setItemRenderer(value:ICloveDataRenderer):void
		{
			this._itemRenderer = value;
			
			
			this.notifyChange(CallCloveContentControllerType.GET_ITEM_RENDERER,value);
		}
		
		/**
		 */
		
		final public function getPreferenceViewController():ICloveContentPreferenceViewController
		{
			return this._prefViewController;
		}
		
		/**
		 */
		
		public function setPreferenceViewController(value:ICloveContentPreferenceViewController):void
		{
			this._prefViewController = value;
			
			this.notifyChange(CallCloveContentControllerType.GET_PREFERENCE_VIEW_CONTROLLER,value);
		}
		
		
		/**
		 */
		
		override public function dispose():void
		{
			
			this.notifyChange(CallCloveContentControllerType.DISPOSED);
			
			this._plugin.getProxy().unbindObserver(this._getControllerPluginBind);
			
			super.dispose();
		}
		
		
		/**
		 */
		
		public function fillColumn(data:Array,saveType:int = ContentSaveType.FILL_NEW):void
		{
			
			this.setLoadingState(CloveContentControllerState.COMPLETE);
			this._loading = false;
			
			if(data.length == 0)
				return;
			
			this.notifyBoundObservers(new FillColumnNotification(data,saveType));
			
			
		}
		
		
		/**
		 */
		
		public function recordAnalayticalData(name:String,content:String,count:int = 1,metadata:Object = null):void
		{
			metadata = metadata || {};
			
			metadata['serviceName'] = this._plugin.getDisplayName();
			metadata['contentType'] = this._factoryName;
			
			this.getAnalayticsPluginHelper().recordAction(name,content,count,metadata);
		}
		
		
		/**
		 */
		
		public function setBreadcrumb(controller:ICloveContentController):void
		{
			
			
			this.notifyChange(CallCloveContentControllerType.GET_BREADCRUMB,controller);
		}
		
		
		
		/**
		 * tells the column view to display an error message
		 */
		
		public function showErrorMessage(name:String):void
		{
			this.notifyChange(CallCloveContentControllerType.DISPLAY_ERROR_MESSAGE,name);
			
			this.setLoadingState(CloveContentControllerState.ERROR);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		protected function loadNewer2(data:ICloveData = null):void
		{
			//abstract
		}
		
		/**
		 */
	
		protected function loadOlder2(data:ICloveData = null):void
		{
			//abstract
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallCloveContentControllerType.GET_COLUMN_VIEW_FACTORY,
								    CallCloveContentControllerType.GET_FACTORY_NAME,
									CallCloveContentControllerType.GET_ITEM_RENDERER,
									CallCloveContentControllerType.GET_ITEM_RENDERER,
									CallCloveContentControllerType.GET_PLUGIN,
									CallCloveContentControllerType.DISPLAY_ERROR_MESSAGE,
									CallCloveContentControllerType.GET_ICON_16,
									CallCloveContentControllerType.GET_PREFERENCE_VIEW_CONTROLLER,
									CallCloveContentControllerType.GET_DATA_OPTION_CONTROLLERS,
									CallCloveContentControllerType.GET_SETTINGS,
									CallCloveContentControllerType.GET_NAME,
									CallCloveContentControllerType.LOAD_NEWER,
									CallCloveContentControllerType.LOAD_OLDER,
									CallCloveContentControllerType.GET_LOADING_STATE,
									CallCloveContentControllerType.GET_DATA_ORDER_BY,
									CallCloveContentControllerType.SET_COLUMN,
									CallCloveContentControllerType.SET_BREADCRUMB,
									CallCloveContentControllerType.GET_BREADCRUMB,
									CallCloveContentControllerType.REMOVE_CONTENT,
									CallCloveContentControllerType.RESET_UID]);
		}
		
		
		
		/**
		 */
		
		protected function getAnalayticsPluginHelper():AnalyticsPluginHelper
		{
			if(!this._analyticsHelper)
			{
				this._analyticsHelper = new AnalyticsPluginHelper(this._plugin.getPluginMediator());
			}
			
			return this._analyticsHelper;
		}
		
		/**
		 */  
		
		protected function onFilterChange(target:CallbackObserver,event:SettingChangeNotification):void
		{
			//filters are separated by comma
			_filters = this._filter.getData().split(",");
			this.removeAllContent(true);
			
			
			for(var i:int = 0, n:int = _filters.length; i < n;  i++)
			{
				_filters[i] = StringUtil.trim(_filters[i]).toLowerCase();
			}
			
			for each(var filter:String in this._filters)
			{
				if(filter.match(/[^\s]/))
					return;
			}
			
			this._filters = null;
			
		}
		
		
		/**
		 * tells the column, or any listener we want to load this controller, as well as
		 */
		
		protected function loadContent():void
		{     
			this.notifyChange(CallCloveContentControllerType.LOADING_CONTENT);
			
			
			
		}
		
		
		/**
		 */
		
		protected function removeAllContent(removeDeleted:Boolean = false):void
		{  
			this.notifyChange(CallCloveContentControllerType.REMOVE_CONTENT,removeDeleted);
		}
		
		
		/**
		 */
		
		protected function resetUID():void
		{
			this.notifyChange(CallCloveContentControllerType.RESET_UID);
		}
		
	}
}