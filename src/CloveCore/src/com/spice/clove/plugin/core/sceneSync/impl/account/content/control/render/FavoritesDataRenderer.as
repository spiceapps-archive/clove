package com.spice.clove.plugin.core.sceneSync.impl.account.content.control.render
{
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.data.CloveDataSettingName;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.sceneSync.impl.service.data.FavoriteItem;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.plugin.impl.content.data.attachment.CloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	
	public class FavoritesDataRenderer extends AbstractCloveDataRenderer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FavoritesDataRenderer(controller:CloveContentController,mediator:IProxyMediator, useGlobalDataRenderers:Boolean=true)
		{
			super(controller,mediator,null, useGlobalDataRenderers);
			
			
			this.setAttachmentsFactory(CloveDataSettingName.ATTACHMENTS,new CloveDataAttachmentFactory(mediator));
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
			
			var fd:FavoriteItem = FavoriteItem(vo);
			
			data.construct(fd.id.toString(),fd.datePosted,fd.name,fd.metadata.content,fd.metadata.icon);
			
			return true;
		}
		
		/**
		 */
		
		override public function getUID(vo:Object):String
		{
			return vo.id;
		}
	}
}