package com.spice.clove.plugin.facebook
{
	import mx.collections.ArrayCollection;

	[Bindable] 
	public class CloveFacebookSettings
	{
		[Setting]
		public var displayName:String = "Facebook";
		
		
		//[Setting]
//		public var loadedFriendInfo:Object = {};
		
		
		[Table(voClass="com.spice.clove.plugin.facebook.data.FriendInfo")]
		public var friends:ArrayCollection = new ArrayCollection();
		
		
		[Table(voClass="com.facebook.data.pages.PageInfoData")]
		public var fanPages:ArrayCollection = new ArrayCollection();
		
		
		
	}
}