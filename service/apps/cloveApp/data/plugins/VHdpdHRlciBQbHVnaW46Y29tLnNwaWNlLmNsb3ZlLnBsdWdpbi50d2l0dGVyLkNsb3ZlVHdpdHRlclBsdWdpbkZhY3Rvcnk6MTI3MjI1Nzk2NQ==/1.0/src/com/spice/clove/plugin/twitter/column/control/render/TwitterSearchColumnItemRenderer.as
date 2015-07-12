package com.spice.clove.plugin.twitter.column.control.render
{
	import com.spice.clove.plugin.column.render.IReusableCloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	
	/*
	  Handles data from a twitter search 
	  @author craigcondon
	  
	 */	
	 
	public class TwitterSearchColumnItemRenderer extends TwitterRowItemRenderer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TwitterSearchColumnItemRenderer()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/*
		 */
		
		override public function getRenderedData(vo:Object):RenderedColumnData
		{
			return super.getRenderedData(vo);
			
		}
	}
}