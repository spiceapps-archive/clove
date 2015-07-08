package com.spice.clove.plugin.twitter.install
{
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter.calls.account.*;
	import com.architectd.twitter.data.TwitterError;
	import com.architectd.twitter.events.TwitterEvent;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.install.ServiceInstaller;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.clove.plugin.twitter.icons.TwitterIcons;
	import com.spice.clove.plugin.twitter.install.importService.ServiceImportController;
	import com.spice.utils.SystemUtil;
	
	import mx.controls.Alert;
	
	[Bindable] 
	
	/**
	 * Twitter service installer 
	 * @author craigcondon
	 * 
	 */	
	public class TwitterServiceInstaller extends ServiceInstaller implements IServiceInstaller
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public var username:String;
        
        public var password:String;
        
        public var verifyCue:TwitterVerifyCredentialsCall;
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterServiceInstaller()
		{
			super();
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
			return TwitterServiceInstallerView;
		}
		
		/**
		 */
		
		public function get icon():*
		{
			return TwitterIcons.TWITTER_32_ICON;
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
			
			var plug:CloveTwitterPlugin = CloveTwitterPlugin(controller.plugin);
			
			plug.setCredentials(this.username,this.password);
			
			//add the initial columns
			
			  
			#if PLATFORM == AIR_PLATFORM
			
			new ServiceImportController(controller).openOptions();

			#endif
			
			
		}
		
		
		/**
		 */
		
		public function check():void
		{
			#var hasUserInfo \* (this.username != null && 
								this.username != ""   && 
								this.password != ""   && 
								this.password != null)
			#endef
			
			if(!hasUserInfo)
			{
				Alert.show("Please enter your username, and password.");
				
			}
			else
			{
				this.verifyCue = new TwitterVerifyCredentialsCall();
				verifyCue.addEventListener(TwitterEvent.CALL_COMPLETE,onVerifyCredentials);
				
				new Twitter(this.username,this.password).call(verifyCue);
			}
		}
		
		/**
		 */
		
		public function init():void
		{
			//nothing
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onVerifyCredentials(event:TwitterEvent):void
		{
			
			
			if(!event.result.success)
			{
				Alert.show( TwitterError.getMessage(event.result.status));
				return;
			}
			
			//check if correct
			this.completeInstallation();
		}
		
	}
}



