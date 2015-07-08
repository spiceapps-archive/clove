package com.spice.clove.plugins.digg.column.controls
{
	import com.architectd.digg2.calls.user.GetUserDuggCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugins.digg.column.render.DiggStoryColumnItemRenderer;
	
	import flash.events.Event;

	public class UserDuggColumnController extends  DiggStoryColumnController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _user:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UserDuggColumnController()
		{
			super();
			
			this.title = "User Dugg";
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		[Bindable(event="userChange")]
		[Setting]
		public function get user():String
		{
			return this._user;
		}
		
		public function set user(value:String):void
		{
			this._user = value;
			
			this.title = "User "+value;
			
			this.dispatchEvent(new Event("userChange"));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function onColumnStartLoad(event:CloveColumnEvent) : void
		{	
			super.onColumnStartLoad(event);
			
			
			this.loadContent();
			
		}
		
		/**
		 */
		
		override protected function loadContent(maxDate:Date=null) : void
		{
			
			if(!user)
			{
				return;
			}
			this.call(new GetUserDuggCall(user,30,null,maxDate));
		}
	}
}