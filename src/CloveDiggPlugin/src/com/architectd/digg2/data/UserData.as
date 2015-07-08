package com.architectd.digg2.data
{
	
	[RemoteClass(alias="com.architectd.digg2.data.UserData")]
	[Bindable] 
	public class UserData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var dbid:String;
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
			this.icon = "http://digg.com/"+icon;
			this.mutual = mutual;
		}
	}
}