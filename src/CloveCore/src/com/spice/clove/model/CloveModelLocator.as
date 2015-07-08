package com.spice.clove.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.spice.clove.core.storage.CloveSettings;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.utils.queue.global.GlobalQueueManager;
	import com.spice.utils.storage.persistent.SettingManager;
	import com.spice.vanilla.flash.singleton.Singleton;
	
	import flash.display.DisplayObject;
	
	[Bindable] 
	public class CloveModelLocator extends Singleton implements IModelLocator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private static var _model:CloveModelLocator;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CloveModelLocator()
		{
			super();
			
			new SettingManager(this.applicationSettings.modelSettings,this);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public static function getInstance():CloveModelLocator
		{
			return Singleton.getInstance(CloveModelLocator);
		}

		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
        

		public var applicationSettings:CloveSettings = CloveSettings.getInstance();
		
		public var initModel:InitModel   = new InitModel();
		public var navModel:NavModel = new NavModel();
		public var queue:GlobalQueueManager = GlobalQueueManager.getInstance();
		public var installModel:InstallModel = new InstallModel();
		public var objectPool:ObjectPoolManager = ObjectPoolManager.getInstance();
		//public var columnModel:CloveColumnModel = new CloveColumnModel();
		public var pluginModel:PluginModel = new PluginModel();
		public var urlModel:RemoteURLModel = new RemoteURLModel();
		public var corePluginModel:CorePluginsModel = new CorePluginsModel();
		
		
		//public var rootView:DisplayObject;
		
		//text shortcut handlers
		//public var textReplacementHandler:TextCommandManager = new TextCommandManager();
		public var textReplacementModel:TextReplacementModel = new TextReplacementModel();
//		public var textShortcutHandler:KeyboardShortcutManager = new KeyboardShortcutManager(Application.application as DisplayObject);
		
		
		
		//public static const SERVER_INIT_INSTALL:String = "http://localhost/work/neem/service/initInstall.php";
		
		
//		[Setting]
		public var serverUpdateUrl:String   = "http://spiceapps.com/service/clove/update.xml";
		

		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _messages:Array = new Array();

	}
}