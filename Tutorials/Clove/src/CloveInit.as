package
{

	import com.spice.air.display.AutoResizingWindow;
	import com.spice.air.utils.logging.FileLogger;
	import com.spice.air.utils.sql.manage.SQLiteTableMetadataManager;
	import com.spice.aloe.AloeBugTracker;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.models.CloveAIRModelLocator;
//	import com.spice.clove.plugin.bestBuy.*;
	import com.spice.clove.plugin.core.installer.CloveInstallerPluginFactory;
	import com.spice.clove.plugin.core.service.ServicePluginFactory;
//	import com.spice.clove.plugin.facebook.*;
//	import com.spice.clove.plugin.gdgt.*;
	import com.spice.clove.plugin.install.*;
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.posting.Message;
//	import com.spice.clove.plugin.rss.*;
//	import com.spice.clove.plugin.twitter.*;
//	import com.spice.clove.plugins.digg.DiggPluginFactory;
	import com.spice.utils.storage.persistent.*;
	
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import mx.collections.ArrayCollection;
	
	
	
	
	
	/**
	 * we use this class to initialze data in the constructor since MXML doesn't automatically remove unused classes 
	 * @author craigcondon
	 * 
	 */	
	public class CloveInit
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
        
        /**
		 */

		
		public function CloveInit()
		{
//			test.addItem(new RenderedColumnData());
			
			new CloveEvent(CloveEvent.CHECK_UPDATE).dispatch();
			
			//initializes AIR properties
			CloveAIRModelLocator.getInstance();
			
			_model.corePluginModel.corePlugins.addAll(new ArrayCollection([ServicePluginFactory,CloveInstallerPluginFactory]));
			
			var logger:Logger = Logger.getInstance();
			
			logger.registerLogger(new FileLogger(LogType.NOTICE,"Notice.log",true,true,false));
			logger.registerLogger(new FileLogger(LogType.WARNING,"Warning.log",true,true,false));
			logger.registerLogger(new FileLogger(LogType.ERROR,"Error.log",true,true,false));
			logger.registerLogger(new FileLogger(LogType.FATAL,"Fatal.log",true,true,false));
			
			
			//track any bugs sent from Clove
			AloeBugTracker.getInstance().project = 2; //1 = clove
			AloeBugTracker.monitor(logger.getLogger(LogType.ERROR));
			AloeBugTracker.monitor(logger.getLogger(LogType.FATAL));
			AloeBugTracker.monitor(logger.getLogger(LogType.WARNING));
			AloeBugTracker.monitor(logger.getLogger(LogType.NOTICE));
			
			var sql:SQLiteTableMetadataManager;
			
			/*new SQLiteTableMetadataManager(FileUtil.resolvePath(File.applicationStorageDirectory,"dbtest.db"),this);
			
			
			trace(this.test);*/
			
			Logger.showTraces(false);
			
			/*Logger.showTraces(false);
			Logger.showTraces(true,LogType.MEMORY);*/
			
			
			
			if(true)
			{
				
				//plugins go here
				//turn this into a mediator call
//				_model.installModel.addInstaller(new AvailableInternalService("Twitter",new CloveTwitterPluginFactory()));
//				_model.installModel.addInstaller(new AvailableInternalService("Digg",new DiggPluginFactory()));
//				_model.installModel.addInstaller(new AvailableInternalService("Facebook",new CloveFacebookPluginFactory())); 
//				_model.installModel.addInstaller(new AvailableInternalService("RSS",new CloveRSSPluginFactory())); 
			}
			
			
			var c:AutoResizingWindow;
			
			
			var nme:NativeMenuItem = new NativeMenuItem("Add Images");
			nme.addEventListener(Event.SELECT,onAISelect);
			
			new CloveEvent(CloveEvent.ADD_POSTER_ACTION,nme).dispatch();
			
			
//			 CloveAIRModelLocator.getInstance().browserInvokationManager.invoke(["invokePlugin=com.spice.clove.plugin.twitter.CloveTwitterPluginFactory",["search=yahoo"]]);
			
			//testing the Alert monkey patch
//			Alert.show("Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. Among other side effects, this will cause the world to stop spinning. ","Are you sure you want to kill a bird?",Alert.YES);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function init():void
		{
			
		}
		
		/**
		 */
		
		private var _file:File;
		private var _men:NativeMenuItem;
		
		private function onAISelect(event:Event):void
		{
			_men = NativeMenuItem(event.target);
			
			_file = new File();
			_file.addEventListener(FileListEvent.SELECT_MULTIPLE,onFilesSelect);
			_file.browseForOpenMultiple("Select Images",[new FileFilter("Images","*.png;*.jpg;*.gif;*.tif")]);
			
		}
		
		private function onFilesSelect(event:FileListEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onFilesSelect);
			
			var mess:Message = Message(_men.data);
			
			for each(var file:File in event.files)
			{
				mess.attachments.addItem(new Attachment(file));
			}
		}

	}
}