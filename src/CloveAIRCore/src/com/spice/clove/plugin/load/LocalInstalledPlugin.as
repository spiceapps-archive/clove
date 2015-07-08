package com.spice.clove.plugin.load
{
	import com.spice.clove.core.CloveAIRSettings;
	import com.spice.clove.plugin.compiled.CompiledPluginInfo;
	import com.spice.clove.plugin.install.AvailableExternalService;
	import com.spice.clove.plugin.install.IAvailableService;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	
	/*
	  plugins that are stored in the application storage directory
	  @author craigcondon
	  
	 */	
	 
	[Bindable] 
	[RemoteClass(alias='com.spice.clove.plugin.LocalInstalledPlugin')]
	public class LocalInstalledPlugin extends InstalledPluginFactoryInfo implements IInstalledPluginFactoryInfo
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		
        /*
          the plugin source 
         */		
        public var source:String;
        
        /*
          the remote info 
         */        
         
        public var remoteInfo:CompiledPluginInfo;
        
       
        
        /*
          the plugin class to instantiate
         */
         
        public var factoryClass:String;
        
        
        /*
          The current version of the plugin
         */
        
       // public var version:String;
        
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		private var _loadedFactory:IPluginFactory;
		private var _factoryClass:Class;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function LocalInstalledPlugin(remoteInfo:CompiledPluginInfo = null,
											 source:String = null,
											 factoryClass:String = null)
		{
			
			
			;
			
			this.remoteInfo = remoteInfo;
			this.source 	 = source;
			this.factoryClass = factoryClass;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		public function get loadedPluginFactory():IPluginFactory
		{
			
			if(!_loadedFactory && _factoryClass)
			{
				_loadedFactory = new _factoryClass();
			}
			
			return _loadedFactory;
		}
		
		/*
		 */
		
		public function get sourceFile():String
		{
			return CloveAIRSettings.getInstance().fullPluginAssetsPath+"/"+this.source
		}
		
		

		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/*
		 */
		
		public function uninstall():void
		{
			try
			{
				
				var file:File = new File(this.sourceFile);
			
				file.parent.deleteDirectory(true);
			}catch(e:*)
			{
				Logger.logError(e);
			}
		}
        
        
        /*
		 */
		
		public function getAvailableService():IAvailableService
		{
			return new AvailableExternalService(this.sourceFile,this.remoteInfo.name,this);
		}
		
        /*
		 */
		
		public function loadPluginFactory():void
		{
			
			
			try
			{
				
				//this only time this would actually happen is when the plugin is being INSTALLED
				this.setFactClass()
				this.complete();
				return;
			}
			catch(e:Error)
			{
			}
	
			var file:File = new File(this.sourceFile);
			
			
			var stream:FileStream = new FileStream();
			stream.open(file,FileMode.READ);
			
			var data:ByteArray = new ByteArray();
			stream.readBytes(data);
			stream.close();
			
			var cm:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			cm.allowLoadBytesCodeExecution = true;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSWFLoad);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			loader.loadBytes(data,cm);
		}
       

		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onIOError(event:IOErrorEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onIOError);
			
			  Logger.log("IO ERROR",this,3);
			
			this.complete();
		}
		
		
		
        /*
		 */
		
		private function onSWFLoad(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onSWFLoad);
			
			
			
			
			this.setFactClass()
			
			
			this.complete();
			
			
		}
		
		/*
		 */
		
		private function setFactClass():void
		{
			
			//initialize the plugin
			_factoryClass = flash.utils.getDefinitionByName(this.factoryClass) as Class;
		}


	}
}