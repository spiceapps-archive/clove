package com.architectd.youtube.dataHandler
{
	import com.architectd.service.events.ServiceEvent;
	import com.architectd.service.responseHandlers.IResponseHandler;
	
	import mx.rpc.Fault;

	public class YoutubeDataHandler implements IResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeDataHandler()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function handleResult(data:Object):ServiceEvent
		{
			return new ServiceEvent(ServiceEvent.RESULT,true,getData(String(data)));
		}
		
		/**
		 */
		
		public function handleFault(fault:Fault):ServiceEvent
		{
			return new ServiceEvent(ServiceEvent.RESULT,false);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function getData(data:String):*
		{
			return null;
		}
	}
}