package com.spice.clove.plugin.twitter.install.importService.seesmic
{
	import com.bridge.node.BridgeNode;
	import com.spice.clove.commandEvents.CreateColumnEvent;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.clove.plugin.twitter.column.control.TwitterKeywordSearchColumnController;
	import com.spice.clove.plugin.twitter.icons.TwitterIcons;
	import com.spice.clove.plugin.twitter.install.importService.ServiceImporter;
	import com.spice.clove.plugin.twitter.install.importService.seesmic.xml.SearchModule;
	import com.spice.utils.EmbedUtil;
	import com.spice.utils.classSwitch.ClassSwitcher;
	import com.spice.utils.classSwitch.util.SFileUtil;
	
	import flash.events.Event;
	
	
	/*
	  imports seesmic columns 
	  @author craigcondon
	  
	 */
	 	
	
	public class SeesmicImporter extends ServiceImporter
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _xmlFile:*;
		private var _controller:IPluginController;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function SeesmicImporter()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function importService(controller:IPluginController):void
		{
			var seesmic:* = this.getPrefFolder("seesmic");
			
			this._controller = controller;
			
			if(!seesmic)
				return;
				
			var fu:* = ClassSwitcher.getTargetClass(SFileUtil);
			
			_xmlFile = fu.searchFile(seesmic,new RegExp("xmlAdapter.xml"));
			_xmlFile.addEventListener(Event.COMPLETE,onXMLOpen);
			_xmlFile.load();
			
		}
		
		/*
		 */
		
		override public function hasService() : Boolean
		{
			return this.getPrefFolder("seesmic") != null;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onXMLOpen(event:Event):void
		{
			event.target.removeEventListener(event.type,onXMLOpen);
			
			var script:String = _xmlFile.data.readUTFBytes(_xmlFile.data.bytesAvailable);
			
			var searchMod:SearchModule = new SearchModule();
			
			
			var node:BridgeNode = new BridgeNode();
			node.addModule(searchMod);
			node.parseXML(script);
			node.restart();
			
			
			if(searchMod.searchTerms.length > 0)
			{
				var gMetadata:Object = {};
			
				gMetadata[ColumnMetaData.COLUMN_ICON] = EmbedUtil.toImageByteArray( TwitterIcons.TWITTER_32_ICON);
				gMetadata[ColumnMetaData.TITLE] = CloveTwitterPlugin(_controller.plugin).settings.username;
				
				var searches:Array = [];
				var metadata:Array = gMetadata.children = [];
			
				for each(var term:String in searchMod.searchTerms)
				{
					
					searches.push([new TwitterKeywordSearchColumnController(this._controller,term)]);
					metadata.push({title:'Search: '+term});
				}
				
				new CreateColumnEvent(searches,null,gMetadata).dispatch();
					
					
				
			}
		}

	}
}