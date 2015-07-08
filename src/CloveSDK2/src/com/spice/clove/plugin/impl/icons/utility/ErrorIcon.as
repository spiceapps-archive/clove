package com.spice.clove.plugin.impl.icons.utility
{
	import com.spice.utils.EmbedUtil;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ErrorIcon extends Sprite
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Embed("Error-N.png")]
		private var _refreshingIcon:Class;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function ErrorIcon()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
			loader.loadBytes(EmbedUtil.toImageByteArray( _refreshingIcon));
//			this.x = -7;			
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
			return 14;
		}
		
		/*
		 */
		
		override public function get height():Number
		{
			return 14;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
		
		/*
		 */
		
		private function onImageLoad(event:Event):void
		{
			var bm:Bitmap = Bitmap(event.target.content);
			bm.smoothing = true;
			addChild(bm);
////			
//			bm.x = -bm.width/2;
//			bm.y = -bm.height/2;
			
		}

	}
}