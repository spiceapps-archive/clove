package com.spice.clove.plugin.core.views.oauth
{
	import com.spice.vanilla.core.proxy.IProxyOwner;

	public interface IOAuthViewController extends IProxyOwner
	{
		
		/**
		 * return TRUE if we prompt the user to enter a PIN 
		 * @return 
		 * 
		 */		
		
//		function usesPIN():Boolean;
		
		/**
		 * the authorization link to trigger the "enter PIN" prompt
		 * @return 
		 * 
		 */		
		
//		function isAuthorized(url:String):Boolean;
		
		
		/**
		 * called once we've logged in successfuly 
		 * @param pin the PIN entered
		 * 
		 */		
		
//		function loginComplete(pin:String=null):void;
	}
}