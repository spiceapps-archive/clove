package com.spice.clove.plugins.digg
{
	import com.architectd.digg2.data.StoryData;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class DiggPluginSettings
	{

		[Setting]
		public var displayName:String = "Digg";
		
		
		[Setting]
		public var username:String;
		
		
		[Setting]
		public var installed:Boolean;
		
		[Table(voClass="com.architectd.digg2.data.UserData")]
		public var friends:ArrayCollection = new ArrayCollection();
		
		
		[Table(voClass="com.architectd.digg2.data.StoryData")]
		public var dugg:ArrayCollection    = new ArrayCollection();
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function hasDugg(storyId:Number):Boolean
		{
			for each(var sd:StoryData in dugg.source)
			{
				if(sd.id == storyId)
					return true;
			}
			
			return false;
		}
		
		
		
	}
}