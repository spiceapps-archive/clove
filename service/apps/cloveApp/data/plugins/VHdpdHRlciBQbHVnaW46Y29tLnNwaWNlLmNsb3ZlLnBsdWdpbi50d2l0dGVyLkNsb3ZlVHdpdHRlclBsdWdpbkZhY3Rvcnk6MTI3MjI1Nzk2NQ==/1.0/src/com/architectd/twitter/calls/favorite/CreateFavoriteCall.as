package com.architectd.twitter.calls.favorite
{
	import com.architectd.twitter.calls.favorite.FavoriteCall;

	public class CreateFavoriteCall extends  FavoriteCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function CreateFavoriteCall(statusId:String)
		{
			super("create",statusId);
		}
	}
}