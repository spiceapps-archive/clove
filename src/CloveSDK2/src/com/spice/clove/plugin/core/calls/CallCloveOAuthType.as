package com.spice.clove.plugin.core.calls
{
	public class CallCloveOAuthType
	{
		/**
		 * returns the current HTTP location for OAuth
		 */		
		
		public static const GET_OAUTH_CURRENT_HTTP_LOCATION:String = "getOAuthCurrentHTTPLocation";
		
		
		public static const RESET_CURRENT_HTTP_LOCATION:String = "resetCurrentHttpLocation";
		
		/**
		 * returns the current title of the oauth window 
		 */		
		public static const GET_OAUTH_TITLE:String = "getOAuthTitle";
		
		/**
		 * TRUE if we want to show the oauth window  
		 */
		
		public static const SHOW_OAUTH_PIN:String = "showOAuthPin";
		
		/**
		 * set the current HTTP location changed by the html window 
		 */		
		
		public static const SET_OAUTH_CURRENT_HTTP_LOCATION:String = "setOAuthCurrentHTTPLocation";
		
		/**
		 * returns the OAuth pin entered in 
		 */		
		
		public static const GET_OAUTH_PIN:String = "getOAuthPin";
		
		/**
		 */
		
		
		public static const GET_ACCESS_TOKEN:String = "getAccessToken";
		
		/** 
		 */		
		
		public static const SET_OAUTH_PIN:String = "setOAuthPin";
		
		/**
		 * the icon to use for the HTTP view. this is a pass-through method
		 */
		
		public static const GET_OAUTH_ICON:String = CallClovePluginFactoryType.GET_ICON_32;
	}
}