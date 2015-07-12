package com.spice.clove.plugin.facebook.data
{
	import com.facebook.Facebook;
	import com.facebook.commands.stream.GetComments;
	import com.facebook.data.stream.GetCommentsData;
	import com.facebook.events.FacebookEvent;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	
	
	[Bindable]
	public class PostComment
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var comments:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PostComment(id:String,connection:Facebook)
		{
			
			var gc:GetComments = new GetComments(id);
			gc.addEventListener(Event.COMPLETE,onComplete);
			
			connection.post(gc);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onComplete(event:FacebookEvent):void
		{
			event.target.removeEventListener(event.type,onComplete);
			
			this.comments = GetCommentsData(event.data).comments;
			
		}
			

	}
}