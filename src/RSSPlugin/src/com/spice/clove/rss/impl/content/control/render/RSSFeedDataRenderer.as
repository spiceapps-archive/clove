package com.spice.clove.rss.impl.content.control.render
{
	import com.adobe.xml.syndication.atom.Atom10;
	import com.adobe.xml.syndication.generic.Atom10Item;
	import com.adobe.xml.syndication.generic.RSS10Item;
	import com.adobe.xml.syndication.generic.RSS20Item;
	import com.adobe.xml.syndication.rss.IItem;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.data.CloveDataSettingName;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.clove.rss.impl.RSSPlugin;
	import com.spice.clove.rss.impl.calls.CallRSSPluginType;
	import com.spice.clove.rss.impl.data.attachment.RSSDataAttachmentFactory;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;

	public class RSSFeedDataRenderer extends AbstractCloveDataRenderer
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:ClovePlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RSSFeedDataRenderer(controller:CloveContentController,plugin:ClovePlugin)
		{  
//			super(
			this._plugin = plugin;
			
			super(controller,plugin.getPluginMediator(),new RegisteredCloveDataViewController(CallRSSPluginType.GET_NEW_REGISTERED_RSS_ROW_VIEW_CONTROLLER,plugin.getPluginMediator()));
			
//			this.setAttachmentsFactory(CloveDataMetadataType.ATTACHMENTS,new RSSDataAttachmentFactory(mediator));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		public function getPlugin():ClovePlugin
		{
			return this._plugin;
		}
		/**
		 * Abstract
		 * @inherit
		 * 
		 */		
		override public function getUID(vo:Object):String
		{
			try
			{
				
				if(vo is Atom10Item)
				{
					return Atom10Item(vo).link;
				}
				else
				if(vo is RSS10Item)
				{
					return RSS10Item(vo).link;
				}
				else
				if(vo is RSS20Item)
				{
					return RSS20Item(vo).link;
				}
			
			}catch(e:Error)
			{
				return vo.title;
			}
			
			return "";
		}
		
		
		
		/**
		 */		
		
		override public function setCloveData(vo:Object,data:ICloveData):Boolean
		{
//			var data:RenderedColumnData = new RenderedColumnData();
//			data.construct(vo.pubDate + vo.title,vo.pubDate,vo.title,vo.description,String(_icon),{link:vo.link});
//			
//			var c:RenderedColumnDataAttachment;
			
			super.setCloveData(vo,data);
			
			var date:Date;
			var title:String;
			var desc:String;
			var link:String;
			
			if(vo is Atom10Item)
			{
				date = Atom10Item(vo).date;	
				title = Atom10Item(vo).title;	
				desc = Atom10Item(vo).excerpt.value;
				link = Atom10Item(vo).link;	
			}
			else
			if(vo is RSS10Item)
			{
				date = RSS10Item(vo).date;
				title = RSS10Item(vo).title;
				desc = RSS10Item(vo).excerpt.value;
				link = RSS10Item(vo).link;
			}
			else
			if(vo is RSS20Item)
			{
				date = RSS20Item(vo).date;
				title = RSS20Item(vo).title;
				desc = RSS20Item(vo).excerpt.value;
				link = RSS20Item(vo).link;
			}
			 
			
			//for now, remove all links because they cause problems...
			
			data.construct(this.getUID(vo),date,title,desc && desc != "null" ? desc.replace(/<\/?a.*?>/igs,"") : "");
			
			var st:ISettingTable = data.getSettingTable();
			
			StringSetting(st.getNewSetting(BasicSettingType.STRING,"link")).setData(vo.link);
			
			
			
			
			return this.filterCloveData(data) || this.filterText(desc);
		}
	}
}