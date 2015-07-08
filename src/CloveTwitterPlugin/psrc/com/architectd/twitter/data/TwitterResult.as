package com.architectd.twitter.data
{
	public class TwitterResult
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var success:Boolean;
        public var status:int;
        public var response:*;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 public function TwitterResult(response:*,status:int = 200)
		 {
		 	this.success = status == TwitterStatusType.SUCCESS;
		 	this.status  = status;
		 	this.response = response;
		 }
	}
}