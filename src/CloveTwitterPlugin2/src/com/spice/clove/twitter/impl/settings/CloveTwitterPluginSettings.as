package com.spice.clove.twitter.impl.settings
{
	import com.architectd.twitter2.data.TwitterFriendsData;
	import com.architectd.twitter2.data.TwitterStatusData;
	import com.architectd.twitter2.data.TwitterUserData;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.twitter.impl.account.settings.TwitterAccountSettingType;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	import com.spice.vanilla.impl.settings.child.ChildSettingTable;
	import com.spice.vanilla.impl.settings.list.NumberListSetting;
	import com.spice.vanilla.impl.settings.list.StringListSetting;
	
	
	/**
	 * all settings cached on the users computer 
	 * @author craigcondon
	 * 
	 */	
	
	public class CloveTwitterPluginSettings extends ClovePluginSettings
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * the token needed to log into twitter
		 */
		
		private var _accessToken:OAuthTokenSetting;
		
		/**
		 * the screen name of the twitter user that owns the account setup
		 */
		
		private var _screenName:StringSetting;
		
		/**
		 * the last time the app synchronized with the users friends. 
		 */
		
//		private var _lastFollowingSync:NumberSetting;
		
		
		/**
		 * sync the accounts every five days 
		 */		
		
//		public static const SYNC_FOLLOWING_DURATION:Number = 60*60*24*5;
		
		
		/**
		 */
		
		private var _following:StringListSetting;
		private var _favorites:NumberListSetting;
		
		
		
		/**
		 */
		
		private var _defaultUploaders:ChildSettingTable;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveTwitterPluginSettings()
		{
			super(CloveTwitterSettingFactory.getInstance());
			
			_accessToken = OAuthTokenSetting(this.getNewSetting(TwitterAccountSettingType.OAUTH_TOKEN,"accessToken"));
			_screenName = StringSetting(this.getNewSetting( BasicSettingType.STRING,"screenName"));
			_following  = StringListSetting(this.getNewSetting( TwitterAccountSettingType.STRING_LIST,"following"));
			_favorites  = NumberListSetting(this.getNewSetting( TwitterAccountSettingType.NUMBER_LIST,"favorites"));
			
			_defaultUploaders = ChildSettingTable(this.getNewSetting(TwitterAccountSettingType.CHILD_SETTING_TABLE,"defaultAttachmentUploaders"));
			
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function setDefualtUploader(type:String,name:String):void
		{
			StringSetting(_defaultUploaders.getNewSetting(BasicSettingType.STRING,type)).setData(name);
		}
		
		/**
		 */
		
		public function getDefaultUploader(type:String):String
		{
			return StringSetting(_defaultUploaders.getNewSetting(BasicSettingType.STRING,type)).getData();
		}
		/**
		 */
		
		public function getAccessToken():OAuthTokenSetting
		{
			return this._accessToken;
		}
		
		/**
		 */
		
		public function getFollowing():StringListSetting
		{
			return this._following;
		}
		
		/**
		 */
		
		public function getFavorites():NumberListSetting
		{
			return this._favorites;
		}
		
		
		/**
		 */
		
		public function storeFollowing(value:TwitterFriendsData):void
		{
			this._following.clear();
			
			var users:Vector.<String> = new Vector.<String>();
			
			for each(var u:TwitterUserData in value.users)
			{
				users.push(u.screenName);
			}
			
			this._following.setData(users);
		}
		
		/**
		 */
		
		public function storeFavorites(value:Array):void
		{
			this._favorites.clear();
			
			var favs:Vector.<Number> = new Vector.<Number>();
			
			for each(var sd:TwitterStatusData in value)
			{
				favs.push(sd.id);
			}
			
			this._favorites.setData(favs);
		}
		
		/**
		 */
		
		public function getScreenName():StringSetting
		{
			return _screenName;
		}
	}
}