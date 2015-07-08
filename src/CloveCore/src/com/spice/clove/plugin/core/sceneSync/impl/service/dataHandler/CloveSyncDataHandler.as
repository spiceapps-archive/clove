package com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler
{
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.sceneSync.core.service.data.ScreenData;
	import com.spice.clove.sceneSync.core.service.data.SyncData;
	
	import flash.display.Scene;
	
	public class CloveSyncDataHandler extends CloveDataHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _sceneId:int;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveSyncDataHandler(sceneId:int)
		{
			this._sceneId = sceneId;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		override protected function getData(data:*):Object
		{
			var syncs:Array = [];
			
			
			for each(var sd:XML in data.sync)
			{
				var sync:SyncData = new SyncData(sd.name,0,sd.id,sd.created_at,sd.compressed == 1,sd.url,ScreenData.fromXML(sd.screen),SceneData.fromXML(sd.scene));
				sync.scene.id = this._sceneId;
				syncs.push(sync);
				
			}
			
			
			
			
			return syncs;
			
			
		}

	}
}