package com.spice.clove.gdgt.impl.content.control.render
{
	import com.spice.clove.gdgt.impl.GDGTPlugin;
	import com.spice.clove.gdgt.impl.content.attachment.GDGTAttachmentType;
	import com.spice.clove.gdgt.impl.content.control.GDGTContentController;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.rss.impl.content.control.render.RSSFeedDataRenderer;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;

	public class GDGTFeedDataRenderer extends RSSFeedDataRenderer
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GDGTFeedDataRenderer(controller:GDGTContentController,plugin:GDGTPlugin)
		{
			super(controller,plugin);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function setCloveData(vo:Object, data:ICloveData):Boolean
		{
			var acceptable:Boolean = super.setCloveData(vo,data);
			
			if(acceptable)
			{
				
				
				var link:String = StringSetting(data.getSettingTable().getNewSetting(BasicSettingType.STRING,"link")).getData();
				
				var parts:Array = link.split('/');
				//      01		  2			3*
				//http://gdgt.com/microsoft/xbox/1st-gen/
				
				var search:String = parts[4]+(parts.length >= 6 ? " "+parts[5]: "");
				
				
				this.addMetadata(GDGTAttachmentType.BEST_BUY,search);
			}  
			
			this.setMessageReplacements(vo,data);
			
			return acceptable;
		}
	}
}