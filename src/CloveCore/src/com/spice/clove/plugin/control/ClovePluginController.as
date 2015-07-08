package com.spice.clove.plugin.control
{
	import com.spice.clove.events.plugin.PluginControllerEvent;
	import com.spice.clove.plugin.core.IClovePlugin;
	import com.spice.clove.plugin.core.calls.*;
	import com.spice.clove.plugin.load.InstalledPluginInfo;
	import com.spice.commands.init.InitCommand;
	import com.spice.events.QueueManagerEvent;
	import com.spice.impl.utils.DescribeTypeUtil;
	import com.spice.utils.queue.global.GlobalQueueManager;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.core.plugin.settings.IPluginSettings;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.plugin.AbstractPluginController;
	import com.spice.vanilla.impl.plugin.calls.CallPluginType;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.lists.ProxyCallList;
	import com.spice.vanilla.impl.proxy.mediator.ProxyMediator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;


	public class ClovePluginController extends AbstractPluginController  implements IProxyResponder,
																					IProxyResponseHandler, 
																					IProxyBinding, 
																					IEventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * the plugin being controlled 
		 */		
		
		private var _plugin:IClovePlugin;
		
		
		/**
		 * info used to initialize the plugin
		 */
		
		private var _pluginInfo:InstalledPluginInfo;
		
		/**
		 * set when the plugin is initialized 
		 */		
		
		private var _pluginInitialized:Boolean;
		
		
		/**
		 */
		
		private var _hasAccount:Boolean;
		
		
		/**
		 */
		
		private var _eventDispatcher:IEventDispatcher;
		
		
		/**
		 * set when THIS controller is initialized
		 */
		
		private var _pluginFactoryClass:Class;
		private var _controllerInitialized:Boolean;
		private var _settings:ISettingTable;
		private var _availableContentControllers:Vector.<String>;
		protected var _pluginSettingsObserver:ClovePluginSettingsObserver;
		private var _pluginProxyCallList:ProxyCallList;
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		public var displayName:String;
		
		[Bindable] 
		public var pluginName:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ClovePluginController(plugin:InstalledPluginInfo,settings:ISettingTable)
		{
			super(plugin.loadedPlugin,this.mediator);
			
			
			_eventDispatcher = new EventDispatcher(this);
			
			_settings = settings;
			_pluginInfo = plugin;
			
			_pluginFactoryClass = DescribeTypeUtil.getDefinitionByName(plugin.factoryClass);
			_pluginProxyCallList = new ProxyCallList(this);
			
			//listen for when the application completes so we can tell the plugins
			GlobalQueueManager.getInstance().getQueueManager(InitCommand.INIT_QUEUE).addEventListener(QueueManagerEvent.QUEUE_COMPLETE,onApplicationInitialized);
			
		
			this.getProxyController().setProxyMediator(this.mediator);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get plugin():IPlugin
		{
			return this._plugin;
		}
		
		
		/**
		 */
		
		public function get pluginFactoryClass():Class
		{
			return  this._pluginFactoryClass;
		}
		
		/**
		 */
		
		public function get uid():String
		{
			if(!_plugin)
				return null;  
			
			return this._plugin.getUID();
		}
		
		
		/**
		 */
		
		[Bindable("mediatorChange")]
		public function get mediator():ProxyMediator
		{
			return ClovePluginMediator.getInstance();
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getPluginFactory():IPluginFactory
		{
			return this._pluginInfo.installedPluginFactoryInfo.loadedPluginFactory;
		}
		
		/**
		 */
		
		public function getPluginInfo():InstalledPluginInfo
		{
			return this._pluginInfo;
		}
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallClovePluginControllerType.GET_PLUGIN: return this.respond(call,this._plugin);
				case CallClovePluginControllerType.GET_PLUGIN_UID: return this.respond(call,this.uid);
				case CallClovePluginControllerType.GET_PLUGIN_FACTORY_PATH: return this.respond(call,DescribeTypeUtil.getClassPath(this._pluginFactoryClass));
				case CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_UID:
					if(call.getData() == this.uid)
					{
						this.respond(call,this);
					}
					return;
				case CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_WITH_CONTENT_CONTROLLERS:
					if(_availableContentControllers && _availableContentControllers.length > 0)
					{
						this.respond(call,this);
					}
					return;
				case CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_WITH_ACCOUNT:
					if(this._hasAccount)
					{
						this.respond(call,this);
					}
					return;
					
				case CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_PLUGIN_FACTORY_PATH:
					if(DescribeTypeUtil.getClassPath(this._pluginFactoryClass) == call.getData())
					{
						this.respond(call,this);
					}
					return;
				case CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_PLUGIN_FACTORY_CLASS:
					if(this.pluginFactoryClass == call.getData())
					{
						this.respond(call,this);
					}
					return;
				
			}
			
			
			super.answerProxyCall(call);
		}
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallClovePluginType.GET_AVAILABLE_CONTENT_CONTROLLERS:
					_availableContentControllers = n.getData();
					return;
				case CallPluginType.INITIALIZE:
					this._pluginInitialized = true;
					this.finish();
					return;
				case CallClovePluginType.GET_DISPLAY_NAME:
					this.displayName = n.getData();
					return;
				case CallClovePluginFactoryType.HAS_USER_ACCOUNT:
					this._hasAccount = n.getData();
				break;
				case CallClovePluginType.GET_NAME:
					this.pluginName = n.getData();
					
					if(!this.displayName)
					{
						this.displayName = this.pluginName;
					}
					return;
				case CallClovePluginType.GET_SETTINGS: return this.setPluginSettings(n.getData());
				return;
			}
			
			super.handleProxyResponse(n);
		}
		
		
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			this.handleProxyResponse(n);
		}
		
		
		/**
		 */
		
		override public function initialize():void
		{
			
			_plugin = IClovePlugin(_pluginInfo.loadedPlugin);
			
			
			_pluginProxyCallList.setProxy(_plugin.getProxy());
			
			_pluginProxyCallList.call(CallClovePluginType.GET_AVAILABLE_CONTENT_CONTROLLERS,null,this);
			_pluginProxyCallList.call(CallClovePluginType.GET_DISPLAY_NAME,null,this);
			_pluginProxyCallList.call(CallClovePluginType.GET_NAME,null,this);
			_pluginProxyCallList.call(CallClovePluginType.GET_SETTINGS,null,this);
			
			ProxyCallUtils.quickCall(CallClovePluginFactoryType.HAS_USER_ACCOUNT,_pluginInfo.installedPluginFactoryInfo.loadedPluginFactory.getProxy(),null,this);
			
			super.initialize();
		
			
		}
		
		/**
		 */
		
		public function uninstall():void
		{
			this.notifyChange(CallClovePluginControllerType.PLUGIN_CONTROLLER_IS_UNINSTALLING,true);
		}
		
		/**
		 */
		
		public function dispatchEvent(e:Event):Boolean
		{
			return this._eventDispatcher.dispatchEvent(e);
		}
		
		/**
		 */
		
		public function addEventListener(type:String,listener:Function,useCapture:Boolean = false,priority:int = 0,useWeakReference:Boolean = false):void
		{
			this._eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		
		/**
		 */
		
		public function removeEventListener(type:String,listener:Function,useCapture:Boolean = false):void
		{
			this._eventDispatcher.removeEventListener(type,listener,useCapture);
		}
		
		/**
		 */
		
		public function hasEventListener(type:String):Boolean
		{
			return this._eventDispatcher.hasEventListener(type);
		}
		
		/**
		 */
		
		public function willTrigger(type:String):Boolean
		{
			return this._eventDispatcher.willTrigger(type);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallClovePluginControllerType.GET_PLUGIN_MEDAITOR,
				CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_UID,
				CallClovePluginControllerType.GET_PLUGIN_UID,
				CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_WITH_CONTENT_CONTROLLERS,
				CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_PLUGIN_FACTORY_CLASS,
				CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_PLUGIN_FACTORY_PATH,
				CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_WITH_ACCOUNT,
				CallClovePluginControllerType.GET_PLUGIN,
				CallClovePluginControllerType.PLUGIN_CONTROLLER_IS_UNINSTALLING,
				CallClovePluginControllerType.GET_PLUGIN_FACTORY_PATH]);
		}
		
		/**
		 */
		
		override public function dispose():void
		{
			if(this._plugin is IDisposable)
			{
				IDisposable(_plugin).dispose();
			}
		}
		
		
		
		/**
		 */
		override protected function finish():void
		{
			if(!this._pluginInitialized)
			{
				throw new Error("Cannot initialize until the target plugin is ready.");
			}
			
			if(this._controllerInitialized)
			{
				throw new Error("Cannot finish plugin controller twice.");
			}
			
			this._controllerInitialized = true;
			
			
			this.dispatchEvent(new PluginControllerEvent(PluginControllerEvent.PLUGIN_INITILIZED));
			
			super.finish();
		}
		
		
		/**
		 */
		
		protected function setPluginSettings(value:IPluginSettings):void
		{
			
			if(this._pluginSettingsObserver)
			{
				this._pluginSettingsObserver.dispose();
			}
			
			_pluginSettingsObserver = new ClovePluginSettingsObserver(value,this._settings);
		}
		/**
		 */
		
		protected function onApplicationInitialized(event:QueueManagerEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onApplicationInitialized);
			
			
			this._pluginProxyCallList.call(CallClovePluginType.APPLICATION_INITIALIZE);
		}
	}
}