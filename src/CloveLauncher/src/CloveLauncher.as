package 
{
	
	
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
		private var _buttonType:String;
		private var _installURL:String;
		private var _runtimeVersion:String;
		
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
			
			
			
			/*if(info.arguments)
				info.arguments = info.arguments.split("|QUOTE|").join("\"");
			*/	
			
			
			var oldArgs:Array;
			
		//	info.buttonUpSkin = "http://localhost/work/Spice/vanilla/clove/web/images/scout-download-n.png";
			//info.buttonDownSkin = "http://localhost/work/Spice/vanilla/clove/web/images/scout-download-p.png";
			
			
			_buttonType 	= info.type 		|| "launcher";
			_installURL 	= info.installURL 	|| null;
			oldArgs  		= info.arguments 	  ? info.arguments.split("&&") 		: ["openSceneSyncPreferenceView"];
			
			
			_args = oldArgs;
			
			
			
			
			_runtimeVersion = info.runtimeVersion || "2.0";
			_pubID 			= info.publisherID    || "";//"027B1C14ADF0B49EF3C85A5437471047DACB74E1.1";
			_appID 			= info.applicationID  || "Scout-itOut";
			
			
			//install button. NOTE: AIR apps have to be launched by some kind of interation within the swf
			
			var buttonUp:*;
			var buttonDown:*;
			
			if(info.buttonUpSkin)
			{
				buttonUp =  new Loader();
				buttonUp.load(new URLRequest(info.buttonUpSkin));
			}
			else
			{
				buttonUp =  Bitmap(new Buttons.DOWNLOAD_PLUGIN_BUTTON_UP);
				buttonDown =  Bitmap(new Buttons.DOWNLOAD_PLUGIN_BUTTON_OVER);
			}
			
			
			if(info.buttonDownSkin)
			{
				buttonDown =  new Loader();
				buttonDown.load(new URLRequest(info.buttonDownSkin));
			}
			else
			if(!buttonDown)
			{
				buttonDown = buttonUp;
			}
			
			var sp:SimpleButton = new SimpleButton(buttonUp,buttonUp,buttonDown,buttonDown);
			sp.addEventListener(MouseEvent.MOUSE_UP,onButtonClick);
			
			addChild(sp);
			
			//sends errors to javascript
			Logger.getInstance().registerLogger(new ExternalizedLogger("showAIRResponse",LogType.ERROR,true));
			Logger.getInstance().registerLogger(new ExternalizedLogger("showAIRResponse",LogType.NOTICE,true));
			Logger.getInstance().registerLogger(new SpicyLogger(LogType.TRACE,true));
			
			//the queue manager that handles requests
			_queue = new QueueManager();
			
			_queue.addCue(new DownloadAIRLauncherCue(info.airSWF ? info.airSWF : "http://airdownload.adobe.com/air/browserapi/air.swf"));
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		/**
		 */
		
       	public function launchApplication(...args:Array):void
       	{
       		_queue.addCue(new LaunchApplicationCue(_appID,_pubID,args));
       	}
       	
       	/**
		 */
		
       	
       	public function installApplication(url:String,runtimeVersion:String = "1.0",...args:Array):void
       	{	
       		_queue.addCue(new InstallApplicationCue(url,runtimeVersion,args));
       	}
       	
       	/**
		 */
		
       	
       	public function getApplicationVersion():void
       	{
       		_queue.addCue(new GetApplicationVersionCue(_appID,_pubID));	
       	}
       	
       	
       	//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onButtonClick(event:MouseEvent):void
		{
			switch(this._buttonType)
			{  
				case "installer":
					this.installApplication(this._installURL,this._runtimeVersion,this._args);
				break;
				case "launcher":
					this.launchApplication(this._args);
				break;
			}
		}
		
		
	}
}
