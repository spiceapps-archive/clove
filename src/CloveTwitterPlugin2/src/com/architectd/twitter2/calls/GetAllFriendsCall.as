package com.architectd.twitter2.calls
{
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter2.calls.GetFriendsCall;
	import com.architectd.twitter2.data.TwitterFriendsData;
	import com.spice.core.calls.CallRemoteServiceLoadCueType;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.impl.service.RemoteServiceResult;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	
	import flash.utils.setTimeout;

	public class GetAllFriendsCall extends AbstractCue implements IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _oauth:OAuthServiceCue;
		private var _responseBind:ProxyBind;
		private var _call:GetFriendsCall;
		private var _screenName:String;
		private var _cursor:Number;
		private var _allFriends:TwitterFriendsData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetAllFriendsCall(oauth:OAuthServiceCue,screen_name:String = null)
		{
			_oauth = oauth;
			_screenName = screen_name;
			_cursor = -1;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			if(!_call)
			{
				_call = new GetFriendsCall(_oauth,_screenName,-1);
				_responseBind = new ProxyBind(_call.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT]);
			}
			else
			{
				_call.cursor = this._allFriends.nextCursor;
			}
			
			
			_call.initialize();
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			var data:RemoteServiceResult = n.getData();
			
			if(!data.success())
			{
				return this.complete();
			}
			
			var friends:TwitterFriendsData = data.getData();
			
			if(_allFriends)
			{
				friends.users = _allFriends.users.concat(friends.users);
			}
			
			_allFriends = friends;
			
			if(_allFriends.nextCursor == 0)
			{
				this.notifyChange(CallRemoteServiceLoadCueType.SERVICE_RESULT,new RemoteServiceResult(true,_allFriends));
				
				this.complete();
				return;
			}
			
			
			flash.utils.setTimeout(this.initialize,1);
			
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallRemoteServiceLoadCueType.SERVICE_RESULT]);
		}
	}
}