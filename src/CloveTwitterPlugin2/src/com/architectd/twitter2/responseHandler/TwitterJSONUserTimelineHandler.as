package com.architectd.twitter2.responseHandler
{
	import com.architectd.twitter2.data.TwitterStatusData;
	import com.architectd.twitter2.data.TwitterUserData;
	import com.flexoop.utilities.dateutils.DateUtils;
	
	public class TwitterJSONUserTimelineHandler extends TwitterJSONResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterJSONUserTimelineHandler()
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
			
			for each(var res:Object in obj)
			{
				var u:Object = res.user;
				
				var from:TwitterUserData = new TwitterUserData();
				from.id = u.id;
				from.screenName = u.screen_name;
				from.createdAt = new Date(u.created_at);
				from.favoritesCount = u.favourites_count;
				from.followersCount = u.followers_count;
				from.following = u.following;
				from.friendsCount = u.friends_count;
				from.lang = u.lang;
				from.location = u.location;
				from.name = u.name;
				from.notifications = u.notifications;
				from.profileBackgroundColor = u.profile_background_color;
				from.profileBackgroundImageUrl = u.profile_background_image_url;
				from.profileImageUrl = u.profile_image_url;
				from.profileLinkColor = u.profile_link_color;
				from.statusesCount = u.statuses_count;
				from.timeZone = u.time_zone;
				from.url = u.url;
				from.utcOffset = u.utc_offset;
				from.verified = u.verified;
				
				
				var status:TwitterStatusData = new TwitterStatusData();
				status.id = res.id;
				status.createdAt = new Date(res.created_at);
				status.favorited = res.favorited;
				status.inReplyToStatusId = new Number(res.in_reply_to_status_id);
				status.source = res.source;
				status.text = res.text;
				status.fromUser = from;
				
				
				result.push(status);
				
			}
			
			
			return result;
		}
	}
}