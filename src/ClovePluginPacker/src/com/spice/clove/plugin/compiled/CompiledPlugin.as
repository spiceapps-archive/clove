package com.spice.clove.plugin.compiled
{
	import mx.collections.ArrayCollection;
	
	
	[Bindable] 
	[RemoteClass(alias='CompiledPlugin')]
	
	/**
	 * packed on the server and stored as a file. Contains directions on how to execute plugin
	 * @author craigcondon
	 * 
	 */	
	 
	public class CompiledPlugin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 * the remote plugin info 
		 */		
		 
		public var pluginInfo:CompiledPluginInfo;
		
		/**
		 * the zipped file assets  
		 */		
		public var assets:ArrayCollection;
		
		/**
		 */
		
		public var factoryClass:String;
        
        
        
        /**
         */
        
        public var version:String;
        
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var uid:String;

        //--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CompiledPlugin(info:CompiledPluginInfo = null,
								factoryClass:String = null,
								assets:ArrayCollection = null)
		{
			this.factoryClass = factoryClass;
			this.pluginInfo = info;
			this.assets = assets == null ? new ArrayCollection() : assets;
		}
		
		
		
        
	}
}