package com.spice.clove.twitter.impl.content.control
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.content.control.option.TwitterDataOptionType;
	import com.spice.clove.twitter.impl.content.control.render.TwitterSearchDataRenderer;

	public class TwitterDMContentController extends AbstractTwitterContentController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterDMContentController(name:String,plugin:TwitterPlugin)
		{
			super(name,plugin,new TwitterSearchDataRenderer(this,plugin.getPluginMediator()),[TwitterDataOptionType.DELETE_DIRECT_MESSAGE]);
			
			this.setName("Direct Messages");
			
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
			this.fillonCueComplete(this.getTwitterAccount().connection.getDirectMessages(15,0,NaN,NaN));
		}
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			super.loadOlder(data);
			
			this.fillonCueComplete(this.getTwitterAccount().connection.getDirectMessages(15,0,Number(data.getUID()),NaN));
		}
	}
}