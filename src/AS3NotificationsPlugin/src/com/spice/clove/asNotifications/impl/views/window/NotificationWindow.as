package com.spice.clove.asNotifications.impl.views.window
{
	
	import flash.display.NativeWindowType;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	import mx.containers.Canvas;
	import mx.core.Window;
	import mx.events.AIREvent;
	
	public class NotificationWindow extends Window
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var skin:Canvas;
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _cy:int;
		private var _vGap:int = 8;
		private var _position:Point;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function NotificationWindow()
		{
			super();
			
			
			this.layout = 'absolute';
			
//			this.type = NativeWindowType.LIGHTWEIGHT;
			this.systemChrome = "none";
//			
//			//enable transparency (no white)
			this.transparent  = true;
//			
//			
			this.setStyle("showFlexChrome",false);
//			
//			//we don't want scroll bars
			this.clipContent = false;
			this.alwaysInFront = true;
			
			this.addEventListener(AIREvent.WINDOW_COMPLETE,onWindowComplete);
			
			
		}
		
		
		/**
		 */
		
		private function onWindowComplete(event:AIREvent):void
		{
			event.target.removeEventListener(event.type,onWindowComplete);
			
			this.nativeWindow.x = Capabilities.screenResolutionX - this.width;
			this.nativeWindow.y = 25;
//			this.y = Capabilities.screenResolutionY;
		}
		
		
		
		
	}
}