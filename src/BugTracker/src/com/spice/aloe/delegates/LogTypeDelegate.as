package com.spice.aloe.delegates
{
	import com.spice.remoting.amfphp.IServiceConnection;
	import com.spice.remoting.amfphp.delegates.ServiceDelegate;

	public class LogTypeDelegate extends ServiceDelegate
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function LogTypeDelegate(connection:IServiceConnection)
		{
			super(connection,"LogTypeService");
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function addLogType(code:int,description:String,project:String):void
		{
			this.call("addLogType",code,description,project);
		}
	}
}