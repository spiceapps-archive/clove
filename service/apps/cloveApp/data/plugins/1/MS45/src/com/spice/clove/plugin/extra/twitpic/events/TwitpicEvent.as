package com.spice.clove.plugin.extra.twitpic.events
{
	import com.spice.clove.ext.extra.twitpic.net.TwitpicRequest;
	
	import flash.events.Event;
	
	public class TwitpicEvent extends Event
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const NEW_REQUEST:String = "newRequest";
        	
        	
        public var request:TwitpicRequest;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TwitpicEvent(type:String,request)
		{
		
			super(type);
			
			this.request = request;
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
			return new TwitpicEvent(type,this.request);
		}
	}
}