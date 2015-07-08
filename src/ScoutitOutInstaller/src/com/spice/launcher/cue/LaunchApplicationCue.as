package com.spice.launcher.cue
{
	import com.spice.launcher.models.CloveLauncherModelLocator;
	import com.spice.utils.queue.cue.Cue;
	
	public class LaunchApplicationCue extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var appID:String;
        public var pubID:String;
        public var args:Array;
        
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		[Bindable] 
		private var _model:CloveLauncherModelLocator = CloveLauncherModelLocator.getInstance();
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function LaunchApplicationCue(appID:String,publisherID:String,args:Array = null)
		{
			this.appID = appID;
			this.pubID = publisherID;
			this.args  = args ? args : [];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function init():void
		{
			
			Logger.log("Launching app="+this.appID+" pub="+this.pubID+" args="+this.args+" swf="+this._model.airSWF);
			
			
			try
			{
				this._model.airSWF.launchApplication(this.appID,this.pubID,this.args);
			}catch(e:Error)
			{
				Logger.log("LauncApplicationCue:: error="+e,LogType.ERROR);
			}
			
			this.complete();
			//otthers
			//airSWF.installApplication(AIRUrl, runtimeVersion, args);
			//airSWF.getApplicationVersion( applicationID, publisherID , appVersionCallback );
		}

	}
}