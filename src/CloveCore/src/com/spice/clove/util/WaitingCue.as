package com.spice.clove.util
{
	import com.spice.events.QueueManagerEvent;
	import com.spice.utils.queue.cue.ICue;
	
	import flash.events.EventDispatcher;
	
	/*
	  used to execute a callback after a group of cues have been completed
	 */
	 
	public class WaitingCue extends EventDispatcher implements ICue
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _callback:Function;
		private var _params:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function WaitingCue(finishCallback:Function,...params:Array)
		{
			_callback = finishCallback;
			_params   = params;
		}

		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function init():void
		{
			_callback.apply(null,_params);
			
			dispatchEvent(new QueueManagerEvent(QueueManagerEvent.CUE_COMPLETE));
		}

	}
}