package com.spice.clove.facebook.impl.account
{
	import com.facebook.Facebook;
	import com.facebook.air.SessionData;
	import com.facebook.commands.pages.GetPageInfo;
	import com.facebook.commands.users.GetInfo;
	import com.facebook.commands.users.GetLoggedInUser;
	import com.facebook.data.pages.GetPageInfoData;
	import com.facebook.data.pages.PageInfoCollection;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.users.GetInfoData;
	import com.facebook.data.users.GetInfoFieldValues;
	import com.facebook.events.FacebookEvent;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.DesktopSession;
	import com.facebook.utils.DesktopSessionHelper;
	import com.spice.clove.facebook.impl.FacebookPlugin;
	import com.spice.clove.facebook.impl.account.settings.FacebookAccountSettings;
	import com.spice.clove.facebook.impl.cue.FacebookCallCue;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.impl.queue.Queue;
	
	import flash.events.Event;
	import flash.net.SharedObject;
	
	import mx.controls.Alert;

	public class FacebookAccount extends AbstractServiceAccount
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _connection:Facebook;
		private var _helper:DesktopSessionHelper;
		private var _settings:FacebookAccountSettings;
		private var _fanPageInfo:PageInfoCollection;
		private var _queue:Queue;
		
		public static const PERMISSIONS:Array = ['status_update','photo_upload','publish_stream','read_stream'];
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookAccount()
		{
			super((_settings = new FacebookAccountSettings()));
			_queue = new Queue();
			_queue.start();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function call(facebookCall:FacebookCall):FacebookCall
		{
			if(this._connection)
			this._queue.addCue(new FacebookCallCue(facebookCall,this.getPrivateConnection()));
			return facebookCall;
		}
		
		/**
		 */
		public function getPrivateConnection():Facebook
		{
			return this._connection;
		}
		
		
		/**
		 */
		public function getFanPageInfoCollection():PageInfoCollection
		{
			return this._fanPageInfo;
		}
		
		/**
		 */
		
		public function getFacebookSettings():FacebookAccountSettings
		{
			return this._settings;
		}
		
		/**
		 */
		
		public function getUserId():String
		{
			return this._settings.getSession().getData().uid;
		}
		/**
		 */
		
		override public function initialize(value:AbstractServicePlugin):void
		{
			super.initialize(value);
			
			var sess:SessionData = this.getFacebookSettings().getSession().getData();
			
			this.setName(this.getFacebookSettings().getUsername());
			
			
			
			_helper = new DesktopSessionHelper('',sess);
			_helper.apiKey = FacebookPlugin.API_KEY;
			
			
			//TODO: have a popup window for accounts without a session
			if(sess)
			{
				_helper.verifySession();
			}
			this._connection = this._helper.facebook;
			
			_helper.addEventListener(FacebookEvent.PERMISSIONS_LOADED,onPermissionsLoaded);
			_helper.addEventListener(FacebookEvent.CONNECT,onVerifyLogin);
			
			
			
		}
		
		/**
		 */
		
		private function onPermissionsLoaded(event:FacebookEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onPermissionsLoaded);
			
			var toGrant:Array = [];
			
			for each(var perm:String in PERMISSIONS)
			{
				if(this._helper.permissions[perm])
					continue;
				
				toGrant.push(perm);
			}
			
			if(toGrant.length > 0)
			{
				this._helper.grantPermissions(toGrant);
				
			}
		}
		
		/**
		 */
		
		private function onVerifyLogin(event:FacebookEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onVerifyLogin);
			
			
			this.call(new GetInfo([this.getUserId()],[GetInfoFieldValues.NAME,GetInfoFieldValues.PIC_SQUARE,GetInfoFieldValues.PROFILE_URL])).addEventListener(FacebookEvent.COMPLETE,onGetUserInfo);
			this.call(new GetPageInfo(['name','page_url','pic_small','website'])).addEventListener(FacebookEvent.COMPLETE,onGetFanPageInfo);
			
		}
		/**
		 */
		
		private function onGetUserInfo(event:FacebookEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onGetUserInfo);
			
			var info:FacebookUser = GetInfoData(event.data).userCollection.toArray()[0];
			
			this.setName(info.name);
			this.getFacebookSettings().setUsername(info.name);
			
		}
		/**
		 */
		
		private function onGetFanPageInfo(event:FacebookEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onGetFanPageInfo);
			
			this._fanPageInfo = GetPageInfoData(event.data).pageInfoCollection;
		}
	}
}