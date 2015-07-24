package com.cloveHello.plugin.column.render
{
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	
	public class HelloColumnItemRenderer implements ICloveColumnItemRenderer
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function HelloColumnItemRenderer()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function getUID(data:Object):String
		{
			return "test";
		}
		
		/**
		 */
		
		public function getRenderedData(data:Object):RenderedColumnData
		{
			return new RenderedColumnData(data.uid,data.dateAdded,data.title,data.message);
		}

	}
}