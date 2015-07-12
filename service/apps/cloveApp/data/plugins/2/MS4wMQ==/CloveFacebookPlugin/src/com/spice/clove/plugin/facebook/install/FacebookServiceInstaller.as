package com.spice.clove.plugin.facebook.install
{
	import com.facebook.events.FacebookEvent;
	import com.facebook.views.html.FacebookHTMLLoginHelperView;
	import com.spice.clove.commandEvents.CreateColumnEvent;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.facebook.column.control.FacebookStatusColumnController;
	import com.spice.clove.plugin.facebook.icons.FacebookIcons;
	import com.spice.clove.plugin.facebook.utils.FacebookLoginUtil;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.install.ServiceInstaller;
	import com.spice.model.Singleton;
	import com.spice.utils.EmbedUtil;
	
	import flash.events.Event;
	
	[Bindable] 
	public class FacebookServiceInstaller extends ServiceInstaller implements IServiceInstaller
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _helper:FacebookLoginUtil;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookServiceInstaller()
		{
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get installViewClass():Class
		{
			return FacebookServiceInstallerView;//cannot be null
		}
		
		/**
		 */
		
		public function get icon():*
		{
			return FacebookIcons.FACEBOOK_ICON_32;
		}
		
		/**
		 */
		
		[Bindable(event="helperChange")]
		public function get helper():FacebookLoginUtil
		{
			return this._helper;
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function install(controller:IPluginController):void
		{
			//add the default facebook column
			
			var meta:Object = {};
			meta[ColumnMetaData.COLUMN_ICON] = EmbedUtil.toImageByteArray( FacebookIcons.FACEBOOK_ICON_32);
			meta[ColumnMetaData.TITLE] = "Facebook";
			meta.children = [{title:"Facebook Status"}];
			
			new CreateColumnEvent([[new FacebookStatusColumnController(controller)]],null,meta).dispatch();
		}
		
		/**
		 */
		
		public function init():void
		{
			Logger.log("init",this);
			
			
			_helper = Singleton.getInstance(FacebookLoginUtil);
			_helper.login('',FacebookHTMLLoginHelperView);
			
			_helper.addEventListener(FacebookEvent.CONNECT,onConnect);
//			_helper.login();

			this.dispatchEvent(new Event("helperChange"));
			
			
		}
		
		
		/**
		 */
		
		public function check():void
		{
			this.completeInstallation();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
       
		
		
		/**
		 */
		
		private function onConnect(event:FacebookEvent):void
		{
			Logger.log("onConnect success="+event.success,this);
			if(event.success)
				this.completeInstallation();
		}
	}
}