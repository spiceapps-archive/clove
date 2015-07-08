package com.spice.clove.plugin.youtube.impl.content.control.render
{
	import com.architectd.youtube.data.YoutubeFeedData;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.data.CloveDataSettingName;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.plugin.impl.content.data.CloveMetadataType;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;

	public class YoutubeFeedItemRenderer extends AbstractCloveDataRenderer
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeFeedItemRenderer(controller:CloveContentController,mediator:IProxyMediator)
		{
			super(controller,mediator);
			
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
			super.setCloveData(vo,data);
			
			var search:YoutubeFeedData = YoutubeFeedData(vo);
			
			data.construct(search.uid,
						   search.published,
						   search.title,
						   search.description,
						   search.smallIcon);
			
			var st:SettingTable = data.getSettingTable() as SettingTable;
			
			
//			var setting:CloveDataAttachmentListSetting = CloveDataAttachmentListSetting(st.getNewSetting(CloveDataSettingType.ATTACHMENT_LIST,CloveDataSettingName.ATTACHMENTS));
//			var fav:VisibleCloveDataAttachment = VisibleCloveDataAttachment(this.getAttachmentsFactory(CloveDataSettingName.ATTACHMENTS).getNewAttachment(YoutubeDataAttachmentType.YOUTUBE_VIDEO_ATTACHMENT));
			
			
			
//			setting.addVisibleAttachment(fav);
			
			
			this.addMetadata(CloveMetadataType.EMBEDDABLE_HTML_VIDEO,search.embedUrl);
			
			this.setMessageReplacements(vo,data);
			
			return this.filterCloveData(data);
		}
		
		/**
		 */
		
		override public function getUID(vo:Object):String
		{
			return vo.uid;
		}
		
		
	}
}