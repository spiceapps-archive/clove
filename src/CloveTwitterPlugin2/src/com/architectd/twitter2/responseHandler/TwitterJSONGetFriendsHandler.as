package com.architectd.twitter2.responseHandler
{
	import com.architectd.twitter2.data.TwitterFriendsData;
	import com.architectd.twitter2.data.TwitterUserData;

	public class TwitterJSONGetFriendsHandler extends TwitterJSONResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterJSONGetFriendsHandler()
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
			var data:TwitterFriendsData = new TwitterFriendsData();
			data.nextCursor = obj.next_cursor;
			data.previousCursor = obj.previous_cursor;
			data.users = new Vector.<TwitterUserData>();
			
			
			for each(var user:Object in obj.users)
			{
				var u:TwitterUserData = new TwitterUserData();
				u.name = user.name;
				u.screenName = user.screen_name;
				u.id = user.id;
				
				data.users.push(u);
			}
			
			return data;
		}
	}
}