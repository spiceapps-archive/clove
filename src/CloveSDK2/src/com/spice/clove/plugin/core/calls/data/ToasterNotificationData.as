package com.spice.clove.plugin.core.calls.data
{
	
	/**
	 * sends a notification to any handlers, such as Growl 
	 * @author craigcondon
	 * 
	 */	
	
	public class ToasterNotificationData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var title:String;
		public var message:String;
		public var icon:*;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ToasterNotificationData(title:String,message:String,icon:* = null)
		{
			this.title = title;
			this.message = message;
			this.icon = icon;
		}
	}
}