package com.spice.clove.plugins.digg
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.calls.user.GetAllUserFriendsCall;
	import com.architectd.digg2.calls.user.GetUserDiggsCall;
	import com.architectd.digg2.data.UserData;
	import com.architectd.digg2.events.DiggEvent;
	import com.architectd.digg2.loginHelper.AIRLoginHelper;
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.column.control.ColumnControllerFactory;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugins.digg.column.controls.*;
	import com.spice.clove.plugins.digg.column.prefViews.SearchColumnView;
	import com.spice.clove.plugins.digg.column.prefViews.UserSearchColumnView;
	import com.spice.clove.plugins.digg.models.DiggModel;
	import com.yahoo.oauth.OAuthConsumer;

	public class DiggPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _model:DiggModel;
		private var _connection:DiggService;
		
		
		public static const OAUTH_KEY:String = "189b14d34941e73ebc53707e8387010f";
		public static const OAUTH_SECRET:String = "598d1d25d19972e2b5f298b5825de65d";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggPlugin()
		{
			
			_model = new DiggModel();
			
			super(new DiggPluginSettings);
			
			//http://services.digg.com/user/exoinverts/dugg?appkey=http://cloveapp.com&type=xml
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get connection():DiggService
		{
			return this._connection;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get model():DiggModel
		{
			return this._model;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function initialize(controller:IPluginController) : void
		{
			super.initialize(controller);
			
			
			
			
			
			
			
			try
			{
				_connection = new DiggService(new OAuthConsumer(OAUTH_KEY,OAUTH_SECRET),new AIRLoginHelper());
			
				_connection.verifyLogin();
				
			}catch(e:Error)
			{
				Logger.logError(e);
			}
			this.addAvailableColumnController(new ColumnControllerFactory("User Dugg",controller,UserDuggColumnController,UserSearchColumnView));
			this.addAvailableColumnController(new ColumnControllerFactory("All Stories",controller,AllStoriesColumnController));
			this.addAvailableColumnController(new ColumnControllerFactory("Top Stories",controller,GetTopStoriesColumnController));
			this.addAvailableColumnController(new ColumnControllerFactory("Upcoming Stories",controller,UpcomingStoriesColumnController));
			this.addAvailableColumnController(new ColumnControllerFactory("Popular Stories",controller,PopularStoriesColumnController));
			this.addAvailableColumnController(new ColumnControllerFactory("Search",controller,DiggSearchColumnController,SearchColumnView));
			
			
			this.complete();
			
			
			
//			this.fetchUserFriends();
			
			
			
			
		}
		
		
		/**
		 */
		
		public function fetchUserFriends():void
		{
			
			if(!this._model.settings.installed)
			{
				this._model.settings.installed = true;
				
				
				this._connection.call(new GetAllUserFriendsCall()).addEventListener(DiggEvent.NEW_DATA,onAllFriends);
				this._connection.call(new GetUserDiggsCall(_connection.settings.loggedInUser)).addEventListener(DiggEvent.NEW_DATA,onDiggs);
			}
				
				
			
		}
		
		
		
		/**
		 */
		
		private function onAllFriends(event:DiggEvent):void
		{
			var data:Array = event.data;
			
			data.push(new UserData(this._model.settings.username));
			
			this._model.settings.friends.source = data;
		}
		
		/**
		 */
		
		private function onDiggs(event:DiggEvent):void
		{
			var data:Array = event.data
			
			
			this._model.settings.dugg.source = data;
		}
		/**
		 */
		
		private function initCommandHandler():void
		{
//			var handler:CommandHandler = new CommandHandler("addStory",commandHandlerCue);
		}
	}
}