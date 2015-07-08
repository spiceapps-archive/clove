package com.spice.flex.views.text
{
	import flash.events.Event;
	import flash.text.FontStyle;
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.ITextExporter;
	import flashx.textLayout.conversion.ITextImporter;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.elements.LinkNormalFormat;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.FlowOperationEvent;
	import flashx.textLayout.events.SelectionEvent;
	import flashx.textLayout.events.StatusChangeEvent;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.undo.UndoManager;
	
	import mx.containers.Canvas;
	import mx.controls.TextArea;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.ScrollControlBase;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	[Style(name="paddingLeft", type="Number", inherit="no")]
	[Style(name="paddingRight", type="Number", inherit="no")]
	[Style(name="paddingTop", type="Number", inherit="no")]
	[Style(name="paddingBottom", type="Number", inherit="no")]
	
	[Event(name="textChange")]
	
	[DefaultProperty("text")]

	public class RichTextArea extends ScrollControlBase
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _textFlow:TextFlow;
		private var _format:TextLayoutFormat;
		private var _textFlowContainer:UIComponent;
		private var _textFlowController:ContainerController;
		private var _editManager:EditManager;
		private var _mask:UIComponent;
		private var _span:SpanElement;
		private var _exporter:ITextExporter;
		private var _importer:ITextImporter;
		
		private var _text:String;
		
		
		//events
		private var _textChangeEvent:Event;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RichTextArea()
		{
			_text = "";
			
			this.setStyle("backgroundColor",0xFFFFFF);
			this.setStyle("paddingLeft",10);
			this.setStyle("paddingRight",10);
			this.setStyle("paddingTop",10);
			this.setStyle("paddingBottom",10);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		[Bindable(event="textChange")]
		public function get text():String
		{
			if(_exporter && _textFlow)
			{
				_text = _exporter.export(this._textFlow,  ConversionType.STRING_TYPE).toString();
			}
			
			return _text;
		}
		
		
		/**
		 */
		
		public function set text(value:String):void
		{
			_text = value;
			
			if(_textFlow)
			{
				this.setupNewTextFlow(_text);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function scrollHandler(event:Event):void
		{
			super.scrollHandler(event);
			
			this._textFlowController.verticalScrollPosition = this.verticalScrollPosition;
		}
		
		
		/**
		 */
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			if(!_textFlow)
				return;
			
			
			
			var pl:Number = this.getStyle("paddingLeft") + 5;
			var pr:Number = this.getStyle("paddingRight") + 5;
			var pt:Number = this.getStyle("paddingTop") + 5;
			var pb:Number = this.getStyle("paddingBottom") + 5;
			
			drawMask();
			
			var height:Number = _textFlowController.getContentBounds().height;
			var actualHeight:Number = isNaN(this.height) ? height : unscaledHeight;
			var newHeight:Number = actualHeight - pt - pb;
			var newWidth:Number = unscaledWidth - pl - pr;
			
			this.setScrollBarProperties(unscaledWidth,unscaledWidth,height+pt,unscaledHeight-pt-pb);
			
			
			this._textFlowController.verticalScrollPosition = this.verticalScrollPosition;
			
			
			this._textFlowContainer.x = pl;
			this._textFlowContainer.y = pt;
			
			_textFlowController.setCompositionSize(newWidth,newHeight);
			
			_textFlow.flowComposer.updateAllControllers();
		}
		/**
		 */
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			
			_mask = new UIComponent();
			
			this.mask = _mask;
			
			this.setupNewTextFlow(_text);
			
			addChild(_mask);
				
			
		}
		
		/**
		 */
		
		private function setupNewTextFlow(text:String = ""):void
		{
			if(_textFlow)
			{
				_textFlow.removeEventListener(SelectionEvent.SELECTION_CHANGE,onSelectionChange);
				_textFlow.removeEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN,onFlowOperationBegin);
				_textFlow.flowComposer.removeAllControllers();
			}
			else
			{
				_textFlowContainer = new UIComponent();
				
				_importer 			=  TextConverter.getImporter(TextConverter.HTML_FORMAT);
				_exporter = TextConverter.getExporter(TextConverter.HTML_FORMAT);
				_textFlowController = new ContainerController(_textFlowContainer,100,100);
				this._editManager   = new EditManager(new UndoManager());
				
				
				addChild(_textFlowContainer);
			}
			
			_textFlow = _importer.importToFlow(this._text);
			_textFlow.interactionManager = this._editManager;
			_textFlow.flowComposer.addController(_textFlowController);
			_textFlow.flowComposer.updateAllControllers();
			
			
			var linkFormat:LinkNormalFormat = new LinkNormalFormat();
			linkFormat.fontStyle = FontStyle.BOLD;
			
			_textFlow.linkNormalFormat = linkFormat;
			
			
			_textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE,onSelectionChange);
			_textFlow.addEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN,onFlowOperationBegin);
		}
		
		private function onFlowOperationBegin(e:FlowOperationEvent):void
		{
			this.dispatchEvent(new Event("textChange"));
		}
		
		
		
		
		/**
		 */
		
		private function onSelectionChange(event:SelectionEvent):void
		{
			
		}
		
		
		/**
		 */
		
		private function drawMask():void
		{
			with(_mask.graphics)
			{
				beginFill(0);
				drawRect(0,
						 0,
						 this.unscaledWidth,
						 this.unscaledHeight);
			}
		}
	}
}