package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.utils.queue.cue.ICue;
	
	import flash.events.Event;
	
	public class CloveCueEvent extends CairngormEvent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const ADD_CUE:String = "addCue";
        
        public var cue:ICue;
        public var managerName:String;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
          the constructor
          @param cue the cue to push to the stack of services waiting for a request
          @param queueManagerName the manager name to use as a stack, null names will be pushed as it's own queueManager
          whereas names provided will be pushed to an existing queueManager. This is needed for services that cannot process
          more than one request at a time such as twitter
		 */
		 
		
		public function CloveCueEvent(cue:ICue,queueManagerName:String = "root")
		{
			super(ADD_CUE);
			
			this.cue = cue;
			this.managerName = queueManagerName;
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
			return new CloveCueEvent(cue);
		}

	}
}