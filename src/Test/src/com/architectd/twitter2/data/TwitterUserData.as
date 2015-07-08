package com.architectd.twitter2.data
{
	public class TwitterUserData
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var id:Number;
		public var name:String;
		public var profileImageUrl:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterUserData(id:Number = NaN,
										name:String = null,
										profileImageUrl:String = null)
		{
			this.id = id;
			this.name = name;
			this.profileImageUrl = profileImageUrl;
		}
	}
}