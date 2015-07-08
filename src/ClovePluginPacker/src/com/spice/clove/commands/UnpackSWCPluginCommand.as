package com.spice.clove.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.PackerEvent;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	import com.spice.clove.plugin.compiled.CompiledPluginAsset;
	import com.spice.clove.plugin.compiled.CompiledPluginInfo;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;
	
	public class UnpackSWCPluginCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _zip:ZipFile;
		
		private var _name:String;
		private var _script:String;
		private var _factoryClass:String;
		private var _assets:Array;
		
		
		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const PLUGIN_CLASS_VAR:String = "pluginClassPath";
        public static const INSTALL_CLASS_VAR:String = "installerClassPath";
        public static const NAME_VAR:String = "pluginName";
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function UnpackSWCPluginCommand()
		{
			_assets = [];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function execute(event:CairngormEvent):void
		{
			
			var data:ByteArray = PackerEvent(event).value as ByteArray;
			
			_zip = new ZipFile(data);
			
			var assets:Array = _zip.entries.filter(filterAssets);
			
			for each(var e:String in assets)
			{
				var ze:ZipEntry = _zip.getEntry(e);
				
				switch(e)
				{
					case "catalog.xml":
						continue;
					default:
						this.handleAsset(ze);
					break;
				}
			}
			
			var info:CompiledPluginInfo = new CompiledPluginInfo(_name);
			
			
			var plugin:CompiledPlugin = new CompiledPlugin(info,
											_factoryClass,
											 new ArrayCollection(this._assets));
			
			
			
			_model.packModel.file = plugin;
										 
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function filterAssets(item:String,index:int,array:Array):Boolean
		{
			return item.match(/^(mx|locale)/) == null;
		}
		
		
		
		
		/**
		 */
		
		private function handleAsset(data:ZipEntry):void
		{
			var name:String = data.name;
			var isSource:Boolean;
			
			switch(data.name)
			{
				case "library.swf":
					name = this._name+".swf";
					isSource = true;
				break;
			}
			
			
			
			
			this._assets.push(new CompiledPluginAsset(name,_zip.getInput(data),isSource));
		}
	}
}