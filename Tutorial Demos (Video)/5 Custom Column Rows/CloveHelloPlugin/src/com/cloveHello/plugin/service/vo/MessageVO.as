package com.cloveHello.plugin.service.vo
{
	public class MessageVO
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var uid:String;
        public var title:String;
        public var message:String;
        public var dateAdded:Date;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		public function MessageVO(uid:String = null,
								  title:String = null,
								  message:String = null,
								  date:Date = null)
		{
			this.uid = uid;
			this.title = title;
			this.message = message;
			this.dateAdded = date;
		}

	}
}