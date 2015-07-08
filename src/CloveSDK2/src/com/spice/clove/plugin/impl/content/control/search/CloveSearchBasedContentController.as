package com.spice.clove.plugin.impl.content.control.search
{
	import com.spice.clove.analytics.core.AnalyticalActionType;
	import com.spice.clove.analytics.core.AnalyticsPluginHelper;
	import com.spice.clove.plugin.core.calls.CallCloveSearchControllerType;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.views.content.RegisteredCloveContentPreferenceViewController;
	import com.spice.clove.plugin.impl.views.content.filter.RegisteredFilterViewController;
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.observer.IObserver;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class CloveSearchBasedContentController extends CloveContentController implements IObserver
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		public static const SEARCH_TERM:String = "searchTerm";
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _searchTerm:StringSetting;
		private var _noi:Vector.<String>;
		private var _plugin:ClovePlugin;
		private var _namePrefix:String;
		private var _changeTimeout:int;
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var recordAnalyticalKeywordSearchData:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function CloveSearchBasedContentController(factoryName:String,
														  plugin:ClovePlugin,
														  itemRenderer:ICloveDataRenderer,
														  settings:ISettingTable = null,
														  namePrefix:String      = null,
														  keywordSearch:String   = null)
		{
			super(factoryName,plugin,itemRenderer,settings);
			
			
			//register the preference view
			this.setPreferenceViewController(new RegisteredCloveContentPreferenceViewController(CallRegisteredViewType.GET_NEW_REGISTERED_CONTENT_CONTROLLER_SEARCH_PREFERENCE_VIEW,this,this.getFilterViewController(),plugin.getPluginMediator()));
			
			//used for the feed name. If it doesn't exist, then use the plugin name followed by "Search". So the result
			//would be "Twitter Search" "Delicious Search" "Facebook Search" etc.
			_namePrefix = namePrefix || plugin.getName()+" Search: ";
			
			//set the name temporarily so the column gets the update
			this.setName(_namePrefix);
			_searchTerm = StringSetting(this.getSettings().getNewSetting(BasicSettingType.STRING,SEARCH_TERM));
			
			
			
			_noi = new Vector.<String>(1,true);
			_noi[0] = SettingChangeNotification.CHANGE;
			
			_searchTerm.addObserver(this);
			
			if(keywordSearch)
			{
				_searchTerm.setData(keywordSearch);
			}
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallCloveSearchControllerType.GET_SEARCH_TERM: return this.respond(c,this.getSearchTerm().getData());
				case CallCloveSearchControllerType.SET_SEARCH_TERM: return this.getSearchTerm().setData(c.getData());
			}
			
			super.answerProxyCall(c);
		}
		
		
		
		
		
		
		/**
		 */
		
		public function getNotificationsOfInterest():Vector.<String>
		{
			return _noi;
		}
		
		/**
		 */
		
		final public function getSearchTerm():StringSetting
		{
			return this._searchTerm;
		}
		
		/**
		 */
		
		public function notifyObserver(value:INotification):void
		{
			switch(value.getType())
			{
				case SettingChangeNotification.CHANGE:
					
//					flash.utils.clearTimeout(this._changeTimeout);
//					this._changeTimeout =	flash.utils.setTimeout(dispatchChange,500);
					this.searchTermChange();
					
					//note: this needs to be instant because the REMOVE_CONTENT call is listened AFTER
					//settings have been retrieved from the disk. a delay will always remove the content.
					this.dispatchChange();
				break;
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override protected function loadNewer2(data:ICloveData=null):void
		{
			this.recordKeywordSearch();
		}
		
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			this.recordKeywordSearch();
		}
		
		
		/**
		 */
		
		protected function getFilterViewController():RegisteredFilterViewController
		{
			return null;
		}
		/**
		 */
		
		private function dispatchChange():void
		{
			//since the search term has changed, we need to tell the column to remove
			//the content currently displayed since it's irrelevant
			this.resetUID();
			this.removeAllContent();
		}
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallCloveSearchControllerType.GET_SEARCH_TERM,
									CallCloveSearchControllerType.SET_SEARCH_TERM]);
		}
		/**
		 */
		
		protected function searchTermChange():void
		{
			//set the feed name so the column is updated
			this.setName(this._namePrefix+this._searchTerm.getData());
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function recordKeywordSearch():void
		{
			if(this.recordAnalyticalKeywordSearchData)
			{
				this.recordAnalayticalData(AnalyticalActionType.KEYWORD_SEARCH,this.getSearchTerm().getData(),1);
			}
			
		}
		
		
	}
}