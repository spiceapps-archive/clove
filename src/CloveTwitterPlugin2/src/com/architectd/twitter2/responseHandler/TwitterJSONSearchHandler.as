package com.architectd.twitter2.responseHandler
{
	import com.architectd.twitter2.data.TwitterStatusData;
	import com.architectd.twitter2.data.TwitterUserData;
	import com.flexoop.utilities.dateutils.DateUtils;

	public class TwitterJSONSearchHandler extends TwitterJSONResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterJSONSearchHandler()
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
			
			for each(var res:Object in obj.results)
			{
				var from:TwitterUserData = new TwitterUserData();
				from.id = res.from_user_id;
				from.screenName = res.from_user;
				from.profileImageUrl = res.profile_image_url;
				
				
				var to:TwitterUserData = new TwitterUserData();
				to.id= res.to_user_id;
				
				
				var data:TwitterStatusData = new TwitterStatusData();
				data.id = res.id;
				data.text = res.text;
				data.fromUser = from;
				data.toUser = to;
				data.metadata = res.metadata;
				data.languageCode = res.iso_language_code;
				data.createdAt = new Date(res.created_at);
				
				
				result.push(data);
					
			}
			
			return result;
		}
	}
}