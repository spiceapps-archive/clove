package com.spice.clove.plugin.twitter.install.importService.tweetdeck.dao
{
	public class TweetdeckColumn
	{
		
		public var type:int;
		public var data:Object;
		public var subColumns:Array;
		public var name:String;
		
		public function TweetdeckColumn(type:int,data:Object,name:String = null)
		{
			this.type		= type;
			this.data = data;
			this.name = name;
			this.subColumns = new Array();
			
		}

	}
}