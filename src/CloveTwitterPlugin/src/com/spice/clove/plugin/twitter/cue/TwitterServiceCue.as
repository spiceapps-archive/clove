package com.spice.clove.plugin.twitter.cue
{
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.events.TwitterEvent;
	import com.spice.utils.queue.cue.CueStateType;
	import com.spice.utils.queue.cue.StateCue;
	
	/*
	  Twitter only allows one call to be made at a time, so the TwitterServiceCue is used
	  to send to the global Queue Manager. From there we can handle each request one at a time 
	  @author craigcondon
	  
	 */	
	 
	 
	public class TwitterServiceCue extends StateCue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _service:Twitter;
		private var _call:TwitterCall;
		private var _resultCallback:Function;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		public static const MAX_WAIT_TIME:int = 60000;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function TwitterServiceCue(service:Twitter,
										  call:TwitterCall,
										  resultCallback:Function = null)
		{
			super(/*MAX_WAIT_TIME*/);
			
			_service  = service;
			_call = call;
			_resultCallback = resultCallback;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function init():void
		{
			this._call.addEventListener(TwitterEvent.CALL_COMPLETE,onResult);
			this._service.call(_call);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
       
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		private function onResult(event:TwitterEvent):void
		{
			
			if(_resultCallback != null && event.result.success)
			{
				
				_resultCallback(event);
			}
			
			complete(event.result.success ? CueStateType.COMPLETE : CueStateType.ERROR);
		}
		
	}
}