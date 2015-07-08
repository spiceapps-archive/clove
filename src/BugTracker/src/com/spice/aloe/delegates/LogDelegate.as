package com.spice.aloe.delegates
{
	import com.spice.remoting.amfphp.IServiceConnection;
	import com.spice.remoting.amfphp.cue.ServiceCue;
	import com.spice.remoting.amfphp.delegates.ServiceDelegate;

	public class LogDelegate extends ServiceDelegate
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function LogDelegate(connection:IServiceConnection)
		{
			super(connection,"LogService");
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function log(code:int,description:String,metadata:Object = null,project:int = -1):ServiceCue
		{	
			return this.call("log",code,description,metadata,project);
		}
	}
}