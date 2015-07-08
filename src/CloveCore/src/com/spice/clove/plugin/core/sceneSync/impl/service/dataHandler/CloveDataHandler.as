package com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler
{
	import com.architectd.service.events.ServiceEvent;
	import com.architectd.service.responseHandlers.ResponseHandler;
	import com.spice.clove.plugin.core.sceneSync.impl.service.events.CloveServiceEvent;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	
	public class CloveDataHandler extends ResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _logErrors:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		 
		public function CloveDataHandler(logErrors:Boolean = true)
		{
			this._logErrors = logErrors;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function handleResult(data:Object):ServiceEvent
		{
			try
			{
				var ex:XML = new XML(data);
			}catch(e:Error)
			{
				if(this._logErrors)
				Logger.logError(e);
				
				return new CloveServiceEvent(CloveServiceEvent.RESULT,-1,"",[]);
			}
			
			return new CloveServiceEvent(CloveServiceEvent.RESULT,ex.status.code,ex.status.message,getData(ex.response));	
		}
		
		
		/**
		 */
		
		override public function handleFault(data:Fault):ServiceEvent
		{
			return new CloveServiceEvent(CloveServiceEvent.RESULT,1,data.message,data);
		}
		
		//-------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		protected function getData(data:*):Object
		{
			return null;//abstract
		}

	}
}