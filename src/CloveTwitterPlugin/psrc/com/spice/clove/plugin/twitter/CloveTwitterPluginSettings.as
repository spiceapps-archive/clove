package com.spice.clove.plugin.twitter
{
	import com.spice.recycle.events.DisposableEventDispatcher;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class CloveTwitterPluginSettings extends DisposableEventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _username:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		[Bindable(event="usernameChange")]
		[EncryptedSetting]
		public function get username():String
		{
			return this._username;
		}
		
		/**
		 */
		
		public function set username(value:String):void
		{
			this._username = value;
			this.displayName = value;
			
			
			this.dispatchEvent(new Event("usernameChange"));

		}

		[EncryptedSetting]
		public var password:String;
		
		[Setting]
		public var displayName:String = "Twitter";
		
		
		
		[Setting]
		public var installed:Boolean;
		
		
		[Table(voClass="com.architectd.twitter.data.user.UserData")]
		public var friends:ArrayCollection = new ArrayCollection();
		
	}
}