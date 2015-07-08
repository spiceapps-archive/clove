package 
{
	
	
	import com.spice.events.QueueManagerEvent;
	import com.spice.launcher.cue.DownloadAIRLauncherCue;
	import com.spice.launcher.cue.GetApplicationVersionCue;
	import com.spice.launcher.cue.InstallApplicationCue;
	import com.spice.launcher.cue.LaunchApplicationCue;
	import com.spice.launcher.log.ExternalizedLogger;
	import com.spice.utils.logging.SpicyLogger;
	import com.spice.utils.queue.QueueManager;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import mx.utils.Base64Encoder;

	public class CloveLauncher extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _queue:QueueManager;
		
		private var _args:Array;
		private var _appID:String;
		private var _pubID:String;
		private var _installURL:String;
		private var _runtimeVersion:String;
		private var _installer:InstallerButton;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CloveLauncher()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align	 = StageAlign.TOP_LEFT;
			
			
			var buttonUpSkin:String;			
			var buttonDownSkin:String;
			
			//the swf parameters
			var info:Object = this.loaderInfo.parameters;
			
			
			var oldArgs:Array;
			

			_installURL 	= info.installURL 	|| null;
			oldArgs  		= info.arguments 	  ? info.arguments.split("&&") 		: ["openSceneSyncPreferenceView"];
			
			
			_args = oldArgs;
			
			
			
			
			_runtimeVersion = info.runtimeVersion || "2.0";
			_pubID 			= info.publisherID    || "";//"027B1C14ADF0B49EF3C85A5437471047DACB74E1.1";
			_appID 			= info.applicationID  || "Scout-itOut";
			
			
			//install button. NOTE: AIR apps have to be launched by some kind of interation within the swf
			
			_installer = new InstallerButton();
			_installer.addEventListener("installApp",onInstallApp);
			addChild(_installer);
			//the queue manager that handles requests
			_queue = new QueueManager();
			
			var loadCue:DownloadAIRLauncherCue = new DownloadAIRLauncherCue(info.airSWF || "http://airdownload.adobe.com/air/browserapi/air.swf",_installer);
			_queue.addCue(loadCue);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		
       	/**
		 */
		
       	
       	public function installApplication(url:String,runtimeVersion:String = "1.0",...args:Array):void
       	{	
       		_queue.addCue(new InstallApplicationCue(url,runtimeVersion,args));
       	}
       	
       	
       	//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onInstallApp(event:Event):void
		{
			_installer.currentState = InstallerState.INSTALLING_SCOUT;
			this.installApplication(this._installURL,this._runtimeVersion,this._args);
		}
	
		
	}
}
