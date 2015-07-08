package com.spice.clove.fantasyVictory.impl.service.events
{
	import flash.events.Event;

	public class FantasyVictoryServiceEvent extends Event
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const RBS_LOADED:String = "rbsLoaded";
		public static const QBS_LOADED:String = "qbsLoaded";
		public static const WRS_LOADED:String = "wrsLoaded";
		
		
		public var data:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FantasyVictoryServiceEvent(type:String,data:Array)
		{
			super(type);
			
			this.data= data;
		}
		
		
	}
}