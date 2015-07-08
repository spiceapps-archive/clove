package com.spice.clove.plugin.core.root.desktop.views.column.group
{
	import com.spice.clove.view.icon.ToolIcons;
	import com.spice.utils.SpriteUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	
	import mx.containers.Canvas;
	import mx.managers.CursorManager;
	
	
	[Event(name="dragging",type="flash.events.Event")]
	[Event(name="resizeComplete",type="flash.events.Event")]
	
	public class DragLine extends Canvas
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _dragging:Boolean;
		private var _dragCursor:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function DragLine()
		{
			super();
			
			this.percentHeight = 100;
			
			
			
			
			this.setStyle("backgroundColor",0x000000);
			this.setStyle("backgroundAlpha",0);
			this.width = 5;
			this.percentHeight = 100;
			
			
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,hideDragger);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
       
		
		/*
		 */
		
		private function onMouseOver(event:MouseEvent):void
		{
			if(event.currentTarget != this)
				return;
			
			_dragCursor = CursorManager.setCursor(ToolIcons.RESIZE,2,-8,-8);
			
			
//			SpriteUtil.mouseIsOverCheck(this,hideDragger);
		}
		
		/*
		 */
		
		private function onMouseDown(event:MouseEvent):void
		{
			_dragging = true;
			
			this.addEventListener(Event.ENTER_FRAME,onDragging,false,0,true);
			this.root.addEventListener(MouseEvent.MOUSE_UP,onMouseUp,false,0,true);
		}
		
		/*
		 */
		
		private function onDragging(event:Event):void
		{
			dispatchEvent(new Event("dragging"));	
		}
		/*
		 */
		
		private function onMouseUp(event:MouseEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onMouseUp);
			this.removeEventListener(Event.ENTER_FRAME,onDragging);
			
			this.dispatchEvent(new Event("resizeComplete"));
				
			_dragging = false;
			
			
			hideDragger(null);
		}
		 
		
		
		/*
		 */
		
		private function hideDragger(event:MouseEvent):void
		{
			if(event && event.currentTarget != this)
				return;
			
			if(!_dragging)
			{
				CursorManager.removeAllCursors();
				flash.utils.setTimeout(Mouse.show,1);
			}
			/*else
			{
				SpriteUtil.mouseIsOverCheck(this,hideDragger);
			}*/
		}
	}
}