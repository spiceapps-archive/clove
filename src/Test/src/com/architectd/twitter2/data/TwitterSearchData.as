package com.architectd.twitter2.data
{
	public class TwitterSearchData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var id:Number;
		public var text:String;
		public var fromUser:TwitterUserData;
		public var toUser:TwitterUserData;
		public var metadata:Object;
		public var languageCode:String;
		public var createdAt:Date;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function TwitterSearchData(id:Number,
										  text:String,
										  fromUser:TwitterUserData,
										  toUser:TwitterUserData,
										  metadata:Object,
										  languageCode:String,
										  createdAt:Date)
		{
			this.id			  = id;
			this.text 		  = text;
			this.fromUser	  = fromUser;
			this.toUser 	  = toUser;
			this.metadata 	  = metadata;
			this.languageCode = languageCode;
			this.createdAt    = createdAt;
		}
	}
}