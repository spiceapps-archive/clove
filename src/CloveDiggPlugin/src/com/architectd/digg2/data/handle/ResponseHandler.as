package com.architectd.digg2.data.handle
{
	public class ResponseHandler implements IResponseHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getResult(raw:String):Array
		{
			var ex:XML = new XML(raw);
			
			return this.getResult2(ex);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function getResult2(data:XML):Array
		{
			return [];
		}
	}
}