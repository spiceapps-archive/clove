package com.architectd.twitter.calls.user
{
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter.calls.ITwitterCall;
	import com.architectd.twitter.data.TwitterResult;
	import com.architectd.twitter.events.TwitterEvent;
	import com.spice.utils.queue.cue.Cue;

	
	[Bindable] 
	public class GetAllFriendsCall extends Cue implements ITwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _cursor:Number;
		private var _users:Array;
		private var _username:String;
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var connection:Twitter;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetAllFriendsCall(username:String = null)
		{
			super();
			
			this._username = username;
			_cursor = -1;
			_users = [];
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get data():*
		{
			return _users;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function init() : void
		{
			var call:GetFriendsCall = new GetFriendsCall(this._username,this._cursor);
			
			this.connection.linkCall(call).addEventListener( TwitterEvent.CALL_COMPLETE,onData);
			call.init();
		}
		
		
		/**
		 */
		
		public function setCredentials(u:String,p:String):void
		{
			//nothing
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		private function onData(event:TwitterEvent):void
		{
			if(!event.result.success)
			{
				this.complete();
				return;
			}
			
			var gfc:GetFriendsCall = GetFriendsCall(event.target);
			
			this._cursor = gfc.nextCursor;
			
			_users = _users.concat(event.result.response);
			
			
			this.dispatchEvent(new TwitterEvent(TwitterEvent.CALL_COMPLETE,new TwitterResult(event.result.response)));
			this.complete();
			
			if(_cursor != 0)
			{
				//broken
//				this.connection.call(this);
				this.init();
			}
			
			
		}
	}
}