package com.spice.clove.plugin.gdgt.postable
{
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.posting.IPostable;
	import com.spice.clove.plugin.posting.Postable;
	
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	
	public class WriteGDGTReviewPostable extends Postable implements IPostable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _data:RenderedColumnData;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function WriteGDGTReviewPostable(controller:IPluginController,data:RenderedColumnData)
		{
			super(controller,data.title);
			
			_data = data;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function prepareAttachment(att:Attachment):void
		{
			//nothing
		}
		
		/*
		 */
		
		override public function init():void
		{
			
			//for this concept, just show a prompt
			Alert.show("Item: "+_data.title+" \n\n Review: "+this.message.text,"Example");
			
			
			
			flash.utils.setTimeout(this.complete,1000);
		}

	}
}