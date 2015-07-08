package com.spice.clove.plugin.twitter.install.importService
{
	import com.spice.clove.commandEvents.CreateColumnEvent;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.clove.plugin.twitter.column.control.TwitterDMColumnController;
	import com.spice.clove.plugin.twitter.column.control.TwitterMentionsColumnController;
	import com.spice.clove.plugin.twitter.column.control.TwitterUserTimelineColumnController;
	import com.spice.clove.plugin.twitter.icons.TwitterIcons;
	import com.spice.clove.plugin.twitter.install.importService.seesmic.SeesmicImporter;
	import com.spice.clove.plugin.twitter.install.importService.tweetdeck.TweetdeckImporter;
	import com.spice.utils.EmbedUtil;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class ServiceImportController
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var availableServices:ArrayCollection;
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _controller:IPluginController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function ServiceImportController(controller:IPluginController)
		{
			_controller = controller;
			
			this.availableServices = new ArrayCollection([new AvailableService("Seesmic",new SeesmicImporter()),new AvailableService("Tweetdeck",new TweetdeckImporter())]);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function openOptions():void
		{
			
			var hasService:Boolean;
			
			for each(var service:AvailableService in this.availableServices.source)
			{
				
				if(service.service.hasService())
				{
					hasService = true;
				}
			}
			
			
			if(hasService)
				ImportColumnsView.open(this);
			else
				cancel();
		}
		/**
		 */
		
		public function cancel():void
		{
			
			
			//PLACE IN ARRAY
			
			
			var meta:Object = {};
			
			meta[ColumnMetaData.COLUMN_ICON] = EmbedUtil.toImageByteArray( TwitterIcons.TWITTER_32_ICON);
			meta[ColumnMetaData.TITLE] =  CloveTwitterPlugin(_controller.plugin).settings.username;
			
			meta.children = [{title:'Timeline'},{title:'Mentions'},{title:'Direct Messages'}];
			
			new CreateColumnEvent([[new TwitterUserTimelineColumnController(_controller)],[new TwitterMentionsColumnController(_controller)],[new TwitterDMColumnController(_controller)]],null,meta).dispatch();
			
		}
		
		/**
		 */
		
		public function importServices():void
		{
			
			var found:Boolean;
			
			for each(var service:AvailableService in this.availableServices.source)
			{
				if(service.selected)
				{
					service.service.importService(this._controller);
					found = true;
				}
				
			}
			
			
			
			//if no items have been imported, then continue
			if(!found)
				cancel();
		}
	}
}