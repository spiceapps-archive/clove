package com.spice.clove.plugins.digg.cue
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.calls.stories.DiggStoryCall;
	import com.architectd.digg2.data.StoryData;
	import com.architectd.digg2.events.DiggEvent;
	import com.spice.clove.plugins.digg.DiggPlugin;
	
	public class DiggStoryCue extends DiggCue
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _story:StoryData;
		private var _connection:DiggService;
		
		
		[Bindable] 
		private var _plugin:DiggPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function DiggStoryCue(plugin:DiggPlugin,storyId:Number)
		{
			_story = new StoryData();
			_story.id = storyId;
			
			
			_plugin = plugin;
			
			super(_plugin.connection,new DiggStoryCall(Number(storyId)));
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function onNewData(event:DiggEvent):void
		{
			
			//add the dugg item to the database 
			_plugin.model.settings.dugg.addItem(_story);
			
			
			this.dispatchEvent(event.clone());
		}

	}
}