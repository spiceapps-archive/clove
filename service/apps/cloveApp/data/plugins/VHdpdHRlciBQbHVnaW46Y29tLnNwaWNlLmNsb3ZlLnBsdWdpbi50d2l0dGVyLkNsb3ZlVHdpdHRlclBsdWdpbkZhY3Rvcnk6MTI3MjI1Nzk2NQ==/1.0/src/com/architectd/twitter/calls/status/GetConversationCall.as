package com.architectd.twitter.calls.status
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.data.TwitterResult;
	import com.architectd.twitter.data.status.StatusData;
	import com.architectd.twitter.data.user.UserData;
	import com.architectd.twitter.dataHandle.IDataHandler;
	
	import flash.utils.setTimeout;
	
	
	//yuck.
	public class GetConversationCall extends TwitterCall implements IDataHandler
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _conversation:Array;
		private var _complete:Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function GetConversationCall(inReplyTo:String = null)
		{
			super("http://twitter.com/statuses/show/"+inReplyTo+".xml",this);
			
			this._conversation = [];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		
		public function getResponseData(raw:String):*
		{
			var status:XML = new XML(raw);
			var user:XMLList = status.user;
			
			var u:UserData = new UserData(user.name,
										  user.screen_name,
										  "http://twitter.com/"+user.screen_name,
										  user.profile_image_url);
			
			var st:StatusData = new StatusData(status.created_at,
											   status.id,
											   status.text,
											   status.source,
											   status.truncated == 'true',
											   status.in_reply_to_status_id,
											   status.in_reply_to_user_id,
											   status.favorited,
											   status.in_reply_to_screen_name,
											   u);
			
			_conversation.push(st);
			
			if(st.inReplyToStatusId > 0)
			{
				this.url = "twitter.com/statuses/show/"+st.inReplyToStatusId+".xml";
				
				
//				flash.utils.setTimeout(this.connection.call,100,this);
				
				this.init();
			}
			else
			{
				_complete = true;
			}
			
			return _conversation;
//			var st:StatusData = new StatusData(
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		 
		 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		 //NOTE: for the tiwtter conversation, it may be best for larger conversations
		 //to load the individually instead of waiting until they're ALL loaded. So for now
		 //this is commented out
		 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		 
		/* override protected function dispatchComplete(result:TwitterResult):void
		{
			if(_complete || true)
			{
				super.dispatchComplete(result);
			}
		} */
		
		
		/*
		 */
		
		override protected function complete(state:int=1):void
		{
			if(_complete)
			{
				super.complete(state);
			}
		}

	}
}