package com.spice.clove.plugin.impl.icons.utility
{
	import com.spice.utils.EmbedUtil;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class RefrechIcon extends Sprite
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Embed("Refreshing-N.png")]
		private var _refreshingIcon:Class;
		
		private var _loader:Loader;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function RefrechIcon()
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
			_loader.loadBytes(EmbedUtil.toImageByteArray( _refreshingIcon));
			_loader.x = 8;
			_loader.y = 8;
			addChild(_loader);
//			this.x   = -8;
//			this.y   = 8;
			
			this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		override public function get width():Number
		{
			return 16;
		}
		
		/*
		 */
		
		override public function get height():Number
		{
			return 16;
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onEnterFrame(event:Event):void
		{
			_loader.rotation -= 10;
		}
		
		/*
		 */
		
		private function onImageLoad(event:Event):void
		{
			var bm:Bitmap = Bitmap(event.target.content);
			bm.smoothing = true;
//			
			bm.x = -bm.width/2;
			bm.y = -bm.height/2;
		}

	}
}