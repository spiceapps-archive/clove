package com.spice.clove.plugin.facebook.model
{
	import com.facebook.Facebook;
	import com.facebook.commands.users.GetInfo;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.users.GetInfoData;
	import com.facebook.data.users.GetInfoFieldValues;
	import com.facebook.events.FacebookEvent;
	import com.spice.clove.plugin.facebook.business.DelayedBatchCall;
	import com.spice.clove.plugin.facebook.data.FriendInfo;
	
	import flash.events.IEventDispatcher;
	
	
	/**
	 * does a batch friend info request to Facebook, and sets all binded data to the corresponding user info
	 */
	
	internal class FriendInfoCall extends DelayedBatchCall
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _fbuInstances:Object;
		
		private static const GET_INFO_FIELDS:Array = [GetInfoFieldValues.NAME, GetInfoFieldValues.PIC_SQUARE, GetInfoFieldValues.PROFILE_URL];
		
		public var connection:Facebook;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FriendInfoCall(target:IEventDispatcher)
		{
			super(target);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function onBatch():void
		{
			var nids:Array = new Array();
			_fbuInstances = new Object();
			
			for each(var id:* in this.batch)
			{
				if(id is String)
				{
					nids.push(id);
				}
				else
				{
					nids.push(id.uid);
					_fbuInstances[id.uid] = id;
				}
			}
			
			var info:GetInfo = new GetInfo(nids,GET_INFO_FIELDS);
			info.addEventListener(FacebookEvent.COMPLETE,onFacebookInfo);
			
			if(connection)
			{
				connection.post(info);
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onFacebookInfo(event:FacebookEvent):void
		{
			event.target.removeEventListener(event.type,onFacebookInfo);
			
			var bindedInfo:FriendInfo;
			
			
			if(event.success)
			{
				for each(var info:FacebookUser in GetInfoData(event.data).userCollection.toArray())
				{
					if(_fbuInstances[info.uid])
					{
						var fu:FacebookUser = _fbuInstances[info.uid];
						
						for each(var inf:String in GET_INFO_FIELDS)
						{
							fu[inf] = info[inf];
						}
					}
					
					bindedInfo = FacebookModelLocator.getInstance().friendModel.getFriendInfo(info.uid);
					
					bindedInfo.setInfo(info);
				}
			}
			
			
			//dispatch the binded event
			this.complete();
		}

	}
}