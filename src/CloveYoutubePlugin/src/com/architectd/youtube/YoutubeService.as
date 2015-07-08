package com.architectd.youtube
{
	import com.architectd.service.RemoteService;
	import com.architectd.youtube.calls.YoutubeCall;
	import com.architectd.youtube.calls.YoutubeUrls;
	import com.architectd.youtube.calls.search.SearchVideosCall;
	import com.architectd.youtube.dataHandler.YoutubeFeedHandler;

	public class YoutubeService extends RemoteService
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeService()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function search(keyword:String,
							   category:String = null,
							   orderBy:String = null,
							   startIndex:Number = NaN,
							   maxResults:Number = 10):SearchVideosCall
		{
			var call:SearchVideosCall = new SearchVideosCall(keyword,category,orderBy,startIndex,maxResults);
			call.init();
			return call;
		}
		
		/**
		 */
		
		public function getUserVideos(user:String):YoutubeCall
		{  
			var call:YoutubeCall = new YoutubeCall(YoutubeUrls.GET_USER_VIDEOS(user),new YoutubeFeedHandler());
			call.init();
			return call;
		}
	}
}