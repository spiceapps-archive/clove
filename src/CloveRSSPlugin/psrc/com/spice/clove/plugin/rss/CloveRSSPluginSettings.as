package com.spice.clove.plugin.rss
{
	
	public class CloveRSSPluginSettings
	{
		[Setting]
		public var displayName:String = "RSS";
		
		
		[Bindable] 
		[Setting]
		public var autoExpandFeeds:Boolean;
	}
}