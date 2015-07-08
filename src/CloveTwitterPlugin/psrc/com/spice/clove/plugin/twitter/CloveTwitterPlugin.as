package com.spice.clove.plugin.twitter
{
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter.calls.status.StatusUpdateCall;
	import com.architectd.twitter.calls.user.GetAllFriendsCall;
	import com.architectd.twitter.events.TwitterEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.commandEvents.CreateColumnEvent;
	import com.spice.clove.events.ApplicationEvent;
	import com.spice.clove.events.plugin.PluginEvent;
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.column.ICloveColumn;
	import com.spice.clove.plugin.column.control.ColumnControllerFactory;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.mediate.call.AddMenuItemPluginCall;
	import com.spice.clove.plugin.posting.Message;
	import com.spice.clove.plugin.twitter.column.control.*;
	import com.spice.clove.plugin.twitter.column.control.views.SearchColumnPrefView;
	import com.spice.clove.plugin.twitter.column.control.views.UserSearcColumnPreferences;
	import com.spice.clove.plugin.twitter.cue.TwitterServiceCue;
	import com.spice.clove.plugin.twitter.posting.TwitterWallPostable;
	import com.spice.clove.plugin.twitter.posting.upload.ITwitterFileUploader;
	import com.spice.clove.plugin.twitter.posting.upload.TwitpicFileUploader;
	import com.spice.clove.plugin.twitter.posting.upload.TwitterUploadType;
	import com.spice.clove.plugin.twitter.shortUrl.ShortenUrlAction;
	import com.spice.monkeyPatch.menu.*;
	import com.spice.utils.command.CallbackCommandHandler;
	import com.spice.utils.command.InvokationCommand;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.binding.utils.BindingUtils;
	
	public class CloveTwitterPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _settings:CloveTwitterPluginSettings;
		private var _connection:Twitter;
		
		//contains the account name
		private var _servicePostable:TwitterWallPostable;
		
		//the upload services added
		private var _uploadServices:Object;
		
		//TEMPORARY MOVE TO PERSISTENT DATA
		private var _defaultUploadServices:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CloveTwitterPlugin()
		{
			_settings = new CloveTwitterPluginSettings();
			
			super(_settings);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get settings():CloveTwitterPluginSettings
		{
			return _settings;
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
			
			
			this.addAvailableColumnController(new ColumnControllerFactory("Keyword Search",controller,TwitterKeywordSearchColumnController,SearchColumnPrefView));
			this.addAvailableColumnController(new ColumnControllerFactory("User Search",controller,TwitterUserSearchColumnController, UserSearcColumnPreferences));
			this.addAvailableColumnController(new ColumnControllerFactory("Timeline",controller,TwitterUserTimelineColumnController,null));
			this.addAvailableColumnController(new ColumnControllerFactory("Direct Messages",controller,TwitterDMColumnController,null));
			this.addAvailableColumnController(new ColumnControllerFactory("Mentions",controller,TwitterMentionsColumnController,null));
			this.addAvailableColumnController(new ColumnControllerFactory("My Posts",controller,TwitterUserPostsColumnController,null));
			this.addAvailableColumnController(new ColumnControllerFactory("Public Timeline",controller,TwitterPublicTimelineColumnController,null));
			
			
			this._servicePostable = new TwitterWallPostable(controller,"Twitter");
			
			BindingUtils.bindProperty(_servicePostable,"name",this._settings,"displayName");
			
			this.addPostable(this._servicePostable);
			
			
			this._uploadServices 		= new Object();
			this._defaultUploadServices = new Object();
			
			
			this.addUploadOption('Twitpic',TwitterUploadType.PHOTO,new TwitpicFileUploader());
			
			
			/*var me:MenuItem = new MenuItem("Shorten URLs");
			me.addEventListener(Event.SELECT,onShortenUrlsSelect);
			
			new CloveEvent(CloveEvent.ADD_POSTER_ACTION,me).dispatch();*/
			
			new ShortenUrlAction();
			
			//TEMPORARY!!!! fetches all friends from Twitter
			if(!this._settings.installed)
			{
				this._settings.installed = true;
				flash.utils.setTimeout(getAllFriends,1000);
			}
			
			
			this.initCommands();
			
			this.complete();
		
		}
		
		/**
		 */
		
		private function getAllFriends():void
		{
			var cue:GetAllFriendsCall = new GetAllFriendsCall(_settings.username);
			this.connection.linkCall(cue);
			
			cue.addEventListener(TwitterEvent.CALL_COMPLETE,onAllFriends);
			cue.init();
		}
		
		
		/**
		 */
		
		public function get connection():Twitter
		{
			//singleton connection
			if(!_connection)
			{
				_connection = new Twitter(_settings.username,_settings.password);
			}	
			
			return _connection;
		}
		
		/**
		 */
		
		public function setCredentials(username:String,password:String):void
		{
			Logger.log("setCredentials",this);
			
			this.connection.username = this._settings.username = username;
			this.connection.password = this._settings.password = password;
			
			
		}
		
		/**
		 * adds a file upload option for the twitter plugin when posting items 
		 * @param name the name of the upload option
		 * @param type the type of the uploader
		 * @param uploader the file uploader
		 * 
		 */		
		
		public function addUploadOption(name:String,type:String,uploader:ITwitterFileUploader):void
		{
			
			if(!_uploadServices[type])
			{
				_uploadServices[type] = new Object();
			}
			
			_uploadServices[type][name] = uploader;
			
			
			this._defaultUploadServices[type] = uploader;
			
		}
		
		/**
		 * returns the default file uploader 
		 * @param type the type of file uploader (photo,audio,images)
		 * @return 
		 * 
		 */		
		
		public function getDefaultService(type:String):ITwitterFileUploader
		{
			return this._defaultUploadServices[type];
		}
		
		/**
		 * sends a tweet 
		 * @param message the message to send
		 * 
		 */        
		
		public function sendMessage(message:Message):void
		{
			var con:Twitter = this.connection;
			
			
			this.call(new TwitterServiceCue(con,new StatusUpdateCall(message.text)));
		}
		
		
		/**
		 */
		
		override protected function onApplicationInitialized(event:ApplicationEvent):void
		{
			var menu:Array = [{label:"quote",callback:quoteData}];
			
			new AddMenuItemPluginCall(menu,function(col:ICloveColumn):Boolean{ return !(col.controller is TwitterColumnController); }).dispatch();
		}
		
		
		/**
		 */
		
		public function addActivePostable():void
		{
			new CloveEvent(CloveEvent.ADD_ACTIVE_POSTABLE,this._servicePostable).dispatch();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		private function onShortenUrlsSelect(event:Event):void
		{
			
			
		}
        /**
		 */
		
		private function quoteData(data:RenderedColumnData):void
		{
			
			var message:String = data.message;
			
//			message = message.length > 140 ? message.
			new CloveEvent(CloveEvent.COPY_TO_POSTER,data.message).dispatch();
			
			this.addActivePostable();
		}
		
		/**
		 */
		
		private function onAllFriends(event:TwitterEvent):void
		{
			
			this._settings.friends.source = this._settings.friends.source.concat(event.result.response);
			
		}
		
		
		/**
		 */
		
		private function initCommands():void
		{
			
			//create a command for the browser to use
			var addSearch:CallbackCommandHandler = new CallbackCommandHandler("search",addSearchColumn);
			
			
			this.dispatchEvent(new PluginEvent(PluginEvent.REGISTER_COMMAND,addSearch));
		}
		
		/**
		 */
		
		private function addSearchColumn(cmd:InvokationCommand):void
		{
			new CreateColumnEvent([new TwitterKeywordSearchColumnController(this.controller,cmd.value)]).dispatch();
		}
	}
}