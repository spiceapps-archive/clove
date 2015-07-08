package com.spice.clove.plugin.compiled
{
	import com.spice.air.utils.*;
	import com.spice.clove.core.CloveAIRSettings;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.clove.plugin.load.LocalInstalledPlugin;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import mx.collections.ArrayCollection;
	
	
	[Bindable] 
	[RemoteClass(alias='CompiledPlugin')]
	
	/*
	  packed on the server and stored as a file. Contains directions on how to execute plugin
	  @author craigcondon
	  
	 */	
	 
	public class CompiledPlugin extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		
		
		/*
		  the zipped file assets  
		 */		
		public var assets:ArrayCollection;
		
		public var info:CompiledPluginInfo;
		
		
        
        
        
        
        private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		private var _pluginFactory:IPluginFactory;
		private var _factory:String;
		private var _info:CompiledPluginInfo;
        
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
        
        /*
		 */
		 
		
		public function CompiledPlugin(){}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		public function set factoryClass(value:String):void
		{
			_factory = value;
			dispatchEvent(new Event("factoryClassChange"));
		}
		
		/**
		 * @Depricated
		 */
		
		
		[Bindable(event="factoryClassChange")]
		public function get factoryClass():String
		{
			return _factory ? _factory : this.pluginInfo.factoryClass;
		}
        
        
        /**
		 */
		
		public function set pluginInfo(value:CompiledPluginInfo):void
		{
			this._info = value;
			
			dispatchEvent(new Event("infoChange"));
		}
		
		
		/**
		 * @Depricated
		 */
		
		public function get pluginInfo():CompiledPluginInfo
		{
			return this._info ? this._info : this.info;
		}
		
        /*
		 */
		
		public function load(callback:Function):void
		{
			
			var swf:CompiledPluginAsset;
			
			for each(swf in this.assets.toArray())
			{
				if(swf.isSource)
				{
					
					break;
				}
			}	
			
			var ci:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			ci.allowLoadBytesCodeExecution = true;
			
			
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,callback);
			loader.loadBytes(swf.data,ci);
			
		}
		
        /*
          installs the plugin and returns the driver path
          
          @param dir the directory to install the plugin to
		 */
		
		public function install():IInstalledPluginFactoryInfo
		{
				
			
			var source:String;
			
			
			var factDir:String = this.factoryClass.split("::").join(".");
			
			var pluginDir:String = CloveAIRSettings.getInstance().fullPluginAssetsPath+"/"+factDir;
			
			var assetDir:File = new File(pluginDir);
			
			if(!assetDir.exists)
				assetDir.createDirectory();
			
			
			 for each(var asset:CompiledPluginAsset in this.assets.toArray())
			{
				
				var file:File = FileUtil.resolvePath(assetDir,asset.name);
				
				
				if(asset.isSource)
				{
					
					//NOTE!!! we set the initial source since any ADDITIONAL copy of this plugin
					//will go to this dir for the swf
					source = factDir+"/"+asset.name;
				}
				
				var stream:FileStream = new FileStream();
				stream.open(file,FileMode.WRITE);
				stream.writeBytes(asset.data);	
			} 
			
			return new LocalInstalledPlugin(this.pluginInfo,source,this.factoryClass);
		}
		
		
	}
}