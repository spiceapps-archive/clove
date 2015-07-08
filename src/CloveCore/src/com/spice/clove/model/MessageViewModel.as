package com.spice.clove.model
{
	
	[Bindable]
	public class MessageViewModel
	{
		public static const FAVORITES:String = "favorites";
		public static const TREE:String = "tree";
		public static const MAIN:String      = "";
		
		public var currentState:String = MAIN;
	}
}