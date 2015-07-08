package com.spice.clove.plugin.facebook.column.control
{
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.column.ICloveColumn;
	import com.spice.clove.plugin.column.control.ColumnController;
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.facebook.CloveFacebookPlugin;
	import com.spice.clove.plugin.facebook.cue.FacebookCallCue;
	import com.spice.clove.plugin.facebook.icons.FacebookIcons;
	import com.spice.utils.EmbedUtil;
	import com.spice.utils.queue.cue.ICue;
	import com.spice.utils.queue.cue.StateCue;
	
	import flash.utils.ByteArray;
	
	public class FacebookColumnController extends ColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable]
        [ColumnSetting]
        public var columnIcon:ByteArray = EmbedUtil.toImageByteArray(FacebookIcons.FACEBOOK_ICON_16)
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookColumnController(controller:IPluginController,itemRenderer:ICloveColumnItemRenderer)
		{
			super(itemRenderer);
			
			
			
			if(controller)
				this.pluginController = controller;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		protected function call(call:*,resultCallback:Function = null):void
		{
			var c:ICue = call is ICue ? call : new FacebookCallCue(call,resultCallback);
			
			
			this.setLoadCue(StateCue(c));
			
			//c.init();
			//c.init();
			//for now
			CloveFacebookPlugin(this.pluginController.plugin).call(c);
		}

	}
}