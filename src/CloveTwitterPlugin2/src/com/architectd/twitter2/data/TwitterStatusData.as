package com.architectd.twitter2.data
{
	public class TwitterStatusData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var id:Number;
		public var text:String;
		public var source:String;
		public var createdAt:Date;
		public var metadata:Object;
		public var favorited:Boolean;
		public var geo:TwitterGeoData;
		public var languageCode:String;
		public var toUser:TwitterUserData;
		public var inReplyToStatusId:Number;
		public var fromUser:TwitterUserData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function TwitterStatusData()
		{
		}
	}
}