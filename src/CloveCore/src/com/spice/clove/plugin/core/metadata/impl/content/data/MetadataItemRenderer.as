package com.spice.clove.plugin.core.metadata.impl.content.data
{
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadata;
	import com.spice.clove.plugin.core.metadata.impl.content.data.meta.MetadataAttachmentFactory;
	import com.spice.clove.plugin.core.metadata.impl.content.data.meta.MetadataVideoAttachment;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.CloveMetadataType;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.impl.proxy.ProxyOwner;

	public class MetadataItemRenderer extends ProxyOwner implements ICloveDataRenderer
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _factory:MetadataAttachmentFactory;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function MetadataItemRenderer(mediator:IProxyMediator)
		{
			_factory = new MetadataAttachmentFactory(mediator);
		}
		
		public function setCloveData(vo:Object,target:ICloveData):Boolean{ return false; }
		public function getUID(vo:Object):String{ return null; }
		public function setContentView(data:ICloveData,target:ICloveViewTarget):void{ }
		
		
		public function getMetadataView(metadata:ICloveMetadata):ICloveDataViewController
		{
			var factory:* = this._factory.getNewAttachment(metadata.getType());
			
			if(factory)
			factory.setMetadata(metadata);
			return factory;
		}
		
		
	}
}