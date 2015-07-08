package com.spice.clove.fantasyVictory.impl.service
{
	import com.spice.clove.fantasyVictory.impl.service.data.FVVideoData;
	import com.spice.clove.fantasyVictory.impl.service.events.FantasyVictoryServiceEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	
	/**
	 * this is just a adhock method of creating a super simple API for fantasy victory. I spent 30 minutes on it, so it's dirty. 
	 * @author craigcondon
	 * 
	 */	
	
	[Event(name="rbsLoaded",type="com.spice.clove.fantasyVictory.impl.service.events.FantasyVictoryServiceEvent")]
	[Event(name="qbsLoaded",type="com.spice.clove.fantasyVictory.impl.service.events.FantasyVictoryServiceEvent")]
	[Event(name="wrsLoaded",type="com.spice.clove.fantasyVictory.impl.service.events.FantasyVictoryServiceEvent")]
	
	public class FantasyVictoryService extends EventDispatcher
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _loaders:Dictionary = new Dictionary(true);
		private var _loading:Object;
		
		public static const HOST:String = "http://api.cloveapp.com/fantasyVictory/show/";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FantasyVictoryService()
		{
			this._loading = {};
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function loadRBS():void
		{
			this.loadPage(this.getPageUrl("rbs"),FantasyVictoryServiceEvent.RBS_LOADED);
		}
		
		/**
		 */
		
		public function loadQBS():void
		{
			this.loadPage(this.getPageUrl("qbs"),FantasyVictoryServiceEvent.QBS_LOADED);
		}
		
		
		
		/**
		 */
		
		public function loadWRS():void
		{
			this.loadPage(this.getPageUrl("wrs"),FantasyVictoryServiceEvent.WRS_LOADED);
		}
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		private function loadPage(url:String,event:String):void
		{
			
			//only make one request
			if(this._loading[event] == true)
			{
				return;
			}
			
			this._loading[event] = true;
			
			var loader:URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE,onPageLoad);
			_loaders[loader] = event;
		}
		
		/**
		 */
		
		private function onPageLoad(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onPageLoad);
			
			var ev:String = _loaders[event.currentTarget];
			
			this._loading[ev] = false;
			delete this._loading[ev];
			
			this.dispatchEvent(new FantasyVictoryServiceEvent(ev,parsePage(event.currentTarget.data)))
		}
		
		/**
		 */
		
		private function getPageUrl(cat:String):String
		{
			return HOST+cat+".xml";
		}
		/**
		 */
		
		private function parsePage(data:String):Array
		{
			
			var x:XML = new XML(data);
			
			
			var info:FVVideoData;
			var d:Array = [];
			for each(var player:* in x.response.player)
			{
				info = new FVVideoData();
				info.detailsUrl  = player.storyUrl;
				info.playerName  = player.details.name;
				info.teamName    = player.teamName;
				info.videoUrl    = player.details.videoUrl;
				info.description = player.details.description;
				info.teamIconUrl = player.teamIconUrl;
				
				d.push(info);
				
			}
			
			
			return d;
		}
	}
}