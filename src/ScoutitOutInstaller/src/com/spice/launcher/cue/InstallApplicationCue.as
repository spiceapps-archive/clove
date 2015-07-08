package com.spice.launcher.cue
{
	import com.spice.launcher.models.CloveLauncherModelLocator;
	import com.spice.utils.queue.cue.Cue;
	
	public class InstallApplicationCue extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var airURL:String;
        public var runtimeVersion:String;
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
		 
		
		public function InstallApplicationCue(airURL:String,runtimeVersion:String = "1.0" ,args:Array = null)
		{
			this.airURL = airURL;
			this.runtimeVersion = runtimeVersion;
			this.args = args || [];
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
			
			Logger.log("InstallApplicationCue::init() airswf="+this._model.airSWF);
			
			this._model.airSWF.installApplication(this.airURL,this.runtimeVersion,this.args);
			
			
			this.complete();
			//otthers
			//airSWF.installApplication(AIRUrl, runtimeVersion, args);
			//airSWF.getApplicationVersion( applicationID, publisherID , appVersionCallback );
		}

	}
}