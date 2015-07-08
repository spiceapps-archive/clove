package com.spice.clove.twitter.impl.content.control
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.content.control.render.TwitterSearchDataRenderer;
	
	public class TwitterMentionsContentController extends AbstractTwitterContentController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterMentionsContentController(name:String,plugin:TwitterPlugin)
		{
			super(name,plugin,new TwitterSearchDataRenderer(this,plugin.getPluginMediator()));
			
			this.setName("Mentions");
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
			this.fillonCueComplete(this.getTwitterAccount().connection.getMentions(15,0,NaN));
		}
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			this.fillonCueComplete(this.getTwitterAccount().connection.getMentions(15,0,Number(data.getUID())));
		}
	}
}