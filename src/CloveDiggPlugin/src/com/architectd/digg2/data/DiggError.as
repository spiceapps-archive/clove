package com.architectd.digg2.data
{
	public class DiggError
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var errorCode:int;
		public var message:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggError(errorCode:int,message:String)
		{
			Logger.log("code="+errorCode+" message="+message,this);
			
			this.errorCode = errorCode;
			this.message   = message;
		}
	}
}