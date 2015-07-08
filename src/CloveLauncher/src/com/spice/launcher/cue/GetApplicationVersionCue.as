package com.spice.launcher.cue
{
	import com.spice.launcher.models.CloveLauncherModelLocator;
	import com.spice.utils.queue.cue.Cue;
	
	public class GetApplicationVersionCue extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var pubID:String;
        public var appID:String;
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
		 
		
		public function GetApplicationVersionCue(appID:String,publisherID:String)
		{
			this.pubID = publisherID;
			this.appID = appID;
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
			this._model.airSWF.getApplicationVersion(this.appID,this.pubID,onVersion);
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onVersion(version:String):void
		{
			
			Logger.log(version,LogType.NOTICE);
			
			this.complete();
		}

	}
}