package
{
	
	import com.spice.air.utils.sql.manage.SQLiteTableMetadataManager;
	import com.spice.clove.analytics.core.AnalyticalActionType;
	import com.spice.clove.analytics.core.AnalyticsPluginHelper;
	import com.spice.clove.analytics.core.AnalyticsTimer;
	import com.spice.clove.analytics.core.calls.CallAnalyticsPluginType;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.fantasyVictory.impl.FantasyVictoryPluginFactory;
	import com.spice.clove.gdgt.impl.GDGTPlugin;
	import com.spice.clove.gdgt.impl.GDGTPluginFactory;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.models.CloveAIRModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.analytics.impl.AnalyticsPluginFactory;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.installer.CloveInstallerPluginFactory;
	import com.spice.clove.plugin.core.installer.CloveStartupInstallerPlugin;
	import com.spice.clove.plugin.core.installer.CloveStartupInstallerPluginFactory;
	import com.spice.clove.plugin.core.metadata.impl.MetadataPluginFactory;
	import com.spice.clove.plugin.core.post.desktop.DesktopPostPlugin;  
	import com.spice.clove.plugin.core.post.desktop.DesktopPostPluginFactory;
	import com.spice.clove.plugin.core.root.desktop.CloveDesktopRootPluginFactory;
	import com.spice.clove.plugin.core.sceneSync.desktop.SceneSyncDesktopPlugin;
	import com.spice.clove.plugin.core.sceneSync.desktop.SceneSyncDesktopPluginFactory;
	import com.spice.clove.plugin.core.sceneSync.flex.FXSceneSyncPluginFactory;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.spice.clove.plugin.core.textCommands.impl.TextCommandsPlugin;
	import com.spice.clove.plugin.core.textCommands.impl.TextCommandsPluginFactory;
	import com.spice.clove.plugin.core.urlExpander.impl.URLExpanderFactory;
	import com.spice.clove.plugin.core.urlShortener.impl.UrlShortenerPlugin;
	import com.spice.clove.plugin.core.urlShortener.impl.UrlShortenerPluginFactory;
	import com.spice.clove.plugin.install.*;
	import com.spice.clove.plugin.load.InternalInstalledPluginFactoryInfo;
	import com.spice.clove.plugin.youtube.impl.CloveYoutubePluginFactory;
	import com.spice.clove.proxy.CloveMenuProxyTarget;
	import com.spice.clove.proxy.CloveRegisteredViewsProxyTarget;
	import com.spice.clove.rss.flex.FXRSSPluginFactory;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncPluginType;
	import com.spice.clove.twitter.desktop.CloveTwitterDesktopPluginFactory;
	import com.spice.commands.init.InitCommand;
	import com.spice.core.events.log.LogEvent;
	import com.spice.events.QueueManagerEvent;
	import com.spice.impl.utils.logging.Log;
	import com.spice.utils.queue.global.GlobalQueueManager;
	import com.spice.utils.storage.persistent.*;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCallObserver;
	import com.spice.vanilla.impl.proxy.ProxyResponseObserver;
	import com.spice.vanilla.impl.proxy.responder.ReturnDataProxyResponder;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.BrowserInvokeEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	
	//?#PHP_IMPORTS
	
	/*
	we use this class to initialze data in the constructor since MXML doesn't automatically remove unused classes 
	@author craigcondon
	
	*/	
	
	[Event("complete")]
	[Event("closing")]
	
	public class CloveBootstrap extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:CloveModelLocator;
		
		public var completed:Boolean;
		
		
		
		private var _analytics:AnalyticsPluginHelper;
		private var _liveTimer:AnalyticsTimer;
		private var _args:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		
		public function CloveBootstrap()
		{
			NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE,onBrowserInvoke);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function init():void
		{
			_analytics = new AnalyticsPluginHelper(ClovePluginMediator.getInstance());
			_liveTimer = new AnalyticsTimer(_analytics,AnalyticalActionType.APPLICATION_LIVE_TIME);
			_liveTimer.startTimer();
			
//			Alert.show(NativeApplication.nativeApplication.applicationID+" "+NativeApplication.nativeApplication.publisherID);
			
			_model = CloveModelLocator.getInstance();
			
			ClovePluginMediator.getInstance().addProxyCallObserver(new ProxyCallObserver(new ReturnDataProxyResponder('//?#CLOVE_UPDATE_URL',CallAppCommandType.GET_UPDATE_URL)));
			
			
			//causes a long startup duration
			if(_model.applicationSettings.mainUISettings.checkForUpdatesOnStartup)
				new CloveEvent(CloveEvent.CHECK_UPDATE).dispatch();
			
			//innaproriate location for storing log information, but it's OKAY for now since it doesn't screwn anything up :)
			var logger:Logger = Logger.getInstance();
			logger.getLogger(LogType.ERROR).addEventListener(LogEvent.NEW_LOG,onErrorLog);
			logger.getLogger(LogType.FATAL).addEventListener(LogEvent.NEW_LOG,onErrorLog);
			logger.getLogger(LogType.WARNING).addEventListener(LogEvent.NEW_LOG,onErrorLog);
			logger.getLogger(LogType.UNCAUGHT_ERROR).addEventListener(LogEvent.NEW_LOG,onUncaughtErrorLog);
			
			
			
			new CloveRegisteredViewsProxyTarget();
			new CloveMenuProxyTarget();
			
			//			UIComponent(Application.application).callLater(AsyncUtil.init,[DisplayObject(Application.application)]);
			//			test.addItem(new RenderedColumnData());
			
			
			
			//initializes AIR propertiesoauthb
			CloveAIRModelLocator.getInstance();
			
			
			
			var corePlugins:Array = new Array();  
			  
			
			//GLOBAL
			
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Root",Singleton.getInstance(CloveDesktopRootPluginFactory)));
			//			corePlugins.push(new InternalInstalledPluginFactoryInfo("Nectars",new CloveNectarsPluginFactory()));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Text Command",Singleton.getInstance(TextCommandsPluginFactory)));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("URL Shortener",Singleton.getInstance(UrlShortenerPluginFactory)));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("URL Expander",Singleton.getInstance(URLExpanderFactory)));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Post",Singleton.getInstance(DesktopPostPluginFactory)));
			//			corePlugins.push(new InternalInstalledPluginFactoryInfo("Twitpic",new TwitpicPluginFactory()));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Analytics",Singleton.getInstance(AnalyticsPluginFactory)));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Scene Sync",Singleton.getInstance(SceneSyncDesktopPluginFactory)));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Metadata",Singleton.getInstance(MetadataPluginFactory)));
//			corePlugins.push(new InternalInstalledPluginFactoryInfo("AS Notifications",Singleton.getInstance(ASNotificationsPluginFactory)));
			
			//?#ADD_OPTIONAL_PLUGINS
			corePlugins.push(new InternalInstalledPluginFactoryInfo("RSS", Singleton.getInstance(FXRSSPluginFactory)));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Youtube", Singleton.getInstance(CloveYoutubePluginFactory)));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Twitter", Singleton.getInstance(CloveTwitterDesktopPluginFactory)));
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Fantasy Victory", Singleton.getInstance(FantasyVictoryPluginFactory)));
//			corePlugins.push(new InternalInstalledPluginFactoryInfo("Bing", Singleton.getInstance(BingPluginFactory)));
//			corePlugins.push(new InternalInstalledPluginFactoryInfo("GDGT",Singleton.getInstance(GDGTPluginFactory)));
			
			corePlugins.push(new InternalInstalledPluginFactoryInfo("Installer", Singleton.getInstance(CloveStartupInstallerPluginFactory)));
			
			
			
			_model.corePluginModel.corePlugins.addAll(new ArrayCollection(corePlugins));
			
			
			
			Logger.showTraces(true);
			
			GlobalQueueManager.getInstance().getQueueManager(InitCommand.INIT_QUEUE).addEventListener(QueueManagerEvent.QUEUE_COMPLETE,onApplicationInitialized);
			
			
			Application.application.nativeWindow.addEventListener(Event.CLOSING,onApplicationClosing,false,0,true);
			
			
			
			new CloveEvent(CloveEvent.INITIALIZE).dispatch();
		}
		
		
		
		/**
		 */
		
		private function onApplicationInitialized(event:QueueManagerEvent):void
		{   
			var i:int = 0;
			
			
			
			this._analytics.recordStartDateAction(AnalyticalActionType.APPLICATION_OPENED);
			this.completed = true;
			this.execArgs();
			
			
			//start / stop self loading
			ProxyCallUtils.quickCall(CallClovePluginType.IS_SELF_LOADING,ClovePluginMediator.getInstance(),this._model.applicationSettings.mainUISettings.loadAllGroups);
			
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onErrorLog(event:LogEvent):void
		{
			//dispatch ALL errors to the server, so we're notified when a problem occurs 
			try
			{
				if(event.log.metadata)
				{    
					CloveService.getInstance().logError(Error(event.log.metadata));
				}  
				
				//catch any errors the might occur so we don't sent the error log in to an infinite loop
			}catch(e:Error)
			{
				trace(e);
			}
		}
		
		
		/**
		 */
		
		private function onBrowserInvoke(event:BrowserInvokeEvent):void
		{
			
			if(!_args)
				_args = [];
			
			_args = _args.concat(event.arguments);
			
			
			
			this.execArgs();
		}
		
		
		/**
		 */
		
		private function execArgs():void
		{
			
			if(!this.completed || !this._args)
				return;
			
			
			for each(var arg:String in _args)
			{
				ProxyCallUtils.quickCall(arg,ClovePluginMediator.getInstance());
			}
			
			this._args = [];
		}
		
		/**
		 */
		
		private function onUncaughtErrorLog(event:LogEvent):void
		{
			//dispatch ALL errors to the server, so we're notified when a problem occurs 
			try
			{
				if(event.log.metadata)
				{  
					CloveService.getInstance().logError(Error(event.log.metadata),true);
				}
				
				//catch any errors the might occur so we don't sent the error log in to an infinite loop
			}catch(e:Error)
			{
				trace(e);
			}
		}
		
		/**
		 */  
		
		private function onApplicationClosing(event:Event):void
		{
			this.dispatchEvent(new Event(Event.CLOSING));
			
			
			event.preventDefault()
			event.currentTarget.removeEventListener(event.type,onApplicationClosing);
									
			_liveTimer.stopAndRecordTime();
			
			flash.utils.setTimeout(onSentToServer,1000);
		}
		
		
		/**
		 */
		
		private function onSentToServer():void
		{
			
			NativeApplication.nativeApplication.exit();
		}
		
		
		
		
	}
}