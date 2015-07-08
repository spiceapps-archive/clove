package com.spice.cloveHello.service.vo
{
	public class MessageValueObject
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var title:String;
        public var message:String;
        public var uid:String;
        public var date:Date;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function MessageValueObject(title:String,
									       message:String,
									       uid:String,
									       date:Date)
		{
			this.title = title;
			this.message = message;
			this.uid = uid;
			this.date = date;
		}

	}
}