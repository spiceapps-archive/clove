package com.spice.clove.plugin.column
{
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.core.root.impl.settings.RootPluginSettingType;
	import com.spice.utils.queue.cue.CueStateType;
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.BooleanSetting;
	import com.spice.vanilla.impl.settings.basic.ByteArraySetting;
	
	import flash.events.Event;
	import flash.utils.IDataInput;
	import flash.utils.setTimeout;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.events.CollectionEvent;
	
	public class HolderColumn extends ClovePluginColumn
	{
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _ignoreTitleChange:Boolean;
		private var _titleWatch:ChangeWatcher;
		public var useCustomTitle:BooleanSetting;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function HolderColumn()
		{
			super(null,RootPluginSettingType.HOLDER_COLUMN);
			
			
				
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		
		override public function set title(value:String):void
		{
			super.title = value;
			
			this.onTitleChange();
		}
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setColumnInfo(value:SettingTable):void
		{
			
			this.useCustomTitle = BooleanSetting(value.getNewSetting(BasicSettingType.BOOLEAN,"useCustomTitle"));
			
			super.setColumnInfo(value);
			
//			this._title.addObserver(new CallbackObserver(SettingChangeNotification.CHANGE,onTitleChangeNotification));
		}
		/*
		 */
		
		override protected function onChildrenChange(event:CollectionEvent) : void
		{
			super.onChildrenChange(event);
			
			this.setDefaultTitle();
		}
		
		
		private var _pt:String;
		
		/*
		 */
		
		private function setDefaultTitle():void
		{
			if(this._ignoreTitleChange)
			{
				
				_ignoreTitleChange = false;
				return;
			}
			
			
			if(this.children.length == 0)
			{
				this._ignoreTitleChange = true;
				
				if(!this.useCustomTitle.getData())
					this.title = _pt = "Untitled";
				return;
			}
			
			
			var firstChild:ClovePluginColumn = ClovePluginColumn(this.children.getItemAt(0));
			
			
			if(_titleWatch)
				_titleWatch.unwatch();
			
			//if the title isn't set by the user, then we use the FIRST feed's title
			//to make it quicker and easier
			if(!this.useCustomTitle.getData())
			{
				
				_titleWatch = ChangeWatcher.watch(firstChild,"title",onFirstTitleChange,false,true);
				onFirstTitleChange();
				
			}
			
			
			
			this.getIcon().setData(firstChild.getIcon().getData());
			
		}
		
		
		
		private function onFirstTitleChange(event:* = null):void
		{
			
			if(this.useCustomTitle.getData())
				return;
			
			this._ignoreTitleChange = true;
			
			
			if(this.children.length == 0)
			{
				this.setDefaultTitle();
				return;
			}
			var childTitle:String = ClovePluginColumn(this.children.getItemAt(0)).title;
			
			if(childTitle.toLowerCase().indexOf("untitled") == -1)
			this.title = ClovePluginColumn(this.children.getItemAt(0)).title;
		}
		/*
		 */
		
		private function onTitleChange():void
		{
			if(this.title == "" || this.title.toLowerCase().indexOf("untitled") > -1)
			{
				this._ignoreTitleChange = false;
				this.useCustomTitle.setData(false);
				
				//the setting bind is caught AFTER this method, so it will be set to blank if there's no delay
				flash.utils.setTimeout(setDefaultTitle,1);
				return;
			}
			
			
			//if there is no title then the column is initializing
			if(_ignoreTitleChange || this.title== "null" || !this.title)
				return;
			
			this.useCustomTitle.setData(true);
		}
		
		/**
		 */
		
		/*private function onTitleChangeNotification(n:INotification):void
		{
			this.onTitleChange();
		}*/
		
		
	}
}