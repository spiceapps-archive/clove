package com.spice.clove.plugin.extra.twitpic
{
	import com.spice.clove.commandEvents.AddMenuItemEvent;
	import com.spice.clove.commandEvents.NotificationEvent;
	import com.spice.clove.core.storage.PluginSettings;
	import com.spice.clove.ext.extra.twitpic.net.TwitpicRequest;
	import com.spice.clove.ext.services.twitter.TwitterPlugin;
	import com.spice.clove.ext.services.twitter.posting.upload.ITwitterFileUploader;
	import com.spice.clove.ext.services.twitter.posting.upload.TwitterUploadType;
	import com.spice.clove.model.MenuModel;
	import com.spice.clove.plugin.CloveServicePlugin;
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.upload.IDataReturnableCue;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class TwitpicPlugin extends CloveServicePlugin implements ITwitterFileUploader
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitpicPlugin(settings:PluginSettings)
		{
			super("Twitpic","Extra",File.applicationDirectory.url,settings);
			
			var pref:TwitpicPreferences;
			
			this.preferencePane = pref = new TwitpicPreferences();
			pref.plugin = this;
			
			var uploadMenu:NativeMenuItem = new NativeMenuItem("upload twitpic");
			uploadMenu.submenu = new NativeMenu();
			
			uploadMenu.submenu.addEventListener(Event.DISPLAYING,onUploadShow);
			
			new AddMenuItemEvent(uploadMenu,MenuModel.CONTROLS).dispatch();
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		/**
		 */
		
		override public function get maxInstalled():int
		{
			return 1;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
		
		/**
		 */
		
		public function postTwitpic():TwitpicCall
		{
			var plugin:TwitterPlugin = model.pluginList.getFirstPluginByName("Twitter") as TwitterPlugin;
			
			return new TwitpicCall(plugin);
		}
		
		/**
		 */
		
		public function upload(att:Attachment,plugin:TwitterPlugin):IDataReturnableCue
		{
			return new TwitpicRequest(att.file,plugin.username,plugin.password);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
		
		
		
        /**
		 * display the twitter accounts twitpic can use
		 */
		
		
		private function onUploadShow(event:Event):void
		{
			
			var men:NativeMenu = NativeMenu(event.target);
			
			men.removeAllItems();
			
			
			var twitterAccounts:Array = model.pluginList.getPluginsByType(TwitterPlugin);

			var serviceMenu:NativeMenuItem;
			
			
			for each(var twitterAcc:TwitterPlugin in twitterAccounts)
			{
				twitterAcc.addUploadOption('Twitpic',TwitterUploadType.PHOTO,this);
				
				serviceMenu = new NativeMenuItem(twitterAcc.username);
				serviceMenu.addEventListener(Event.SELECT,onUploadSelect,false,0,true);
				serviceMenu.data = new TwitpicCall(twitterAcc,false);
				men.addItem(serviceMenu);
			}
			
		}
		
        /**
		 */
		
		private function onUploadSelect(event:Event):void
		{
			var req:TwitpicCall = event.target.data as TwitpicCall;
			req.addEventListener(Event.COMPLETE,onRequestComplete);
			req.post();
		}
		
		
		/**
		 */
		
		private function onRequestComplete(event:Event):void
		{
			var call:TwitpicCall = event.target as TwitpicCall;
			
			var title:String = call.success ? "upload successful" : "twitpic error";
			
			var message:String = call.success ? "the url has been copied to the clipboard" : call.data as String;
			
			if(call.success)
			{
				
				//copy the url to the clipboard
				Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,call.data);
			}
			
			new NotificationEvent(title,message).dispatch();
		}
		
		

	}
}