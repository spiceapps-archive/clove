package com.architectd.digg.data
{
	public class StoryData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var title:String;
		public var topic:String;
		public var container:String;
		public var description:String;
		public var submitted:Date;
		public var diggs:Number;
		public var id:Number;
		public var comments:Number;
		public var status:String;
		public var diggUrl:String;
		public var sourceUrl:String;
		public var thumbnail:String;
		public var shortUrl:String;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function StoryData(title:String	     = null,
								  topic:String 	     = null,
								  container:String   = null,
								  description:String = null,
								  submitted:Number   = NaN,
								  diggs:Number 	     = NaN,
								  id:Number 		 = NaN,
								  comments:Number    = NaN,
								  status:String      = null,
								  diggUrl:String     = null,
								  sourceUrl:String   = null,
								  thumbnail:String   = null,
								  shortUrl:String	 = null)
		{
			
			var s:Date = new Date();
			s.setDate(submitted);
			
			
			this.title		 = title;
			this.topic	     = topic;
			this.container   = container;
			this.description = description;
			this.submitted   = s;
			this.diggs	     = diggs;
			this.id          = id;
			this.comments    = comments;
			this.status      = status;
			this.diggUrl     = diggUrl;
			this.thumbnail   = thumbnail;
			this.shortUrl    = shortUrl;
		}
	}
}