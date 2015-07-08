package com.architectd.digg2
{
	import com.architectd.digg2.calls.IDiggCall;
	import com.architectd.digg2.calls.IPrivateDiggCall;
	import com.architectd.digg2.calls.oauth.GetAccessTokenCall;
	import com.architectd.digg2.calls.oauth.GetRequestTokenCall;
	import com.architectd.digg2.calls.oauth.VerifyLoginCall;
	import com.architectd.digg2.loginHelper.IDiggLoginHelper;
	import com.spice.utils.queue.ChildQueueManager;
	import com.spice.utils.queue.QueueManager;
	import com.spice.utils.queue.cue.ICue;
	import com.yahoo.oauth.OAuthConsumer;
	
	import flash.events.EventDispatcher;
	
	use namespace digg_service_internal;

	public class DiggService extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _queue:QueueManager;
		private var _loginHelper:IDiggLoginHelper;
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		[Bindable] 
		public var consumer:OAuthConsumer;
		
		/* [Bindable] 
		[Setting]
		public var accessToken:OAuthToken;
		
		
		[Bindable] 
		[Setting]
		public var requestToken:OAuthToken;
		
		[Bindable] 
		[Setting]
		public var loggedInUser:String;
		
		[Bindable] 
		[Setting]
		public var pin:Number; */
		
		
		[Bindable] 
		public var settings:IDiggServiceSettings;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggService(consumer:OAuthConsumer,loginHelper:IDiggLoginHelper,settings:IDiggServiceSettings = null)
		{
			_queue = new QueueManager();
			
			this.loginHelper = loginHelper;
			this.consumer    = consumer;
			this.settings    = settings ? settings : new DiggServiceSettings();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get loginHelper():IDiggLoginHelper
		{
			return this._loginHelper;
		}
		
		/**
		 */
		
		public function set loginHelper(value:IDiggLoginHelper):void
		{
			this._loginHelper = value;
			
			this._loginHelper.service = this;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function verifyLogin():IDiggCall
		{
			
			return this.call2(new VerifyLoginCall());
		}
		/**
		 */
		
		public function login():IDiggCall
		{
			var vlc:IDiggCall = this.linkCall(new VerifyLoginCall(false));
			
			var cum:ChildQueueManager = new ChildQueueManager();
			cum.queueManager.addCue(this.linkCall(new GetRequestTokenCall()));
			cum.queueManager.addCue(this._loginHelper);
			cum.queueManager.addCue(this.linkCall(new GetAccessTokenCall()));
			cum.queueManager.addCue(vlc);
			
			this._queue.addCueToBeginning(cum);
			
			return vlc;
		}
		
	
		/**
		 */
		
		public function call(call:IDiggCall):IDiggCall
		{
			
			//if the token doesn't exist, then initialize the helper
			//first
			if(!this.settings.accessToken && call is IPrivateDiggCall)
			{
				this.verifyLogin();
			}
			
			//some calls may need to be recalled, so 
			return this.call2(call);
		}
		
		/**
		 */
		
		public function addCue(cue:ICue):ICue
		{
			this._queue.addCue(cue);
			return cue;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
	
		private function call2(call:IDiggCall):IDiggCall
		{
			call.service = this;
			
			
			_queue.addCue(call);
			
			return call;
		}
		
		
		
		/**
		 */
		
		public function linkCall(call:IDiggCall):IDiggCall
		{
			call.service = this;
			return call;
		}
	}
}