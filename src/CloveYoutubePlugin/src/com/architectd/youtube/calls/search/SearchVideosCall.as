package com.architectd.youtube.calls.search
{
	import com.architectd.youtube.calls.YoutubeCall;
	import com.architectd.youtube.calls.YoutubeUrls;
	import com.architectd.youtube.dataHandler.YoutubeAtomHandler;
	import com.architectd.youtube.dataHandler.YoutubeDataHandler;
	import com.architectd.youtube.dataHandler.YoutubeFeedHandler;

	[Bindable] 
	public class SearchVideosCall extends YoutubeCall
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		[Setting(name="q")]
		public var search:String;
		
		
		[Setting]
		public var category:String;
		
		[Setting(name="orderby")]
		public var orderBy:String;
		
		[Setting(name="start-index")]
		public var startIndex:Number;

		[Setting(name="max-results")]
		public var maxResult:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SearchVideosCall(search:String,
										 category:String = null,
										 orderBy:String = null,
										 startIndex:Number = NaN,
										 maxResults:Number = 10)
		{
			super(YoutubeUrls.SEARCH_VIDEOS_BASE,new YoutubeFeedHandler());
			
			this.search = search;
			this.category = category;
			this.orderBy = orderBy;
			this.startIndex = startIndex;
			this.maxResult = maxResults;
			
		}
	}
}