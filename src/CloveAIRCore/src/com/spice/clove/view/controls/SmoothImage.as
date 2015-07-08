package com.spice.clove.view.controls
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.controls.Image;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	public class SmoothImage extends Image
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function SmoothImage()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		override mx_internal function contentLoaderInfo_completeEventHandler(
                                        event:Event):void
	    {
	        var bm:Bitmap = event.target.content;
	        
			var bm:Bitmap = new Bitmap(bm.bitmapData,'auto',true);
			
			super.source = bm;
	    } 

	}
}