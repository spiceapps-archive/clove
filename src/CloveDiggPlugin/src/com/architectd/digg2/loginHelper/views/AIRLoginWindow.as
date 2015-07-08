package com.architectd.digg2.loginHelper.views
{
	import com.architectd.digg2.loginHelper.AIRLoginHelper;
	import com.coderanger.QueryString;
	
	import flash.events.DataEvent;
	
	import mx.core.Window;
	
	public class AIRLoginWindow extends Window
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _helper:AIRLoginHelper;
		private var _content:HTMLLoginHelperView;
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const OAUTH_PAGE:String = "http://digg.com/oauth/authenticate?oauth_token=";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AIRLoginWindow(helper:AIRLoginHelper)
		{
			_helper = helper;
			_content = new HTMLLoginHelperView();
			_content.percentHeight = 100;
			_content.percentWidth  = 100;
			this.width  = 700; //840
			this.height = 700;
			
			this.horizontalScrollPolicy = 'off';
			this.verticalScrollPolicy = 'off';
			this.resizable = false;
			this.showGripper = false;
			this.showStatusBar = false;
			
			_content.addEventListener(DataEvent.DATA,onData);
			_content.service = helper.service;
			
			addChild(_content);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
	
		private function onData(event:DataEvent):void
		{
			this.dispatchEvent(event.clone());
		}
		
		
	}
}