package
{

	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.controls.CloveCoreController;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.install.*;
	import com.spice.clove.plugin.twitter.impl.CloveTwitterPluginFactory;
	import com.spice.clove.plugin.youtube.impl.CloveYoutubePluginFactory;
	import com.spice.clove.proxy.CloveRegisteredViewsProxyTarget;
	import com.spice.clove.web.plugin.root.WebRootPlugin;
	import com.spice.clove.web.plugin.root.WebRootPluginFactory;
	import com.spice.plugin.helloWorld.impl.HelloWorldPluginFactory;
	import com.spice.utils.storage.persistent.*;
	
	import mx.collections.ArrayCollection;

	/*
	  we use this class to initialze data in the constructor since MXML doesn't automatically remove unused classes 
	  @author craigcondon
	  
	 */	
	public class CloveBootstrap
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable] 
		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		
		[Table(voClass="com.spice.clove.plugin.column.render.RenderedColumnData")]
		public var test:ArrayCollection = new ArrayCollection();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */

		
		public function CloveBootstrap()
		{
			new CloveCoreController()
			new CloveRegisteredViewsProxyTarget();
//			test.addItem(new RenderedColumnData());
			
			if(_model.applicationSettings.mainUISettings.checkForUpdatesOnStartup)
				new CloveEvent(CloveEvent.CHECK_UPDATE).dispatch();
			
			  
			_model.corePluginModel.corePlugins.addAll(new ArrayCollection([WebRootPluginFactory/*CloveServicePluginFactory*/,CloveYoutubePluginFactory, CloveTwitterPluginFactory, HelloWorldPluginFactory /*,CloveInstallerPluginFactory*//*,SyncPluginFactory*/]));
			
			var logger:Logger = Logger.getInstance();
			
			
			/*logger.registerLogger(new FileLogger(LogType.NOTICE,"Notice.log",true,true,false));
			logger.registerLogger(new FileLogger(LogType.WARNING,"Warning.log",true,true,false));
			logger.registerLogger(new FileLogger(LogType.ERROR,"Error.log",true,true,false));
			logger.registerLogger(new FileLogger(LogType.FATAL,"Fatal.log",true,true,false));*/
			
			
			//track any bugs sent from Clove
			/*AloeBugTracker.getInstance().project = 2; //1 = clove
			AloeBugTracker.monitor(logger.getLogger(LogType.ERROR));
			AloeBugTracker.monitor(logger.getLogger(LogType.FATAL));
			AloeBugTracker.monitor(logger.getLogger(LogType.WARNING));
			AloeBugTracker.monitor(logger.getLogger(LogType.NOTICE));*/
			
			
			/*new SQLiteTableMetadataManager(FileUtil.resolvePath(File.applicationStorageDirectory,"dbtest.db"),this);
			
			
			*/
			
			Logger.showTraces(true);
			
			/*Logger.showTraces(false);
			Logger.showTraces(true,LogType.MEMORY);*/
			
			
//			var t:CloveTwitterPluginFactory;
//			var x:CloveGDGTPluginFactory;
//			var c:DiggPluginFactory;
//			var d:CloveFacebookPluginFactory;
//			var e:CloveRSSPluginFactory;
//			var z:CloveBestBuyPluginFactory;
			
			//_model.installModel.addInstaller(new AvailableInternalService("Youtube",new CloveYoutubeDesktopPluginFactory()));
			if(false)
			{
				
				//turn this into a mediator call
				_model.installModel.addInstaller(new AvailableInternalService("Twitter",new CloveTwitterPluginFactory()));
				_model.installModel.addInstaller(new AvailableInternalService("Digg",new DiggPluginFactory()));
				_model.installModel.addInstaller(new AvailableInternalService("Facebook",new CloveFacebookPluginFactory())); 
				_model.installModel.addInstaller(new AvailableInternalService("RSS",new CloveRSSPluginFactory())); 
				_model.installModel.addInstaller(new AvailableInternalService("GDGT",new CloveGDGTPluginFactory())); 
				_model.installModel.addInstaller(new AvailableInternalService("Best Buy",new CloveBestBuyPluginFactory()));   
	//			_model.installModel.addInstaller(new AvailableInternalService("Facebook",new CloveR())); 
			}
			
			
//			var nme:NativeMenuItem = new NativeMenuItem("Add Images");
//			nme.addEventListener(Event.SELECT,onAISelect);
//			
//			new CloveEvent(CloveEvent.ADD_POSTER_ACTION,nme).dispatch();
			
			
//			 CloveAIRModelLocator.getInstance().browserInvokationManager.invoke(["invokePlugin=com.spice.clove.plugin.twitter.CloveTwitterPluginFactory",["search=yahoo"]]);
			
			//testing the Alert monkey patch
//			Alert.show("Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. ","Are you sure you want to kill a bird?",Alert.YES);
			
			//initialize the application
			new CloveEvent(CloveEvent.INITIALIZE).dispatch();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function init():void
		{
			
		}
		
		/*
		 */
//		
//		private var _file:File;
//		private var _men:NativeMenuItem;
//		
//		private function onAISelect(event:Event):void
//		{
//			_men = NativeMenuItem(event.target);
//			
//			_file = new File();
//			_file.addEventListener(FileListEvent.SELECT_MULTIPLE,onFilesSelect);
//			_file.browseForOpenMultiple("Select Images",[new FileFilter("Images","*.png;*.jpg;*.gif;*.tif")]);
//			
//		}
//		
//		private function onFilesSelect(event:FileListEvent):void
//		{
//			event.currentTarget.removeEventListener(event.type,onFilesSelect);
//			
//			var mess:Message = Message(_men.data);
//			
//			for each(var file:File in event.files)
//			{
//				mess.attachments.addItem(new Attachment(file));
//			}
//		}

	}
}