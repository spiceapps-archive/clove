package com.spice.clove.plugin.facebook.cue
{
	import com.facebook.commands.stream.GetStream;
	import com.spice.utils.queue.cue.StateCue;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;

	public class StreamCallCue extends StateCue
	{
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _callback:Function;
		
		private var _filterKey:String;
		
		private var _friendIDs:Array;
		
		private var _startTime:Date;
		
		private var _endTime:Date;
		
		[Bindable] 
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();

		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function StreamCallCue(callback:Function,
									  friendIDs:Array,
									  startTime:Date,
									  endTime:Date,
									  filterKey:String = null)
		{
			_filterKey = filterKey;
			_callback  = callback;
			_startTime = startTime;
			_endTime   = endTime;
			_friendIDs = friendIDs;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function init() : void
		{
			super.init();
			
//			var now:Date = new Date();
//			var lastWeek:Date = new Date(now.getTime() - (1000*60*60*24*14));//14 days
//			
			//NOTE: for some reason, either Facebook caches requests, or something is screwy. newer content
			//doesn't show right away
			
			
			var stream:GetStream = new GetStream(_model.facebookID,this._friendIDs,_startTime,_endTime,30,_model.getFilterKeyByName(_filterKey));
			
			new FacebookCallCue(stream,resultCallback).init();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function resultCallback(data:*):void
		{
			this._callback(data);
			
			this.complete();
		}
	}
}