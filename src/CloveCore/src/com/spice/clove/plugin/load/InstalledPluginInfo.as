package com.spice.clove.plugin.load
{
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.utils.DescribeTypeUtil;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	
	
	[Bindable] 
	[RemoteClass(alias="com.spice.clove.plugin.load")]
	
	/*
	  plugins that are currently being used 
	  @author craigcondon
	  
	 */	
	public class InstalledPluginInfo
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		/**
		 * the fileUID is used for locating the settings on the disk 
		 */
		
//		public var fileUID:String;
		
		/**
		 * the factory class is the path for the factory that loads this plugin info 
		 */
		
		public var factoryClass:String;
		
//		/**
//		 * the index of this plugin info according to other sibling plugins. (same type)
//		 */		
//		
//		public var index:int;
		
		
//		[Transient]
//		public var installedPlugin:IInstalledPluginFactoryInfo;
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _loaded:Boolean;
		
		private var _plugin:IPlugin;
		
		private var _factory:IInstalledPluginFactoryInfo;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InstalledPluginInfo(factoryClass:* = null,loadedPlugin:IPlugin = null)
		{
			
			
			if(factoryClass)
				this.factoryClass = factoryClass is Class ?  DescribeTypeUtil.getClassPath(factoryClass,true) : factoryClass;
			
			
			this._plugin = loadedPlugin;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		
		public function get loadedPlugin():IPlugin
		{
			return this._plugin;
		}
	
		/**
		 * 
		 * @return 
		 * 
		 */		
		//FIXME: change to IAPlugin
		public function loadPlugin():IPlugin
		{
			if(_loaded)
			{
				throw new Error("cannot re-load plugin.");
			}
			
			_loaded = true;
			
			if(this._plugin)
				return this._plugin;
				
			
			return this._plugin = this.installedPluginFactoryInfo.loadedPluginFactory.getPlugin();
		}
		
		/**
		 * returns the loaded plugin factory
		 */
		
		//FIXME: change to IAPlugiNFactory
		public function get installedPluginFactoryInfo():IInstalledPluginFactoryInfo
		{	
			return _factory;
		}
		
		
		/**
		 */
		
		public function set installedPluginFactoryInfo(value:IInstalledPluginFactoryInfo):void
		{
			this._factory = value;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function clone():InstalledPluginInfo
		{
			return new InstalledPluginInfo(factoryClass);
		}

	}
}