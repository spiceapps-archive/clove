package com.architectd.digg2.data.handle
{
	import com.architectd.digg2.data.VerifyLoginData;

	public class VerifyLoginHandler extends ResponseHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getResult2(data:XML) : Array
		{
			
			return [new VerifyLoginData(data.@user)];
		}
	}
}