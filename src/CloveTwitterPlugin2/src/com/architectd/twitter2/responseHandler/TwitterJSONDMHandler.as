package com.architectd.twitter2.responseHandler
{
	import com.architectd.twitter2.data.TwitterStatusData;
	import com.architectd.twitter2.data.TwitterUserData;
	import com.flexoop.utilities.dateutils.DateUtils;
	
	public class TwitterJSONDMHandler extends TwitterJSONResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterJSONDMHandler()
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
			var result:Array = [];
			
			
			var date:Date = new Date();
			
			for each(var res:Object in obj)
			{
				var sender:Object = res.sender ? res.sender : res.user
				
				var from:TwitterUserData = new TwitterUserData();
				from.id = sender.id;
				from.screenName = sender.screen_name;
				from.profileImageUrl = sender.profile_image_url;
				
				
				var to:TwitterUserData = new TwitterUserData();
				to.id= res.to_user_id;
				
				
				var data:TwitterStatusData = new TwitterStatusData();
				data.id = res.id;
				data.text = res.text;
				data.fromUser = from;
				data.favorited =  res.favorited;
//				data.languageCode = res.iso_language_code;
				data.createdAt = new Date(res.created_at);
				
				
				result.push(data);
				
			}
			
			return result;
		}
	}
}