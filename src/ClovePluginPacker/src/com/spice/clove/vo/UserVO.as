package com.spice.clove.vo
{
	
	[Bindable] 
	[RemoteClass(alias='UserVO')]
	public class UserVO
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var username:String;
        public var password:String;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function UserVO(username:String=null,password:String=null)
		{
			this.username = username;
			this.password = password;
		}

	}
}