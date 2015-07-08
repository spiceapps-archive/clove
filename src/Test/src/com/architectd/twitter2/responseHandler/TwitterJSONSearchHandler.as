package com.architectd.twitter2.responseHandler
{
	import com.architectd.twitter2.data.TwitterSearchData;
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
		
		override protected function getData(obj:Object):Array
		{
			var result:Array = [];
			
			
			var date:Date = new Date();
			
			for each(var res:Object in obj.results)
			{
				var from:TwitterUserData = new TwitterUserData(res.from_user_id,
															   res.from_user,
															   res.profile_image_url);
				
				var to:TwitterUserData = new TwitterUserData(res.to_user_id);
				
				
				
				var data:TwitterSearchData = new TwitterSearchData(res.id,
																   res.text,
																   from,
																   to,
																   res.metadata,
																   res.iso_language_code,
																   new Date(res.created_at));
					
					
			}
			
			return result;
		}
	}
}