package com.spice.clove.fantasyVictory.impl.content.control
{
	import com.spice.clove.fantasyVictory.impl.FantasyVictoryPlugin;
	import com.spice.clove.fantasyVictory.impl.content.control.renderer.FantasyVictoryDataRenderer;
	import com.spice.clove.fantasyVictory.impl.service.FantasyVictoryService;
	import com.spice.clove.fantasyVictory.impl.service.events.FantasyVictoryServiceEvent;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
  
	public class FantasyVictoryContentController extends CloveContentController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _service:FantasyVictoryService;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FantasyVictoryContentController(name:String,plugin:FantasyVictoryPlugin)
		{    
			super(name,plugin,new FantasyVictoryDataRenderer(this,plugin.getPluginMediator()));
			
			
			this._service = plugin.getService();
			this._service.addEventListener(FantasyVictoryServiceEvent.QBS_LOADED,onFeedsLoaded);
			this._service.addEventListener(FantasyVictoryServiceEvent.RBS_LOADED,onFeedsLoaded);
			this._service.addEventListener(FantasyVictoryServiceEvent.WRS_LOADED,onFeedsLoaded);
			
			this.setName("Fantasy Victory - "+name);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function loadNewer2(data:ICloveData=null):void
		{
			
			switch(this.getFactoryName())
			{
				case FantasyVictoryContentControllerType.QBS: 
					this._service.loadQBS();
					break;
				case FantasyVictoryContentControllerType.RBS:
					this._service.loadRBS();
					break;
				case FantasyVictoryContentControllerType.WRS:
					this._service.loadWRS();
					break;
			}
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onFeedsLoaded(event:FantasyVictoryServiceEvent):void
		{
			this.fillColumn(event.data);
		}
	}
}