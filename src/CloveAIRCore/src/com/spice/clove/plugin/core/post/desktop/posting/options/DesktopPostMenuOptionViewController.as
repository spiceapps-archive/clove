package com.spice.clove.plugin.core.post.desktop.posting.options
{
	import com.spice.clove.plugin.core.post.impl.content.option.PostMenuOptionViewController;
	import com.spice.clove.plugin.core.post.impl.outgoing.CloveAttachment;
	import com.spice.clove.post.core.outgoing.ICloveMessage;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;

	public class DesktopPostMenuOptionViewController extends PostMenuOptionViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _ref:FileReferenceList;
		private var _data:ICloveMessage;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DesktopPostMenuOptionViewController(mediator:IProxyMediator)
		{
			super(mediator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override public function attachPhoto(value:ICloveMessage):void
		{
			_data = value;
			
			_ref = new FileReferenceList();
			_ref.addEventListener(Event.SELECT,onFilesSelect,false,0,true);
			
			_ref.browse([new FileFilter("Select Photos","*.jpg;*.jpeg;*.gif;*.png;*.tif")]);
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onFilesSelect(event:Event):void
		{
			
			for each(var item:FileReference in _ref.fileList)
			{
				_data.addAttachment(new CloveAttachment(item));
			}
		}
	}
}