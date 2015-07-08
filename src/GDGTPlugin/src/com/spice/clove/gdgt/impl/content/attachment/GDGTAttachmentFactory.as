package com.spice.clove.gdgt.impl.content.attachment
{
	import com.spice.clove.gdgt.impl.GDGTPlugin;
	import com.spice.clove.plugin.impl.content.data.attachment.CloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachment;
	import com.spice.vanilla.core.proxy.IProxyMediator;

	public class GDGTAttachmentFactory extends CloveDataAttachmentFactory
	{
		
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
		
		public function GDGTAttachmentFactory(plugin:GDGTPlugin)
		{
			super(plugin.getPluginMediator(),null,false);
			
			this._plugin = plugin;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getNewAttachment(name:String):ICloveDataAttachment
		{
			switch(name)
			{
				case GDGTAttachmentType.BEST_BUY: return new GDGTBBYAttachment(name,this._defaultRowViewController,this._plugin);
			}
			
			return null;
		}
	}
}