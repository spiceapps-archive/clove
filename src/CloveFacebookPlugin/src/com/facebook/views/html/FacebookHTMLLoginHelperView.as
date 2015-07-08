package com.facebook.views.html
{
	import com.facebook.events.FacebookEvent;
	import com.facebook.views.Distractor;
	
	import flash.events.Event;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import mx.core.UIComponent;
	
	public class FacebookHTMLLoginHelperView extends  UIComponent
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        
		public static const DEFAULT_WIDTH:Number = 640;
		public static const DEFAULT_HEIGHT:Number = 480;
		public static const PADDING:Number = 20;
		
		public static const PATH:String = 'http://www.facebook.com/login.php';
		public static const SUCCESS_PATH:String = 'http://www.facebook.com/connect/login_success.html';
		public static const FAILURE_PATH:String = 'http://www.facebook.com/connect/login_failure.html';
		
		public var urlVars:URLVariables;
		public var req:URLRequest;
		
		public var sessionParams:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _html:HTMLLoader;
		private var _distractor:Distractor;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function FacebookHTMLLoginHelperView()
		{
			_html = new HTMLLoader();
			_html.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			_html.addEventListener(Event.LOCATION_CHANGE, onLocationChange, false, 0, true);	
			
			_distractor = new Distractor();
			addChild(_html);
			addChild(_distractor);
			
			
			
			this.urlVars = new URLVariables();
			
			urlVars.next = SUCCESS_PATH;
      		urlVars.cancel_url = FAILURE_PATH;
			urlVars.v = "1.0";
      		urlVars.return_session = true;
			urlVars.fbconnect = true;
			urlVars.nochrome = true;
	      	urlVars.connect_display = "popup";
			urlVars.display = "popup";
			
			req = new URLRequest();
			req.data = urlVars;
			
			
			req.url = PATH;	
			
			_distractor.text = "Logging In";
			
			
			this.width = DEFAULT_WIDTH;
			this.height = DEFAULT_HEIGHT;
			
			this.repositionDistractor();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function connect(apiKey:String):void
		{
			urlVars.api_key = apiKey;
			
			_html.load(req);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onComplete(event:Event):void
		{
			_distractor.visible = false;
			this.height = _html.height = _html.contentHeight;
			this.width  = _html.width  = _html.contentWidth;
			
			this.repositionDistractor();
		}
		
		/**
		 */
		
		private function onLocationChange(event:Event):void
		{
			//login success
      		if(_html.location.indexOf(SUCCESS_PATH) == 0){ 
      			sessionParams = _html.location;
      			
      			dispatchEvent(new FacebookEvent(FacebookEvent.LOGIN_SUCCESS, false, false, true));      			
      		//login failure
      		} else if (_html.location.indexOf(FAILURE_PATH) == 0 || _html.location.indexOf('home.php') > -1) { 
      			dispatchEvent(new FacebookEvent(FacebookEvent.LOGIN_FAILURE));
      		//show distractor
      		} else { 
				_html.width = _html.height = 0;
				_distractor.visible = true;
      		}
		}
		
		/**
		 */
		
		private function repositionDistractor():void
		{
			_distractor.x = width - _distractor.width >> 1;
			_distractor.y = height - _distractor.height >> 1;
		}
		
		
		/**
		 */
		
		private function close():void
		{
			
		}

	}
}