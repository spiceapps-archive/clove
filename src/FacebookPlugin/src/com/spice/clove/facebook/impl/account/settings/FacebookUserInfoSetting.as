package com.spice.clove.facebook.impl.account.settings
{
	import com.facebook.Facebook;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.impl.queue.Queue;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.Dictionary;

	public class FacebookUserInfoSetting extends Setting
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _userInfo:Object;
		private var _queue:Queue;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookUserInfoSetting(type:int,name:String)
		{
			super(name,type);
			_userInfo = {};
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getUserInfo(userId:String):FacebookUserInfo
		{
			if(!_userInfo[userId])
			{
				
			}
			
			return null;
		}
	}
}