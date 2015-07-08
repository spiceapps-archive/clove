package com.architectd.twitter2.responseHandler
{
	import com.architectd.twitter2.data.TwitterUserData;

	public class TwitterJSONSingleUserResponseHandler extends TwitterJSONResponseHandler
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterJSONSingleUserResponseHandler()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getData(obj:Object):*
		{
			var user:TwitterUserData = new TwitterUserData();
			user.screenName = obj.screen_name;
			user.id = obj.id;
			
			return user;
		}
	}
}