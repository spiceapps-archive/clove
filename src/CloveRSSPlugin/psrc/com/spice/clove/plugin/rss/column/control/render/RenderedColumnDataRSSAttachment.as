package com.spice.clove.plugin.rss.column.control.render
{
	import com.spice.clove.plugin.column.render.RenderedColumnDataAttachment;
	
	import mx.controls.HTML;
	
	[Bindable]
	[RemoteClass(alias="RenderedColumnDataRSSAttachment")]
	public class RenderedColumnDataRSSAttachment extends RenderedColumnDataAttachment
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var rssBody:String = null;
        
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function RenderedColumnDataRSSAttachment(rssBody:String = null)
		{
			super("Full article",null);
			
			
			this.rssBody = rssBody;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function get attachmentView():Class
		{
			return RenderedColumnDataRSSAttachmentView;
		}

	}
}