package com.architectd.digg2.loginHelper
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.loginHelper.views.AIRLoginWindow;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.events.DataEvent;
	
	
	public class AIRLoginHelper extends Cue implements IDiggLoginHelper
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		[Bindable] 
		public var service:DiggService;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _loginWindow:AIRLoginWindow;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AIRLoginHelper()
		{
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
			_loginWindow = new AIRLoginWindow(this);
			_loginWindow.addEventListener(DataEvent.DATA,onData);
			_loginWindow.open();
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
	
		private function onData(event:DataEvent):void
		{
			
			this.service.settings.pin = String(event.data);
			
			this.complete();
		}
	}
}