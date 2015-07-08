package com.spice.clove.twitter.impl.content.control.sub
{
	import com.architectd.twitter2.calls.GetConversationCall;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.content.control.AbstractTwitterContentController;

	public class TwitterConversationContentController extends AbstractTwitterContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var inReplyToStatusId:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _call:GetConversationCall;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function TwitterConversationContentController(plugin:TwitterPlugin,
															 itemRenderer:AbstractCloveDataRenderer,
															 inReplyToStatusId:Number)
		{
			super("twitter conversation",plugin,itemRenderer);
			
			this.setName("Conversation");
			
			this.inReplyToStatusId = inReplyToStatusId;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function loadNewer2(data:ICloveData=null):void
		{
			
			this.fillonCueComplete((_call = this.getPublicOrPrivateConnection().trackConversation(this.inReplyToStatusId)));
		}
	}
}