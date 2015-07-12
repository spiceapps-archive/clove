package com.architectd.twitter.data.timeline
{
	import com.architectd.twitter.data.user.UserData;

	public class TimelineItemData
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		public var user:UserData;
		public var text:String;
		public var id:String;
		public var favorited:Boolean;
		public var createdAt:Date;
		public var inReplyToStatusId:Number
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function TimelineItemData(data:XML = null)
		{
			this.text 	   = data.text;
			this.id  	   = data.id;
			this.favorited = data.favorited == 'true';
			this.inReplyToStatusId = data.in_reply_to_status_id;
			
			
			this.createdAt = new Date(Date.parse(data.created_at));
			
			
			this.user = new UserData(data.user.name,data.user.screen_name,"http://twitter.com/"+data.user.screen_name,data.user.profile_image_url);
		}
	}
}