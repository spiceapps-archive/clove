package com.spice.aloe.delegates
{
	import com.spice.aloe.BugPriority;
	import com.spice.remoting.amfphp.IServiceConnection;
	import com.spice.remoting.amfphp.cue.ServiceCue;
	import com.spice.remoting.amfphp.delegates.ServiceDelegate;

	public class BugTrackDelegate extends ServiceDelegate
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BugTrackDelegate(connection:IServiceConnection)
		{
			super(connection,"BugTrackingService");
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function submit(description:String,
							   project:int,
							   priority:int = BugPriority.NORMAL, 
							   author:int = -1,
							   tags:Object = null):ServiceCue
		{
			
			return this.call("report",description,priority,project,tags);
		}
	}
}