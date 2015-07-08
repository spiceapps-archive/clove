package com.architectd.youtube.data
{
	public class YoutubeAuthorData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var name:String;
		public var uri:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeAuthorData(name:String = null,uri:String = null)
		{
			this.name = name;
			this.uri = uri;
		}
	}
}