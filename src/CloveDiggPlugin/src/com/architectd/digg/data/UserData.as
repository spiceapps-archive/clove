package com.architectd.digg.data
{
	public class UserData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var username:String;
		public var registered:Date;
		public var profileViews:Number;
		public var icon:String;
		public var mutual:Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UserData(name:String = null,
								 registered:Number = NaN,
								 profileViews:Number = NaN,
								 icon:String = null,
								 mutual:Boolean = true)
		{
			this.username = name;
			this.profileViews = profileViews;
			this.icon = icon;
			this.mutual = mutual;
		}
	}
}