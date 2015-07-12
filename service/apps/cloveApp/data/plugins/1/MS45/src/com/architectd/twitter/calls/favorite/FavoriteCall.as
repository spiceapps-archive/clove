package com.architectd.twitter.calls.favorite
{
	import com.architectd.twitter.calls.TwitterCall;
	
	public class FavoriteCall extends TwitterCall
	{
		public function FavoriteCall(method:String,statusId:String)
		{
			
			super("http://twitter.com/favorites/"+method+"/"+method+".xml",null,null,true);
		}
	}
}