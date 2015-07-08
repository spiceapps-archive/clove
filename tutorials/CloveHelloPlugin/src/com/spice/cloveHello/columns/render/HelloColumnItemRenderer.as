package com.spice.cloveHello.columns.render
{
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.cloveHello.service.vo.MessageValueObject;
	
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
		
		public function getUID(value:Object):String
		{
			return MessageValueObject(value).uid;
		}
		
		/**
		 */
		
		public function getRenderedData(value:Object):RenderedColumnData
		{
			return new RenderedColumnData(value.uid,value.date,value.title,value.message);
		}

	}
}