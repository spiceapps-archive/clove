package com.architectd.twitter.data.search
{
	import com.architectd.twitter.data.ItemData;
	import com.architectd.twitter.data.user.UserData;

	public class KeywordSearchItemData extends ItemData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var id:String;
		public var link:String;
		public var text:String;
//		public var title:String;
		public var user:UserData;
		//public var published:Date;
		public var createdAt:Date;
		public var inReplyToStatusId:Number = 0;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function KeywordSearchItemData(response:XML = null)
		{
			super(response);
			
			var id:String  = response.id;
			
			
			this.id		   = id.replace(/.*?:/igs,"");
			this.link  	   = response.link[0].@href;
//			this.title     = response.title;
			this.text      = response.title; //response.content;
			
			
			
			
			var fixedDate:Array = String(response.published).split(/[TZ:-]/);
			
			var date:Date = new Date();
			date.setUTCFullYear(fixedDate[0],fixedDate[1]-1,fixedDate[2]);
			date.setUTCHours(fixedDate[3],fixedDate[4],fixedDate[5],0);
			
			
			
			this.createdAt = date
			
			
			
			var user:String = response.author.name;
			
			var screenName:String   = user.match(/\w+/is)[0];
			var username:String 	= user.match(/(?<=\().*?(?=\))/is)[0];
			
			
			
			this.user = new UserData(username,screenName,response.author.url,response.link[1].@href);
		}
	}
}