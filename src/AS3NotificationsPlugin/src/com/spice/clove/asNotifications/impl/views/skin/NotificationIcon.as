package com.spice.clove.asNotifications.impl.views.skin
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	
	public class NotificationIcon extends Canvas
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _source:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function NotificationIcon()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get source():Object
		{
			return _source;
		}
		
		/**
		 */
		
		public function set source(value:Object):void
		{
			if(value is DisplayObjectContainer)
			{
				addChild(value as DisplayObject);
			}
			else
			{
				var im:Image = new Image();
				im.source = value;
				im.percentHeight = 100;
				im.percentWidth  = 100;
				addChild(im);
			}
			
			_source = value;
		}

	}
}