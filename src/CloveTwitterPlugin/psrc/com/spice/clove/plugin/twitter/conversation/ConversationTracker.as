package com.spice.clove.plugin.twitter.conversation
{
	import com.adobe.serialization.json.JSON;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.swfjunkie.tweetr.data.objects.UserData;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.IResponder;
	
	
	/**
	 * handles twitter conversations 
	 * @author craigcondon
	 * 
	 */	
	 
	public class ConversationTracker
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private const SERVICE:String = "http://architectd.com/projects/clove/twitterConv/";
		
		private var _responder:IResponder;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ConversationTracker(responder:IResponder)
		{
			_responder = responder;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function getConversationLength(id:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onConversationLength);
			loader.load(new URLRequest(this.getServiceUrl(id,"getConversationLength")));
		}
		
		/**
		 */
		
		public function getConversation(id:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onConversation);
			loader.load(new URLRequest(this.getServiceUrl(id,"getConversation")));
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		protected function getServiceUrl(id:String,type:String):String
		{
			return SERVICE+"?id="+id+"&type="+type;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onConversationLength(event:Event):void
		{
			
			
			event.currentTarget.removeEventListener(event.type,onConversationLength);
			
			return;
			var length:int = JSON.decode(event.target.data).length;
			
			
			this._responder.result(length);
		}
		
		/**
		 */
		
		private function onConversation(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onConversation);
			
			
			return;
			
			var convs:Array = JSON.decode(event.target.data);
			
			var result:Array = [];
			
			
			//skip the first ID since it'll already be there
			for(var i:int = 1; i < convs.length; i++)
			{
				var conv:Object = convs[i];
				
				var user:UserData = new UserData(0,conv.name,conv.screenName);
				
				
				result.push(new RenderedColumnData(conv.id,new Date(),user.name,conv.text,conv.pic_square));
				
				
			}
			this._responder.result(result);
		}

	}
}