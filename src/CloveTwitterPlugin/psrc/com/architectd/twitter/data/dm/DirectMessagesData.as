package com.architectd.twitter.data.dm
{
	import com.architectd.twitter.data.user.UserData;

	public class DirectMessagesData
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var id:String;
		public var user:UserData;
		public var text:String;
		public var createdAt:Date;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DirectMessagesData(raw:XML)
		{
			
			this.id		   = raw.id;
			this.text	   = raw.text;
			this.createdAt = new Date(Date.parse(raw.created_at));
			
			this.user = new UserData(raw.sender.name,raw.sender.screen_name,"http://twitter.com/"+raw.sender.screen_name,raw.sender.profile_image_url);
		}
	}
}