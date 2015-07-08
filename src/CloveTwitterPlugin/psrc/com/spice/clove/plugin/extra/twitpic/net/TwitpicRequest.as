package com.spice.clove.plugin.extra.twitpic.net
{
	import com.spice.clove.plugin.upload.FileUploadCue;
	import com.spice.clove.plugin.upload.IDataReturnableCue;
	
	import flash.events.DataEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	[Bindable]
	public class TwitpicRequest extends FileUploadCue implements IDataReturnableCue
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
			
			super(req,'media',reference);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		override protected function onFileUpload(event:DataEvent):void
		{
			
			var xm:XML = new XML(event.data);
			
			if(xm.mediaurl != "")
			{
				success = true;
				data    = xm.mediaurl;
			}
			else
			{
				success = false;
				data    = xm.toString();
			}
			
			super.onFileUpload(event);
		}

	}
}