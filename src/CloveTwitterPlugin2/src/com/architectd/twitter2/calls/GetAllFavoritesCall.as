package com.architectd.twitter2.calls
{
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter2.calls.GetFriendsCall;
	import com.architectd.twitter2.data.TwitterFriendsData;
	import com.spice.core.calls.CallRemoteServiceLoadCueType;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.impl.service.RemoteServiceResult;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	
	import flash.utils.setTimeout;
	
	public class GetAllFavoritesCall extends AbstractCue implements IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _oauth:OAuthServiceCue;
		private var _responseBind:ProxyBind;
		private var _call:GetFavoritesCall;
		private var _screenName:String;
		private var _cursor:Number;
		private var _allFavorites:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetAllFavoritesCall(oauth:OAuthServiceCue,screen_name:String = null)
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
				_call = new GetFavoritesCall(this._screenName,_oauth);
				_responseBind = new ProxyBind(_call.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT]);
			}
			else
			{
				_call.page++;
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
			
			var favs:Array = data.getData();
			
			var complete:Boolean = favs.length == 0;
			
			if(_allFavorites)
			{
				favs = favs.concat(_allFavorites);
			}
			
			_allFavorites = favs;
			
			if(complete)
			{
				this.notifyChange(CallRemoteServiceLoadCueType.SERVICE_RESULT,new RemoteServiceResult(true,_allFavorites));
				
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