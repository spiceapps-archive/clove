package com.spice.clove.plugin.extra.twitpic.events
{
	import com.spice.clove.ext.extra.twitpic.net.TwitpicService;
	
	import flash.events.Event;
	
	public class TwitpicConnectionEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const NEW_CONNECTION:String = "newConnection";
        
        public var connection:TwitpicService;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TwitpicConnectionEvent(type:String,connection:TwitpicService)
		{
			super(type);
			
			this.connection = connection;
		}
		
		

	}
}