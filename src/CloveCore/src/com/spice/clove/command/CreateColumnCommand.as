package com.spice.clove.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.commandEvents.CreateColumnEvent;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.GroupColumn;
	import com.spice.clove.plugin.column.HolderColumn;
	import com.spice.clove.util.ColumnUtil;
	
	public class CreateColumnCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		private var _event:CreateColumnEvent;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CreateColumnCommand()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function execute(event:CairngormEvent):void
		{
			_event = CreateColumnEvent(event);
			
			
			
			this.addColumn();

			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function addColumn():void
		{
			
			
			
			var firstItem:* = _event.controllers[0];
			
			if(firstItem is Array)
			{
				this.createGroup();
			}
			else
			{
				
				new CloveEvent(CloveEvent.ADD_COLUMN,this.createHolder(_event.controllers,_event.metadata)).dispatch();
			}

			
		}
		
		
		/*
		 */
		
		private function createGroup():void
		{
			
			var metadata:Object = _event.metadata;
			
			var gMeta:Object = {};
			var cMeta:Array  = [];
			
			if(metadata is Array)
			{
				cMeta = Array(metadata);
			}
			else
			{
				//metadata provided for the group column too
				gMeta = metadata;
				cMeta = metadata.children;
				metadata.children = undefined;
			}
			
			var col:GroupColumn = new GroupColumn();
//			ColumnUtil.saveMetadata(col, gMeta ? gMeta : {});
			
			for(var i:int = 0; i < _event.controllers.length; i++)
			{
				col.children.addItem(this.createHolder(_event.controllers[i],cMeta[i]));
			}
			
			
			new CloveEvent(CloveEvent.ADD_COLUMN,col).dispatch();
		}
		
		
		/*
		 */
	
		private function createHolder(stack:Array,metadata:Object):HolderColumn
		{
			/*var col:HolderColumn = new HolderColumn();
			ColumnUtil.saveMetadata(col, metadata ? metadata : {});
			
			for each(var controller:IColumnController in stack)
			{
				//var pcol:ClovePluginColumn = new ClovePluginColumn(controller);
				col.children.addItem(pcol);
			}
			
			
			
			//tell the column to load
			pcol.dispatchEvent(new CloveColumnEvent(CloveColumnEvent.LOAD));
			
			if(_event.callback != null)
			{
				_event.callback(pcol);
			}
			*/
			
			return null;
		}

	}
}