package com.spice.clove.plugin.facebook
{
	import com.facebook.Facebook;
	import com.facebook.commands.friends.GetFriends;
	import com.facebook.commands.stream.GetFilters;
	import com.facebook.data.friends.GetFriendsData;
	import com.facebook.data.stream.GetFiltersData;
	import com.facebook.data.users.FacebookUser;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.column.control.ColumnControllerFactory;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.facebook.column.control.FacebookFanPageColumnController;
	import com.spice.clove.plugin.facebook.column.control.FacebookFriendStatusColumnController;
	import com.spice.clove.plugin.facebook.column.control.FacebookPhotosColumnController;
	import com.spice.clove.plugin.facebook.column.control.FacebookStatusColumnController;
	import com.spice.clove.plugin.facebook.column.control.prefView.FanPagePreferenceView;
	import com.spice.clove.plugin.facebook.column.control.prefView.SelectFriendsPreferenceView;
	import com.spice.clove.plugin.facebook.cue.FacebookCallCue;
	import com.spice.clove.plugin.facebook.cue.GetPageInfoCue;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;
	import com.spice.clove.plugin.facebook.postable.FacebookWallPostable;
	import com.spice.clove.plugin.facebook.utils.FacebookLoginUtil;
	import com.spice.model.Singleton;
	
	import flash.events.Event;
	
	
	public class CloveFacebookPlugin extends ClovePlugin
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _settings:CloveFacebookSettings;
		private var _loginHelper:FacebookLoginUtil;
		private var _connection:Facebook;
		
		
		[Bindable] 
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function CloveFacebookPlugin()
		{
			
			super(_model.settings);
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		
		public function get connection():Facebook
		{
			return _connection;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function initialize(controller:IPluginController):void
		{
			super.initialize(controller);
			
			
//			com.facebook.commands.
			
			
			this.addAvailableColumnController(new ColumnControllerFactory("Status",controller,FacebookStatusColumnController));
			this.addAvailableColumnController(new ColumnControllerFactory("Friend's Wall",controller,FacebookFriendStatusColumnController,SelectFriendsPreferenceView));
			this.addAvailableColumnController(new ColumnControllerFactory("Fan Page",controller, FacebookFanPageColumnController, FanPagePreferenceView));
			this.addAvailableColumnController(new ColumnControllerFactory("Photos",controller,FacebookPhotosColumnController));
			
			this.addPostable(new FacebookWallPostable(controller,"Facebook Wall"));
			
			
			this._loginHelper = Singleton.getInstance(FacebookLoginUtil);
			this._loginHelper.login();
			this._model.connection  = this._connection = this._loginHelper.connection;
			
			
			this._loginHelper.addEventListener(Event.COMPLETE,onFacebookConnect);
		
//			this._loginHelper.addEventListener( FacebookEvent.CONNECT,onFacebookConnect,false,1,true);
			
			
			this.call(new FacebookCallCue(new GetFilters(),onFilters));
			this.call(new FacebookCallCue(new GetFriends(),onFriends));
			
			this.complete();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onFacebookConnect(event:Event):void
		{
			
//			if(event.success)
			{
				var tg:FacebookLoginUtil = event.target as FacebookLoginUtil;

				_model.facebookID   	 = tg.sessionData.uid;
				
				this.call(new FacebookCallCue(new GetFriends(),onFriends));
				this.call(new FacebookCallCue(new GetFilters(),onFilters));
				
				
//				new CloveColumnEvent(CloveColumnEvent.
				
				
				new CloveEvent(CloveEvent.LOAD_COLUMNS,this).dispatch();
				
			}
			
		}
		
		
		/**
		 */
		
		private function onFilters(data:GetFiltersData):void
		{
			
//			new XMLDataParser
			
			_model.filters = data.filters.source;
			
			this.call(new GetPageInfoCue());
		}
		
		/**
		 */
		
		private function onFriends(data:GetFriendsData):void
		{
			for each(var u:FacebookUser in data.friends.source)
			{
				//this will force all the user info to be downloaded. buwhahahahahahaha
				_model.friendModel.getFriendInfo(u.uid);
			}
			
			
			
			
			
		}
		
		

	}
}