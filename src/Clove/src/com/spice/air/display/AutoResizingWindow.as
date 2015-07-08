package com.spice.air.display
{
	import caurina.transitions.Tweener;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.utils.*;
	
	import mx.containers.VBox;
	import mx.core.UIComponent;
	import mx.core.Window;
	import mx.events.FlexEvent;

	public class AutoResizingWindow extends Window
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var resizeToContent:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _contentHolder:VBox;
		
		
		private var _resizeTimeout:int;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		
		public function AutoResizingWindow()
		{
			this.addEventListener(Event.ADDED,onChildAdded);
			
			this.verticalScrollPolicy = 'off';
			this.horizontalScrollPolicy = 'off';
			this.showStatusBar = false;
			
			
			
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreationComplete);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function get nativeX():Number
		{
			return this.nativeWindow.x;
		}
		
		/*
		 */
		
		public function set nativeX(value:Number):void
		{
			this.nativeWindow.x = value;
		}
		
		/*
		 */
		
		public function get nativeY():Number
		{
			return this.nativeWindow.y;
		}
		
		/*
		 */
		
		public function set nativeY(value:Number):void
		{
			this.nativeWindow.y = value;
		}
		/*
		 */
		
		public function get content():DisplayObjectContainer
		{
			return _contentHolder;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
		{
			if(UIComponent(child).document == this)
			{	
				while(index > _contentHolder.numChildren) index--;
				
				return _contentHolder.addChildAt(child,index);
			}
			
			return super.addChildAt(child,index);
		
			
		}
		
		
		/*
		 */
		
		override public function removeChild(child:DisplayObject) : DisplayObject
		{
			if(super.contains(child))
			{
				return super.removeChild(child);
			}
			else
			if(_contentHolder.contains(child))
			{
				return _contentHolder.removeChild(child);
			}
			
			return null;
		}
		
		
		/*
		 */
		
		override public function contains(child:DisplayObject) : Boolean
		{
			if(!_contentHolder)
			{
				return super.contains(child);
			}
			
			return _contentHolder.contains(child);
		}
		
		
		/*
		 */
		
		public function centerWindow():void
		{
			this.nativeWindow.x = Capabilities.screenResolutionX/2 - this._contentHolder.width / 2;	
			this.nativeWindow.y = Capabilities.screenResolutionY/2 - this._contentHolder.height / 2;	
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			
			
			this.resizeToContent = true;
			
//			this.onContentResize();
			
			        
//			return;
			
			flash.utils.clearTimeout(this._resizeTimeout);
			
			
			this._resizeTimeout = flash.utils.setTimeout(onContentResize,100);
		}
		
		
		
		/*
		 */
		
		override protected function createChildren() : void
		{
			
			
			_contentHolder = new VBox();
			_contentHolder.clipContent = false;
			
			
			super.addChildAt(_contentHolder,0);
			
			super.createChildren();
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		private function onContentResize():void
		{
			if(this.closed)
				return;
			
			if(!this._contentHolder || 
				this._contentHolder.width == 0 || 
				this._contentHolder.height == 0 ||
				(this.width == this._contentHolder.measuredWidth &&
				this.height == this._contentHolder.measuredHeight))
				return;
			  
			
			var w:Number = _contentHolder.width;
			var h:Number = _contentHolder.height;
//			var w:Number = _contentHolder.measuredWidth;
//			var h:Number = _contentHolder.measuredHeight;
			var x:Number = Capabilities.screenResolutionX /2 - w/2;
			var y:Number = Capabilities.screenResolutionY /2 - h/2;
			
			
			
			
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//tweening the window size can be a pain in the ass considering it doesn't
			//like to be resized if it's closed. This causes a lot of problems so for now
			//we've commented it all out
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			
//			this.alpha = 0;
			
//			var isWindows:Boolean = Capabilities.os.search("Mac") == -1;
//			
//			if(isWindows)
//			{
//				Tweener.addTween(this,{nativeX:x,nativeY:y,width:w,height:h,time:.5});	
//			}
//			else
//			{
//				//only width and height. X & Y are gittery
//				Tweener.addTween(this,{width:w,height:h,time:.5});	
//				
//				
//			}
//			Tweener.addTween(this,{alpha:1,time:.25,delay:.5});
			 this.width = w;
			this.height =  h;  
//			this.nativeWindow.x = x;
//			this.nativeWindow.y = y; 
			
//			this.setMinSize();  
			
			
		}
		
		
		
		/*
		 */
		
		private function setMinSize():void
		{
			this.minWidth  = this.width;
			this.minHeight = this.height;
		}
		
	
	
		
		/*
		 */
		
		private function onChildAdded(event:Event):void
		{
//			this.onContentResize();
		}
		
		
		/*
		 */
		
		private function onCreationComplete(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onCreationComplete);
			
			this.centerWindow();
		}
	}
}