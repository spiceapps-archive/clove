package com.spice.clove.plugin.gdgt.column.render
{
	import com.adobe.xml.syndication.atom.Entry;
	import com.adobe.xml.syndication.atom.Link;
	import com.spice.clove.plugin.column.render.IReusableCloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.gdgt.cue.GDGTReviewFetchCue;
	
	public class GDGTColumnItemRenderer implements IReusableCloveColumnItemRenderer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var pluginController:IPluginController;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function GDGTColumnItemRenderer(controller:IPluginController)
		{
			this.pluginController = controller;
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		/*
		 */
		
		public function getUID(vo:Object):String
		{
			return vo.title;
		}
		
        /*
		 */
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			var entry:Entry = Entry(vo);
			
			
			var logo:String = "http://media.gdgt.com/img/site/gdgt-logo-red.gif";
			
			var link:Link = entry.links[0];
			
			
			var meta:Object = {link:link.href};
			
			var rd:RenderedColumnData = new RenderedColumnData();
			rd.construct(entry.title,entry.updated,entry.title,"loading...","http://media.gdgt.com/img/site/gdgt-logo-red.gif",meta);
			
			Logger.log("getRenderedData title="+rd.title+" uid="+rd.rowuid+" message=",this);
			
			return rd;
		}
		
		/*
		 */
		
		public function reuse(data:RenderedColumnData):void
		{
			new GDGTReviewFetchCue(data.vo.link,data).init();
		}
		
		

	}
}