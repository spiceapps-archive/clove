package com.spice.clove.model
{
	
	[Bindable] 
	public class ViewModel
	{
		public static const INIT_VIEW:int          = 0;
		public static const LOGIN_VIEW:int 		   = 1;
		public static const CHOICE_VIEW:int		   = 2;
		public static const BUNDLE_PLUGIN_VIEW:int = 3;
		public static const BUNDLE_AIR_VIEW:int    = 4;
		
		
		public var currentView:int = INIT_VIEW;
	}
}