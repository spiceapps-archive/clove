package com.architectd.twitter2.calls
{
	import com.adobe.serialization.json.JSON;
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.data.TwitterResult;
	import com.architectd.twitter.data.status.StatusData;
	import com.architectd.twitter.data.user.UserData;
	import com.architectd.twitter.dataHandle.IDataHandler;
	import com.architectd.twitter2.calls.AuthorizedTwitterCall;
	import com.architectd.twitter2.data.TwitterStatusData;
	import com.architectd.twitter2.data.TwitterUserData;
	import com.spice.impl.service.IRemoteServiceResponseHandler;
	import com.spice.impl.service.RemoteServiceResult;
	
	import flash.utils.setTimeout;
	
	
	//yuck.
	public class GetConversationCall extends AuthorizedTwitterCall implements IRemoteServiceResponseHandler
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _conversation:Array;
		private var _complete:Boolean;
		private var _inReplyToStatus:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function GetConversationCall(inReplyTo:Number,oauthService:OAuthServiceCue)
		{
			super("http://twitter.com/statuses/show/"+inReplyTo+".json",oauthService,this,{});
			
			_inReplyToStatus = inReplyTo;
			
			this._conversation = [];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		
		public function processRawData(raw:*):RemoteServiceResult
			
		{
			var status:Object = JSON.decode(raw);
			
			var u:Object = status.user;
			
			var ud:TwitterUserData = new TwitterUserData();
			ud.name = u.name;
			ud.screenName = u.screen_name;
			ud.id = u.id;
			ud.profileImageUrl = u.profile_image_url;
			
			var toUser:TwitterUserData = new TwitterUserData();
			toUser.id = status.in_reply_to_user;
			
			var st:TwitterStatusData = new TwitterStatusData();
			st.id = status.id;
			st.createdAt = new Date(status.created_at);
			st.inReplyToStatusId = status.in_reply_to_status_id;
			st.fromUser = ud;
			st.toUser = toUser;
			st.text = status.text;
			st.favorited = status.favorited;
			
			_conversation.push(st);
			
			if(st.inReplyToStatusId > 0)
			{
				this._baseUrl = "http://twitter.com/statuses/show/"+st.inReplyToStatusId+".json";
				
				flash.utils.setTimeout(this.initialize,1);
			}
			else
			{
				_complete = true;
			}
			
			return new RemoteServiceResult(true,st);
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
		
		
		override protected function complete(status:* = true):void
		{
			if(_complete)
			{
				super.complete(status);
			}
		}
		
		
		/**
		 */
		
		override public function dispose():void
		{
			super.dispose();
		}

	}
}