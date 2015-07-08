package com.spice.clove.plugins.digg.column.controls
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.calls.DiggCall;
	import com.spice.clove.plugin.column.control.ColumnController;
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugins.digg.DiggPlugin;
	import com.spice.clove.plugins.digg.cue.DiggCue;
	import com.spice.clove.plugins.digg.icon.DiggIcons;
	import com.spice.utils.EmbedUtil;
	import com.spice.utils.queue.global.GlobalQueueManager;
	
	import flash.utils.ByteArray;

	public class DiggColumnController extends ColumnController
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:DiggPlugin;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable] 
        [ColumnSetting]
        public var columnIcon:ByteArray = EmbedUtil.toImageByteArray(DiggIcons.DIGG_16_ICON);
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggColumnController(renderer:ICloveColumnItemRenderer)
		{
			super(renderer);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function set pluginController(value:IPluginController) : void
		{
			super.pluginController = value;
			
			_plugin = DiggPlugin(value.plugin);
		}
		
		/**
		 */
		
		public function get connection():DiggService
		{
			return _plugin.connection;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function call(call:DiggCall):void
		{
			
			this.setLoadCue(call);
			
			GlobalQueueManager.getInstance().getQueueManager("digg").addCue(new DiggCue(this.connection,call,this.fillColumn));
		}
		
		
	}
}