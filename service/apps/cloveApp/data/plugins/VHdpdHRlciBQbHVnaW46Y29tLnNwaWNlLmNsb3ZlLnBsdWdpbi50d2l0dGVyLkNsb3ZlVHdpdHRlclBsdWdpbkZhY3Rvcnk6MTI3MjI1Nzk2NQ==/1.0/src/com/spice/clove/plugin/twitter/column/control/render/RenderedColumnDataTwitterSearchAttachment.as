package com.spice.clove.plugin.twitter.column.control.render
{
	import com.spice.clove.events.plugin.ColumnControllerEvent;
	import com.spice.clove.plugin.column.render.link.RenderedColumnDataLinkAttachment;
	import com.spice.clove.plugin.twitter.column.control.TwitterKeywordSearchColumnController;
	
	[Bindable] 
	[RemoteClass(alias="RenderedColumnDataTwitterRefAttachment")]
	public class RenderedColumnDataTwitterSearchAttachment extends  RenderedColumnDataLinkAttachment
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function RenderedColumnDataTwitterSearchAttachment(username:String = null)
		{
			super(username,username);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/*
		 */
		
		override public function get attachmentView() : Class
		{
			return null;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function select():void
		{
			
			var keyword:String = this.label;
			
			
			var userController:TwitterKeywordSearchColumnController = new TwitterKeywordSearchColumnController();
			userController.search = keyword;
			userController.pluginController = this.data.column.controller.pluginController;
			
//			new CreateColumnEvent([userController]).dispatch();
			
			this.data.column.controller.dispatchEvent(new ColumnControllerEvent(ColumnControllerEvent.SET_BREADCRUMB,userController));
		}

	}
}