package com.spice.clove.facebook.impl.content.control
{
	import com.facebook.commands.stream.GetStream;
	import com.facebook.commands.users.GetInfo;
	import com.facebook.data.pages.PageInfoData;
	import com.facebook.data.stream.GetStreamData;
	import com.facebook.events.FacebookEvent;
	import com.spice.clove.facebook.impl.FacebookPlugin;
	import com.spice.clove.facebook.impl.account.FacebookAccount;
	import com.spice.clove.facebook.impl.content.control.render.FacebookFanPageDataRenderer;
	import com.spice.clove.plugin.core.calls.CallFilterListViewControllerType;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.views.content.filter.FilterableData;
	import com.spice.clove.plugin.impl.views.content.filter.IFilterableData;
	import com.spice.clove.plugin.impl.views.content.filter.RegisteredFilterViewController;
	import com.spice.clove.service.impl.account.content.control.search.AccountSearchBasedContentController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.NumberSetting;
	import com.spice.vanilla.impl.settings.basic.StringSetting;

	public class FacebookFanPageContentController extends AccountSearchBasedContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:FacebookPlugin;
		private var _fanPage:NumberSetting;
		private var _filterView:RegisteredFilterViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookFanPageContentController(name:String,plugin:FacebookPlugin)
		{
			_plugin  = plugin;
			super(name,plugin,new FacebookFanPageDataRenderer(this,plugin.getPluginMediator()),"Fan Page: ");
			
			_fanPage = NumberSetting(this.getSettings().getNewSetting(BasicSettingType.NUMBER,'fanPageUID'));
			
		}  
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getFacebookAccount():FacebookAccount
		{
			return FacebookAccount(this.getAccountOrMake());
		}
		/**
		 */
		
		override protected function loadNewer2(data:ICloveData=null):void
		{
			
			var now:Date = new Date();
			var lastWeek:Date = new Date(now.getTime() - (1000*60*60*24*20));//20 days prior
			
			
			var pageId:Number = this._fanPage.getData();
			
			
			FacebookAccount(this.getAccountOrMake()).call(new GetStream("0",[pageId],lastWeek,now,30,"3")).addEventListener(FacebookEvent.COMPLETE,onLoadFanPage,false,0,true);
			
			//NOTE: for some reason, either Facebook caches requests, or something is screwy. newer content
			//doesn't show right away  
			
			
//			var stream:GetStream = new GetStream(0,[this.fanPage.page_id],lastWeek,now,30,"3");
			
			
//			var cue:FacebookCallCue = new FacebookCallCue(stream,onGreamData);
			
//			this.setLoadCue(cue);
			
//			cue.init();
		}
		
		
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
		}
		
		
		/**
		 */
		
		override protected function getFilterViewController():RegisteredFilterViewController
		{
//			return new
			_filterView = new RegisteredFilterViewController(this._plugin.getPluginMediator());
			_filterView.getProxy().bindObserver(new CallbackObserver(CallFilterListViewControllerType.SHOW_FILTER_LIST_VIEW,onFiltering));
			_filterView.getProxy().bindObserver(new CallbackObserver(CallFilterListViewControllerType.FILTERED_ITEM_SELECTED,onItemSelected));
			
			return this._filterView;
		}
		
		/**
		 */
		
		private function onLoadFanPage(event:FacebookEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onLoadFanPage);
			
			var data:GetStreamData = GetStreamData(event.data);
			
			this.fillColumn([]);
		}
		
		/**
		 */
		
		private function onFiltering(n:INotification):void
		{
			
			var filterList:Array = [];
			
			for each(var data:PageInfoData in this.getFacebookAccount().getFanPageInfoCollection().source)
			{
				filterList.push(new FilterableData(data.name,data.pic_small,data));		
			}
			
			this._filterView.setFilterableList(filterList);
		}
		
		/**
		 */
		
		private function onItemSelected(n:INotification):void
		{
			var data:FilterableData = n.getData();
			
			_fanPage.setData(PageInfoData(data.getData()).page_id);
			
			
		}
	}
}