package com.spice.clove.plugin.flex.views.column.row
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.Canvas;
	import mx.containers.VBox;

	public class ColumnRowBody extends  Canvas  
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _attachmentsView:ColumnRowAttachmentsView;
		private var _data:ICloveData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ColumnRowBody()
		{
			this.setStyle("paddingTop",2);
			this.setStyle("verticalGap",8);
			this.setStyle("paddingBottom",8);
			this.percentWidth = 100;
			this.clipContent = false;
			this.doubleClickEnabled = true;
			this.minHeight = 50;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		[Bindable(event="dataChange")]
		public function get cloveData():ICloveData
		{
			return _data;
		}
		
		/**
		 */
		
		override public function set data(value:Object):void
		{
			_data = ICloveData(value);
			
			super.data = value;
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		/*override protected function createChildren():void
		{
			super.createChildren();
			
			_attachmentsView = new ColumnRowAttachmentsView();
			 BindingUtils.bindProperty(_attachmentsView,"cloveData",this,"data");
			 addChild(_attachmentsView);
		}*/
	}
}