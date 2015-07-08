package com.spice.clove.plugin.twitter.posting.upload
{
	import com.spice.utils.queue.cue.CueStateType;
	import com.spice.utils.queue.cue.IDataReturnableCue;
	import com.spice.utils.queue.cue.StateCue;
	
	import flash.events.DataEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	[Bindable]
	
	/**
	 * Uploads photos to twitpic 
	 * @author craigcondon
	 * 
	 */	
	 
	 
	public class TwitpicRequest extends StateCue implements IDataReturnableCue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var success:Boolean;
        public var data:Object;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _file:FileReference;
		private var _request:URLRequest;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitpicRequest(reference:FileReference,username:String,password:String)
		{
			var v:URLVariables = new URLVariables();
			v.username = username;
			v.password = password;
			
			
			var req:URLRequest = new URLRequest("http://twitpic.com/api/upload");
			req.data		   = v;
			req.method 		   = URLRequestMethod.POST;
			
			
			_file = reference;
			_request = req;
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
			this.state = CueStateType.LOADING;
			
			Logger.log("init",this);
			_file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onFileUpload);
			_file.addEventListener(ProgressEvent.PROGRESS,onProgress,false,0,true);
			_file.upload(_request,'media');
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		protected function onProgress(event:ProgressEvent):void
		{
			Logger.log("uploading file "+(event.bytesLoaded/event.bytesTotal*100),this);
			
		}
        /**
		 */
		
		
		protected function onFileUpload(event:DataEvent):void
		{
			Logger.log("onFileUpload",this);
			
			var xm:XML = new XML(event.data);
			
			if(xm.@stat == "ok")
			{
				success = true;
				
				
				data    = xm.mediaurl;
				
				Logger.log("url="+xm,this);
			}
			else
			{
				success = false;
				data    = xm.toString();
				
				this.complete(CueStateType.ERROR);
				return;
				
			}
			
			this.complete();
			
		}

	}
}