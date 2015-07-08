package com.spice.clove.nectars.impl.content.control.render
{
	import com.spice.clove.nectars.impl.data.attachment.NectarsDataAttachment;
	import com.spice.clove.nectars.impl.data.attachment.NectarsDataAttachmentFactory;
	import com.spice.clove.nectars.impl.data.attachment.NectarsDataAttachmentType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.CloveDataSettingName;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.content.data.attachment.ICloveDataAttachmentListSetting;
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadata;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.plugin.impl.content.data.CloveDataSettingType;
	import com.spice.clove.plugin.impl.text.command.handle.CloveDataTextCommandTarget;
	import com.spice.core.text.command.handle.ITextCommandResultController;
	import com.spice.impl.text.command.TextCommandTarget;
	import com.spice.impl.text.command.handle.TextCommandHandler;
	import com.spice.impl.text.command.handle.link.TextCommandLinkHandler;
	import com.spice.vanilla.impl.proxy.ProxyOwner;

	public class NectarsDataRenderer extends ProxyOwner implements ICloveDataRenderer //ICloveData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		private var _urlsToExpand:Vector.<String>;
		private var _urlChecker:TextCommandHandler;
		private var _textCommandTarget:CloveDataTextCommandTarget;
		private var _attachmentFactory:NectarsDataAttachmentFactory;
		
		
		/**
		 * the number of characters allowed for taking links out. This is targeted towards Twitter, and other posts that are short. Anything long
		 * like RSS, or a blog post shouldn't have ANY text removed. 
		 */		
		public static const REMOVE_LINK_MAX_CHARS:Number = 400;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function NectarsDataRenderer(factory:NectarsDataAttachmentFactory)
		{
			super();
			
			
			_attachmentFactory = factory;
			
			this._urlsToExpand = new Vector.<String>();
			//top url shorteners
			_urlsToExpand.push("doiop.com","tinyurl.com","bit.ly","is.gd","zi.ma","su.pr","tr.im","u.nu","cli.gs","short.ie","kl.am","hex.io","ow.ly");
			
			  
			_urlChecker = new TextCommandHandler("((http://)*("+this._urlsToExpand.join("|")+")[^\\s]+)","ig");
			
			_textCommandTarget = new CloveDataTextCommandTarget();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getUID(vo:Object):String
		{
			return null;
		}
		
		
		/**
		 */
		
		public function setCloveData(vo:Object,data:ICloveData):Boolean
		{
			
			this._textCommandTarget.setTarget(data);
			
//			if(_urlChecker.test(_textCommandTarget))
//			{	
//				
//				var tc:ITextCommandResultController = _urlChecker.getHandledResultController(this._textCommandTarget);
//				
//				var urls:Object = tc.getTestResult();
//				
//				var s:ICloveDataAttachmentListSetting = ICloveDataAttachmentListSetting(data.getSettingTable().getNewSetting(CloveDataSettingType.ATTACHMENT_LIST,CloveDataSettingName.ATTACHMENTS));
//				
//				
//				for each(var link:String in urls)
//				{
//					var linkAtt:NectarsDataAttachment = NectarsDataAttachment(_attachmentFactory.getNewAttachment(NectarsDataAttachmentType.LONG_URL_EXPAND_ATTACHMENT));
//					linkAtt.setLink(link);
//					
//					s.addVisibleAttachment(linkAtt);
//				}
//				
//				
//				
//				//remove ALL links from the post that need to be expanded. This well appear 
//				if(data.getMessage().length <= REMOVE_LINK_MAX_CHARS)
//				{
//					tc.setReplacement("<font color=\"#999999\">[1]</font>");
//				}
//			}
//			
			
			return true;
		}
		
		/**
		 */
		
		public function setContentView(data:ICloveData,target:ICloveViewTarget):void
		{
		}
		
		
		/**
		 */
		
		public function getMetadataView(data:ICloveMetadata):ICloveDataViewController
		{
			return null;
		}
	}
}