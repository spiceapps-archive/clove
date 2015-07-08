package com.spice.clove.plugin.compiled
{
	
	/**
	 * VO data sent back from the SQL database on the server
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
		 * the plugin name
		 */
		 
		public var name:String;
		
		/**
		 * the remote plugin id
		 */
        public var pluginID:String;
        
        /** 
         * the plugin description
         */
         
        public var description:String;
        
        /**
         * the plugin on the server
         */
         
        public var remotePath:String;
        		
        /**
		 */
		
		public var updateInfo:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CompiledPluginInfo(name:String        = null,
								   description:String = null,
								   updateInfo:String  = null,
								   remotePath:String  = null,
								   pluginID:String     = null)
		{
			this.name		  = name;
			this.description  = description;
			this.remotePath	  = remotePath;
			this.pluginID	  = pluginID;
			this.updateInfo   = updateInfo;
		}
		
		

	}
}