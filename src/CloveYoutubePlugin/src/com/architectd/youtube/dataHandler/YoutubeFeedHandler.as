package com.architectd.youtube.dataHandler
{
	import com.adobe.xml.syndication.atom.Entry;
	import com.architectd.youtube.data.YoutubeFeedData;

	public class YoutubeFeedHandler extends YoutubeAtomHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeFeedHandler()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		override protected function getEntryData(entry:Entry):*
		{
			return YoutubeFeedData.fromEntry(entry);
		}
	}
}