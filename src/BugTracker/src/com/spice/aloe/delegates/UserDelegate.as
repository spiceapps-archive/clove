package com.spice.aloe.delegates
{
	import com.spice.remoting.amfphp.IServiceConnection;
	import com.spice.remoting.amfphp.delegates.ServiceDelegate;

	public class UserDelegate extends ServiceDelegate
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UserDelegate(connection:IServiceConnection)
		{
			super(connection,"UserService");
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function login(user:String,pass:String):void
		{
			this.call("login",user,pass);
		}
	}
}