package com.architectd.digg2.loginHelper.views
{
	import com.architectd.digg2.DiggService;
	import com.coderanger.QueryString;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	
	import mx.controls.HTML;
	
	[Event(name="data",type="flash.events.DataEvent")]
	
	public class HTMLLoginHelperView extends HTML
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        
		
		public static const OAUTH_PAGE:String = "http://digg.com/oauth/authenticate?oauth_token=";
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
	
		private var _service:DiggService;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function HTMLLoginHelperView()
		{
			this.horizontalScrollPolicy = 'off';
			this.verticalScrollPolicy   = 'off';
			
			this.addEventListener(Event.LOCATION_CHANGE,onLocationChange);
			
			//allow?
//			this.width  = 760;
//			this.height = 400;
			
			this.width = 700;
			this.height = 700;

		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get service():DiggService
		{
			return _service;
		}
		
		/**
		 */
		
		public function set service(value:DiggService):void
		{
			this._service = value;
			
			
			this.location = OAUTH_PAGE+value.settings.requestToken.key;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onLocationChange(event:Event):void
		{
			
			try
			{
				var ob:Object = new QueryString(this.location).toPostObject();
				
				
				if(ob.oauth_verifier)
				{
					this.dispatchEvent(new DataEvent(DataEvent.DATA,false,false,ob.oauth_verifier));
				}
				
			}catch(e:*)
			{
				
			}
			
		}

	}
}