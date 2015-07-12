package com.spice.clove.plugin.facebook.postable
{
	import com.facebook.commands.users.SetStatus;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.facebook.CloveFacebookPlugin;
	import com.spice.clove.plugin.facebook.cue.FacebookCallCue;
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.posting.IPostable;
	import com.spice.clove.plugin.posting.Postable;
	
	public class FacebookWallPostable extends Postable implements IPostable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _plugin:CloveFacebookPlugin;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookWallPostable(plugin:IPluginController,title:String)
		{
			_plugin = CloveFacebookPlugin(plugin.plugin);
			
			super(plugin,title);
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
			
			if(this.message.hasAttachmens())
			{	
				for each(var att:Attachment in message.attachments)
				{
					new FacebookPhotoPoster(message.text,att.file.clone(),this._plugin,onPost);
				}
			}
			else
			{
				
				this._plugin.call(new FacebookCallCue(new SetStatus(message.text,false,true),onPost));
			}
		}
		
		/**
		 */
		
		public function prepareAttachment(att:Attachment):void
		{
			//nothing
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onPost(data:*=null):void
		{
			this.complete();
		}

	}
}