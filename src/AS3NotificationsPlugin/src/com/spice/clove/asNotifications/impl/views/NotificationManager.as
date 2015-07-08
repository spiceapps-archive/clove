package com.spice.clove.asNotifications.impl.views
{
	import com.spice.clove.asNotifications.impl.views.skin.BezelNotification;
	import com.spice.clove.asNotifications.impl.views.window.NotificationWindow;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.utils.queue.QueueManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	public class NotificationManager extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _stopped:Boolean;
		private var _activeNotifications:Array;
		private var _notificationManager:QueueManager;
		private var _activeWindow:NotificationWindow;
		
		public var enabled:Boolean = true;
		public static const MAX:int = 5;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function NotificationManager()
		{
			_activeNotifications = new Array();
			_notificationManager = new QueueManager(false);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		
		/**
		 */
		
		public function get activeNotifications():Array
		{
			return _activeNotifications;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function addNotification(value:ICloveData):ActiveNotification
		{
			
			if(!enabled)
				return null;
				
			if(!_activeWindow)
			{
				_activeWindow 		 = new NotificationWindow();
				_activeWindow.width  = 305;
				_activeWindow.height = Capabilities.screenResolutionY;
				
				_activeWindow.open();
				
			}
			
			var clazz:Class = BezelNotification;
			
			var skin:BezelNotification = new BezelNotification();//clazz as NotificationSkin;
			skin.data = value;
			
			var not:ActiveNotification = new ActiveNotification(this,_activeWindow,skin);
			not.addEventListener(Event.INIT,onNotificationInit);
			
			//flood control so the heights are set accordingly
			_notificationManager.addCue(not);
			
			this.runNotificationManager();
			
			return not;
			
			
		}
		
		/**
		 */
		
		public function removeNotification(value:ActiveNotification):void
		{
			var notIndex:int = _activeNotifications.indexOf(value);
			
			_activeNotifications.splice(notIndex,1);
			
			this.runNotificationManager();
		}
		
		/**
		 */
		
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		private function onNotificationInit(event:Event):void
		{
			event.target.removeEventListener(event.type,onNotificationInit);
			
			
			_activeNotifications.push(event.target);
			
			this.runNotificationManager();
		}
		
		/**
		 * create flood control so that only a number of notifications can be shown
		 * wait until all the old notifications are gone before adding new ones
		 */
		
		private function runNotificationManager():void
		{
			if(_activeNotifications.length > MAX)
			{
				_notificationManager.stop();
				
				//set stopped to true so that the notifications do not start until 
				//the active notifications reach 0
				_stopped = true;
			}
			else
			if(!_stopped || _activeNotifications.length == 0)
			{
				_notificationManager.start();
				_stopped = false;
			}
			
			if(_activeNotifications.length == 0)
			{
				_activeWindow.close();
				_activeWindow = undefined;
			}
			
		}
	}
}
	import caurina.transitions.Tweener;
	
	import com.spice.clove.asNotifications.impl.views.NotificationManager;
	import com.spice.events.QueueManagerEvent;
	import com.spice.utils.queue.cue.ICue;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	
	import mx.containers.Canvas;
	import mx.core.Window;
	import mx.events.FlexEvent;
	

	class ActiveNotification extends EventDispatcher implements ICue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _manager:NotificationManager;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		public var currentWindow:Window;
		public var skin:Canvas;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ActiveNotification(manager:NotificationManager,currentWindow:Window,skin:Canvas)
		{    
			_manager  		   = manager;
			this.currentWindow = currentWindow;
			this.skin		   = skin;
	
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function init():void
		{
			this.skin.alpha = 0;
			
			this.skin.addEventListener(FlexEvent.CREATION_COMPLETE,onComplete);
			
			this.currentWindow.addChild(this.skin);
			
			Tweener.addTween(this.skin,{alpha:1,time:.5,delay:1,transition:'linear'});
			
			dispatchEvent(new Event(Event.INIT));
			
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onComplete(event:FlexEvent):void
		{
			var i:int = this.currentWindow.numChildren > 1 ? 2 : 1;
			
			var cc:DisplayObject = this.currentWindow.getChildAt(this.currentWindow.numChildren-i);
			
			this.skin.y = cc.y + (i > 1 ? cc.height : 0) + 5;
			
			
			
			dispatchEvent(new QueueManagerEvent(QueueManagerEvent.CUE_COMPLETE));
			
			setTimeout(onSleep,6000);
		}
       
        /**
		 */
		
		private function onSleep():void
		{
			Tweener.addTween(this.skin,{alpha:0,time:.5,onComplete:onOut,transition:'linear'});
			
			
		}
		
		/**
		 */
		
		private function onOut():void
		{
			
			_manager.removeNotification(this);
			
			this.skin.parent.removeChild(this.skin);
			
			
			
		}
		
		
	}

