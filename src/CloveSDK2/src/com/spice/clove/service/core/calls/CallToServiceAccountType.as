package com.spice.clove.service.core.calls
{
	import com.spice.clove.plugin.core.calls.CallClovePluginType;

	public class CallToServiceAccountType
	{
		public static const GET_AVAILABLE_CONTENT_CONTROLLERS:String = CallClovePluginType.GET_AVAILABLE_CONTENT_CONTROLLERS;
		public static const GET_NEW_CONTENT_CONTROLLER:String = CallClovePluginType.GET_NEW_CONTENT_CONTROLLER;
		public static const GET_NAME:String = "getName";
		public static const GET_PLUGIN:String = "getPlugin";  
		public static const SERVICE_ACCOUNT_UNINSTALL:String = "serviceAccountUninstall";
	}
}