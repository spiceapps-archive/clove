package com.architectd.twitter.data.user
{
	
	[RemoteClass(alias="com.architectd.twitter.data.user.UserData")]
	[Bindable] 
	public class UserData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		public var dbid:String;
		public var icon:String;
		public var name:String;
		public var screenName:String;
		public var url:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function UserData(name:String = null,screenName:String = null,url:String = null,userIcon:String = null)
		{
			this.icon	    = userIcon;
			this.name 	    = name;
			this.screenName = screenName;
			this.url	    = url; 
		}
	}
}