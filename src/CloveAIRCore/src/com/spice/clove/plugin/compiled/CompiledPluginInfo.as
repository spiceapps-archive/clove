package com.spice.clove.plugin.compiled
{
	
	/*
	  VO data sent back from the SQL database on the server
	 */
	 	
	[Bindable] 
	[RemoteClass(alias='CompiledPluginInfo')]
	public class CompiledPluginInfo
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		/**
		 * the Grant UID given to the application when the user registers it to this server.
		 * This is nothing more than a UID used with a timestamp, name, and other various details
		 * we can port incase of a DB wipe. 
		 */		
		public var guid:String;
		
		
		/**
		 * The name of the plugin 
		 */		
		 
		public var name:String;
		
        /**
         * the plugin description 
         */		
         
        public var description:String;
        
        
        /**
         * the factory class we use as a gateway to 
         * access the SWF that accompanies the compiled plugin 
         */        
        
        public var factoryClass:String;
        
        
        
        
        /**
         * the date the plugin was created 
         */        
         
        public var createdAt:Date;
        
        
        /**
         * The current version of this plugin 
         */        
         
        public var version:String;
        
        /**
         * the SDK version this plugin is using. This is needed
         * incase there is ever an update that breaks the current SDK. In which 
         * case we'd say the plugin is incompatible. (which WILL happen someday) 
         */        
        
        public var sdkVersion:String;
        
        
		/**
		 * the update info for this version
		 */
		         
		public var updateInfo:String;
		
        /**
         * the date the plugin was updated 
         */        
        
        public var updatedAt:Date;
		
		
		
		
		
        /**
         * @Depricated 
         */		
         
        //public var pluginID:String;
        
        /**
         *@Depricated 
         */        
         
        //public var remotePath:String;
        		
        
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CompiledPluginInfo(){}
		
		

	}
}