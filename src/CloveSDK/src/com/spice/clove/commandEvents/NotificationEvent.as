package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class NotificationEvent extends CairngormEvent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		public static const NOTIFY:String = "notify";
		
		public var title:String;
		public var message:String;
		
		//can be url
		public var icon:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function NotificationEvent(title:String,message:String,icon:Object = null)
		{
			this.title = title;
			this.message = message;
			this.icon = icon;
			
			super(NOTIFY);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		
		override public function clone():Event
		{
			return new NotificationEvent(title,message,icon);
		}

	}
}