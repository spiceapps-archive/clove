package com.spice.clove.plugin.facebook.postable
{
	import com.facebook.commands.notifications.SendEmail;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.facebook.CloveFacebookPlugin;
	import com.spice.clove.plugin.facebook.cue.FacebookCallCue;
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.posting.IPostable;
	import com.spice.clove.plugin.posting.Postable;
	
	public class FacebookMailPostable extends Postable implements IPostable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _plugin:CloveFacebookPlugin;
		private var _data:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookMailPostable(controller:IPluginController,title:String,item:RenderedColumnData)
		{
			this._plugin = CloveFacebookPlugin(controller.plugin);
			this._data   = item;
			
			super(controller,name);
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
			var call:SendEmail = new SendEmail([_data.dataVO.source_id],message.subject,message.text,null);
			
			this._plugin.call(new FacebookCallCue(call,onResult));
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
		
		private function onResult(data:*=null):void
		{
			this.complete();
		}
	}
}