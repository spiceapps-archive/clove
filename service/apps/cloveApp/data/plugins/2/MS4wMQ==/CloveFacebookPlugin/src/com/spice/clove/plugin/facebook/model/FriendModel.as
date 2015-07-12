package com.spice.clove.plugin.facebook.model
{
	import com.spice.clove.plugin.facebook.data.FriendInfo;
	import com.spice.recycle.events.DisposableEventDispatcher;
	
	public class FriendModel extends DisposableEventDispatcher
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		private var _bundledIds:Array;
		
		private var _callTimeout:int;
		private var _batch:FriendInfoCall;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function FriendModel()
		{
			_bundledIds = [];
			_batch 		= new FriendInfoCall(this);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
		/**
		 * sleep for a duration so that we bundle up any id's in a list
		 */
		
		[Bindable(event="batchComplete")]
		public function getFriendInfo(friend:*):FriendInfo
		{
			if(!friend)
				return null;
			
			Logger.log("getFriendInfo friend="+friend,this);
			
			var friendID:String;
			
			if(friend is String)
			{
				friendID = friend;
			}
			else
			{
				friendID = friend.uid;
			}
			
			
			var model:FacebookModelLocator = FacebookModelLocator.getInstance();
			
			if(!_batch.connection)
				_batch.connection = model.connection;
			
			var f:FriendInfo = this.findFriend(friendID);
			
			if(!f)
			{
				f = new FriendInfo(friendID);
				
				model.settings.friends.addItem(f);
				
				
				
			}
			
			//some db items may not have loaded content
			if(!f.name || f.name == '')
			{
				_batch.clearBatchIfDone();
				_batch.addToBatch(friend);
			}
			
			
 			return f;
		}
		
		
		
		/**
		 */
		
		private function findFriend(id:String):FriendInfo
		{
			for each(var info:FriendInfo in  FacebookModelLocator.getInstance().settings.friends.source)
			{
				if(info.friendID == id)
					return info;
			}
			
			return null;
		}
		
		
	}
}