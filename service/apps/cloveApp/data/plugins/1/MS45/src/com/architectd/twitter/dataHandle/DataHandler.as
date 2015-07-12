package com.architectd.twitter.dataHandle
{
	public class DataHandler implements IDataHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function DataHandler()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function getResponseData(raw:String):*
		{
			return this.getResponseData2(raw);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		protected function getResponseData2(raw:String):*
		{
			return null;
		}
	}
}