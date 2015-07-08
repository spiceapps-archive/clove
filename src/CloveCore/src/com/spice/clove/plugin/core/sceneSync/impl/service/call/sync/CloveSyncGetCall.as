package com.spice.clove.plugin.core.sceneSync.impl.service.call.sync
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.sceneSync.core.service.data.SyncData;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveSyncDataHandler;
	import com.architectd.service.IRemoteService;
	import com.architectd.service.events.ServiceEvent;
	
	public class CloveSyncGetCall extends CloveServiceCall
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        
        [Bindable]	
        [Setting]
        public var scene_id:Number;
        
        [Bindable]	
        [Setting]
        public var last_sync:Number = 1;
        
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _useAnySyncStoredOnServer:Boolean;
		
		//--------------------------------------------------------------------------
		// 
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveSyncGetCall(sceneID:Number,useAnySyncStoredOnServer:Boolean = true)
		{
			
			this.scene_id = sceneID;
			_useAnySyncStoredOnServer  = useAnySyncStoredOnServer;
			  
			super(CloveUrls.SYNC_AVAILABLE_URL,new CloveSyncDataHandler(sceneID));
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		override public function set service(value:IRemoteService):void
		{
			super.service = value;
			
			
			var serv:CloveService = CloveService(value);
			
			
			var lastSync:SyncData = serv.settings.getSyncList().getSync(this.scene_id);
			
			if(lastSync)
				this.last_sync = lastSync.getLastSyncTime();
			
			
				
			
			if(_useAnySyncStoredOnServer)
			{
				this.screen_id = -1;
				this.last_sync = -1;
			}
			
			
			
		}
		
	}
}