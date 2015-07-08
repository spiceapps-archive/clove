package com.spice.clove.twitter.impl.content.control
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.content.control.render.TwitterSearchDataRenderer;
	
	public class TwitterTimelineContentController extends AbstractTwitterContentController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterTimelineContentController(name:String,plugin:TwitterPlugin)
		{ 
			super(name,plugin,new TwitterSearchDataRenderer(this,plugin.getPluginMediator()));
			
			this.setName("Timeline");
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
			
			this.fillonCueComplete(this.getTwitterAccount().connection.getHomeTimeline(15,0,NaN));
		}
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			this.fillonCueComplete(this.getTwitterAccount().connection.getHomeTimeline(15,0,Number(data.getUID())));
		}
	}
}