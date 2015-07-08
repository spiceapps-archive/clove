package com.architectd.digg2.data.handle
{
	import com.architectd.digg2.data.SuccessData;

	public class SuccessResponseHandler implements IResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SuccessResponseHandler()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getResult(raw:String):Array
		{
			var x:XML = new XML(raw);
			
			
			return [new SuccessData(x.@status)];
		}
	}
}