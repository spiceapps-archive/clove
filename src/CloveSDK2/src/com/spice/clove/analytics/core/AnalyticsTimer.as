package com.spice.clove.analytics.core
{
	import flash.utils.getTimer;

	public class AnalyticsTimer
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _helper:AnalyticsPluginHelper;
		private var _startTime:Number;
		private var _thresholdTime:Number;
		private var _actionType:String;
		private var _content:String;
		private var _metadata:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AnalyticsTimer(helper:AnalyticsPluginHelper,
									   actionType:String,
									   content:String = null,
									   thresholdTime:Number = -1)
		{
			this._helper 	    = helper;
			this._actionType    = actionType;
			this._thresholdTime = thresholdTime;
			this._content 		= content;
			
			this._startTime = -1;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getContent():String
		{
			return this._content;
		}
		
		/**
		 */
		
		public function setContent(value:String):void
		{
			this._content = value;
		}
		
		/**
		 */
		
		public function getActionType():String
		{
			return this._actionType;
		}
		/**
		 */
		
		public function startTimer():void
		{
			this._startTime = flash.utils.getTimer();
		}
		
		
		/**
		 */
		
		public function stopAndRecordTime():void
		{
			if(this._startTime == -1)
				return;
			
			var ctime:Number = flash.utils.getTimer();
			
			var duration:Number = ctime - this._startTime;	
			
			this._startTime = -1;
			
			//don't do anything with the duration for now. What might be best is to send it to the server
			//and pick out any outliers 
			
			this._helper.recordAction(this._actionType,this._content,duration/1000,this._metadata);
		}
	}
}