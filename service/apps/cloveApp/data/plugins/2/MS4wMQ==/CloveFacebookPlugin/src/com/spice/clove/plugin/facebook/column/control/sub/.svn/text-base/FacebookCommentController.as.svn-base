package com.spice.clove.plugin.facebook.column.control.sub
{
	import com.facebook.commands.stream.GetComments;
	import com.facebook.data.stream.GetCommentsData;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.facebook.column.control.FacebookColumnController;
	import com.spice.clove.plugin.facebook.column.render.sub.FacebookCommentItemRenderer;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;
	
	public class FacebookCommentController extends FacebookColumnController
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable] 
        [Setting]
        public var id:String;
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function FacebookCommentController(id:String = null)
		{
			super(null,new FacebookCommentItemRenderer());
			
			this.id = id;
			
			this.title = "Comments";
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function onColumnStartLoad(event:CloveColumnEvent):void
		{
			
			
			this.call(new GetComments(id),onGetComments);
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onGetComments(data:GetCommentsData):void
		{
			this.fillColumn(data.comments);
		}
	}
}