package com.spice.clove.utils
{
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	import com.spice.clove.plugin.compiled.CompiledPluginAsset;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;
	
	public class SWCExtractor
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SWCExtractor()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function extract(swc:ByteArray,plugin:CompiledPlugin):void
		{
			
			var zip:ZipFile = new ZipFile(swc);
			
			var assets:Array = zip.entries.filter(filterAssets);
			
			var ass:Array = []
			for each(var e:String in assets)
			{
				var ze:ZipEntry = zip.getEntry(e);
				
				switch(e)
				{
					case "catalog.xml":
						continue;
					default:
						ass.push(this.handleAsset(zip,ze,plugin));
						
					break;
				}
			}
			
			
			
			plugin.assets = new ArrayCollection(ass);
			
			
			
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
		
		private function handleAsset(zip:ZipFile,data:ZipEntry,plug:CompiledPlugin):CompiledPluginAsset
		{
			var name:String = data.name;
			
			var isSource:Boolean;
			
			switch(data.name)
			{
				case "library.swf":
					name = plug.pluginInfo.name+".swf";
					isSource = true;
					
				break;
			}
			
			
			
			
			return new CompiledPluginAsset(name,zip.getInput(data),isSource);
		}

	}
}