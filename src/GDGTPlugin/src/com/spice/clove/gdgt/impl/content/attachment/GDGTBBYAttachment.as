package com.spice.clove.gdgt.impl.content.attachment
{
	import com.spice.clove.gdgt.impl.GDGTPlugin;
	import com.spice.clove.gdgt.impl.views.attachments.BestBuyAttachmentView;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.attachment.CloveDataAttachment;
	import com.spice.clove.plugin.impl.content.data.attachment.VisibleCloveDataAttachment;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;

	public class GDGTBBYAttachment extends  VisibleCloveDataAttachment
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Embed(source="logo_png24.png")]
		public static const BBY_ICON_16:Class;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:GDGTPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GDGTBBYAttachment(name:String,viewController:ICloveDataViewController,plugin:GDGTPlugin)
		{
			super(name,viewController);
			this._plugin = plugin;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getIcon():*
		{
			return BBY_ICON_16;
		}
		
		/**
		 */
		
		override public function getLabel():String
		{
			return "Check on Best Buy";
		}
		
		
		/**
		 */
		
		override protected function visibleAttachmentClick():void
		{
			var search:String = this.getMetadata().getData();
			
			ProxyCallUtils.quickCall(CallAppCommandType.NAVIGATE_TO_URL,this._plugin.getPluginMediator(),"http://www.bestbuy.com/site/olstemplatemapper.jsp?_dyncharset=ISO-8859-1&_dynSessConf=1277723353637231750&id=pcat17071&type=page&st="+search+"&sc=Global&cp=1&nrp=15&sp=&qp=&list=n&iht=y&usc=All+Categories&ks=960")
		}
	}
}