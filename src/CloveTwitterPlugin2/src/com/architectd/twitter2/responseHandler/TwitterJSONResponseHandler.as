package com.architectd.twitter2.responseHandler
{
	import com.adobe.serialization.json.JSON;
	import com.spice.impl.service.IRemoteServiceResponseHandler;
	import com.spice.impl.service.RemoteServiceResult;

	public class TwitterJSONResponseHandler implements IRemoteServiceResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function TwitterJSONResponseHandler()
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function processRawData(data:*):RemoteServiceResult
		{
			try
			{
				return new RemoteServiceResult(true,this.getData(JSON.decode(data.toString())));
			}catch(e:Error)
			{
				return new RemoteServiceResult(false,"Cannot parse JSON response: "+e.getStackTrace());
			}
			
			return null;
		}
		
		
		/**
		 */
		
		
		protected function getData(obj:Object):*
		{
			//abstract
			return [];
		}
	}
}