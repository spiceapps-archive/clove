package com.architectd.digg2.calls.user
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.calls.IPrivateDiggCall;
	import com.architectd.digg2.events.DiggEvent;
	import com.spice.utils.queue.cue.Cue;

	[Bindable] 
	public class GetAllUserFriendsCall extends Cue implements IPrivateDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var service:DiggService;
		public var count:int = 100;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _users:Array;
		private var _offset:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetAllUserFriendsCall()
		{
			_users = [];
			this._offset = 0;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function init() : void
		{
			var call:GetUserFriendsCall = new GetUserFriendsCall(this.service.settings.loggedInUser,count,_offset);
			
			this.service.linkCall(call);
			
			call.addEventListener(DiggEvent.NEW_DATA,onNewData);
			
			call.init();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onNewData(event:DiggEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onNewData);
			
			var u:Array = event.data;
			
			this._users = this._users.concat(u);
			
			if(u.length > 0)
			{
				this._offset += this.count;	
				this.service.call(this);
			}
			else
			{
				this.dispatchEvent(new DiggEvent(DiggEvent.NEW_DATA,this._users));
			}
			
			this.complete();
			
			
		}
	}
}