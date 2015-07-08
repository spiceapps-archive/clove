package com.spice.clove.plugin.content.data
{
	import com.spice.clove.plugin.core.calls.CallCloveDataType;
	import com.spice.vanilla.core.notifications.Notification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.observer.IObserver;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.recycle.IDisposable;

	public class CloveAppDataProxyResponder implements IObserver, 
													   IDisposable
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private static var _notificationsOfInterest:Vector.<String>;
		private var _data:CloveAppData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveAppDataProxyResponder(data:CloveAppData)
		{
			_data = data;
			
			if(!_notificationsOfInterest)
			{
				_notificationsOfInterest = new Vector.<String>(6,true);
				_notificationsOfInterest[0] = CallCloveDataType.GET_DATE_POSTED;
				_notificationsOfInterest[1] = CallCloveDataType.GET_MESSAGE;
				_notificationsOfInterest[2] = CallCloveDataType.GET_TITLE;
				_notificationsOfInterest[3] = CallCloveDataType.GET_UID;
				_notificationsOfInterest[4] = CallCloveDataType.UPDATE_CLOVE_DATA;
				_notificationsOfInterest[5] = CallCloveDataType.DELETE_CLOVE_DATA;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getNotificationsOfInterest():Vector.<String>
		{
			return _notificationsOfInterest;
		}
		
		
		/**
		 */
		
		public function dispose():void
		{
			this._data = null;
		}
		
		
		/**
		 */
		
		public function notifyObserver(n:INotification):void
		{
			
			var c:IProxyCall = IProxyCall(n);
			
			switch(c.getType())
			{
				case CallCloveDataType.GET_DATE_POSTED: return this.respond(c,_data.getDatePosted());
				case CallCloveDataType.GET_MESSAGE: return this.respond(c,_data.getMessage());
				case CallCloveDataType.GET_TITLE: return this.respond(c,_data.getTitle());
				case CallCloveDataType.GET_UID: return this.respond(c,_data.getUID());
				case CallCloveDataType.UPDATE_CLOVE_DATA: return this.respond(c,_data.updateData());
				case CallCloveDataType.DELETE_CLOVE_DATA: return this.respond(c,_data.deleteData());
			}
		}
		
		
		/**
		 */
		
		protected function respond(c:IProxyCall,data:*):void
		{
			c.getObserver().notifyObserver(new Notification(c.getType(),data));
		}
	}
}