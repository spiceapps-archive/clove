package com.spice.clove.plugin.facebook.postable
{
	import com.facebook.commands.stream.AddComment;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.facebook.CloveFacebookPlugin;
	import com.spice.clove.plugin.facebook.cue.FacebookCallCue;
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.posting.IPostable;
	import com.spice.clove.plugin.posting.Postable;
	
	public class FacebookReplyPostable extends Postable implements IPostable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _postid:String;
		private var _plugin:CloveFacebookPlugin;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookReplyPostable(controller:IPluginController,title:String,postid:String)
		{
			this._plugin = CloveFacebookPlugin(controller.plugin);
			this._postid = postid;
			
			
			super(controller,title);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		override public function init():void
		{
			this._plugin.call(new FacebookCallCue(new AddComment(_postid,message.text),onPost));
			
		}
		/**
		 */
		
		public function prepareAttachment(att:Attachment):void
		{
			//nothing
		}
		
		/**
		 */
		
		public function onPost(data:*=null):void
		{
			this.complete();
		}

	}
}