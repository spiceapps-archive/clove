package com.architectd.twitter.dataHandle
{
	import com.architectd.twitter.data.user.UserData;

	public class GetFriendsDataHandler extends DataHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var nextCursor:Number;
		public var previousCursor:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function GetFriendsDataHandler()
		{
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		override protected function getResponseData2(raw:String) : *
		{
			var ex:XML = new XML(raw);
			var u:UserData;
			
			var d:Array = [];
			
			for each(var ux:XML in ex.users.user)
			{
				u = new UserData(ux.name,ux.screen_name,"http://twitter.com/dougw",ux.profile_image_url);
			
				d.push(u);
				
			}
			
			this.nextCursor = ex.next_cursor;
			this.previousCursor = ex.previous_cursor;
			
			return d;
		}
	}
}