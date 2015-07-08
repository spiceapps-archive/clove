package com.spice.clove.plugin.install
{
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	import com.spice.clove.plugin.compiled.CompiledPluginInfo;
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.clove.plugin.load.LocalInstalledPlugin;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.utils.queue.cue.Cue;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.getDefinitionByName;
	
	
	[Bindable] 
	[RemoteClass(alias="AvailableExternalService")]
	public class AvailableExternalService extends AbstractCue implements IAvailableService
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var pluginPath:String;
        public var info:CompiledPluginInfo;
        public var optional:Boolean = true;
        public var selected:Boolean = true;
        public var visible:Boolean = true;
        public var name:String;
        public var uid:String;
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		private var _cplugin:CompiledPlugin;
		private var _lip:LocalInstalledPlugin;
		private var _pluginFactory:IPluginFactory;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function AvailableExternalService(pluginPath:String = null,
												 name:String = null,
												 lp:LocalInstalledPlugin = null)
		{
			this.pluginPath = pluginPath;
			
			this.name = name;
			
			_lip = lp;
			
			if(lp)
			{
				
				init2(_lip.factoryClass,false);
			}
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		public function get factory():IPluginFactory
		{
			return this._pluginFactory;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /*
		 */
		
		override public function initialize():void
		{
			
			if(this._lip)
			{
				this.complete();
				return;
			}
			
			
			var cpluf:File = new File(File.applicationDirectory.nativePath+"/"+this.pluginPath);
			var stream:FileStream = new FileStream();
			stream.open(cpluf,FileMode.READ);
			
			_cplugin = stream.readObject();
			_cplugin.load(onPluginLoad);
			
			
		}
        /*
		 */
		
		public function install():IInstalledPluginFactoryInfo
		{
			
			if(_lip)
			{
				return new LocalInstalledPlugin(_lip.remoteInfo,_lip.source,_lip.factoryClass);
			}
			
			_cplugin.uid = this.uid;
			
			return _cplugin.install();
		}
		
		
		
		/*
		 */
		
		private function onPluginLoad(event:Event):void
		{
			
			event.currentTarget.removeEventListener(event.type,onPluginLoad);
			
			
			
			this.init2(_cplugin.factoryClass);
			
			
		}
		
		
		/**
		 */
		
		private function init2(factory:String,comp:Boolean = true):void
		{
			var clazz:Class = flash.utils.getDefinitionByName(factory) as Class;
			
			this._pluginFactory = IPluginFactory(new clazz());
			
		}
		

	}
}