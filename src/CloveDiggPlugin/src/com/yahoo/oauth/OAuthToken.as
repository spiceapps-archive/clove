/*
	Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
	The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.oauth
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * The OAuthToken class contains the access token key and secret used by the consumer to access protected resources.
	 * 
	 * This class is dynamic in order to support extensions.
	 * @author Zach Graves (zachg@yahoo-inc.com)
	 * @see http://oauth.net/core/1.0
	 */	
	
	[RemoteClass(alias="com.yahoo.oauth.OAuthToken")]
	
	dynamic public class OAuthToken extends EventDispatcher
	{
		/**
		 * @private 
		 */		
		private var $key:String;
		
		/**
		 * @private
		 */		
		private var $secret:String;
		
		/**
		 * Class constructor
		 * 
		 * @param key Access token key.
		 * @param secret Access token secret.
		 */
		public function OAuthToken(key:String="",secret:String="")
		{
			this.$key = key;
			this.$secret = secret;
		}
		
		/**
		 * Access token key
		 * 
		 * @return A value used by the Consumer to gain access to the Protected Resources on 
		 * behalf of the User, instead of using the User’s Service Provider credentials. 
		 */	
		
		[Bindable(event="keyChange")]
		public function get key():String 
		{
			return this.$key;
		}
		
		/**
		 * @private
		 */
		public function set key(value:String):void 
		{
			if (value != this.$key)
			{
				this.$key = value;
			}
			
			this.dispatchEvent(new Event("keyChange"));
		}
		
		/**
		 * Access Token secret
		 * 
		 * @return A secret used by the Consumer to establish ownership of a given Token.
		 */
		
		[Bindable(event="secretChange")]
		public function get secret():String 
		{
			return $secret;
		}
		
		/**
		 * @private
		 */
		public function set secret(value:String):void 
		{
			if (value != $secret)
			{
				$secret = value;
			}
			
			this.dispatchEvent(new Event("secretChange"));
		}
		
		/**
		 * Returns true if the token or key values are empty or null. 
		 * @return 
		 * 
		 */		
		public function get empty():Boolean
		{
			return ($key == "" || $secret == "");
		}
	}
}