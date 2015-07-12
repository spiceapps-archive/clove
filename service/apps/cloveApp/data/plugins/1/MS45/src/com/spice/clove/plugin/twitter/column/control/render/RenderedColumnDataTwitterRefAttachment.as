package com.spice.clove.plugin.twitter.column.control.render
{
	import com.spice.clove.events.plugin.ColumnControllerEvent;
	import com.spice.clove.plugin.column.render.link.RenderedColumnDataLinkAttachment;
	import com.spice.clove.plugin.twitter.column.control.TwitterUserSearchColumnController;
	
	[Bindable] 
	[RemoteClass(alias="RenderedColumnDataTwitterRefAttachment")]
	public class RenderedColumnDataTwitterRefAttachment extends  RenderedColumnDataLinkAttachment
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function RenderedColumnDataTwitterRefAttachment(username:String = null)
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
			
			var user:String = this.label;
			
			
			var userController:TwitterUserSearchColumnController = new TwitterUserSearchColumnController();
			userController.search = user;
			userController.pluginController = this.data.column.controller.pluginController;
			
//			new CreateColumnEvent([userController]).dispatch();

			this.data.column.controller.dispatchEvent(new ColumnControllerEvent(ColumnControllerEvent.SET_BREADCRUMB,userController));
		}

	}
}