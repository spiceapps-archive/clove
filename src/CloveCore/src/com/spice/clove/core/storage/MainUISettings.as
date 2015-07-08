package com.spice.clove.core.storage
{
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.utils.storage.ChildSettings;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.persistent.SettingManager;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Bindable] 
	public class MainUISettings extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


		//for dock icons
		[Setting(min=54,max=400)]
		public var dockSize:int = 200;
		
		
		[Setting(min=50,max=3000)]
		public var cacheLimit:int = 50;
		
		
		[Setting(min=1,max=60)]
		public var refreshRate:int = 5;
		
		
		[Setting(min=10,max=32)]
		public var fontSize:int = 12;
		
		
		[Setting]
		public var autoCollapseGroups:Boolean = true;
		
		[Setting]
		public var checkForUpdatesOnStartup:Boolean = true;
		
		
		
		private var _loadAllGroups:Boolean;
		
		[Setting]
		[Bindable("loadAllGroupsChange")]
		public function get loadAllGroups():Boolean
		{
			return this._loadAllGroups;
		}
		
		public function set loadAllGroups(value:Boolean):void
		{
			if(_loadAllGroups == value)
				return;
			
			this._loadAllGroups = value;
			
			
			//tell the plugins to stop / start self loading 
			ProxyCallUtils.quickCall(CallClovePluginType.IS_SELF_LOADING,ClovePluginMediator.getInstance(),value);
			
			this.dispatchEvent(new Event("loadAllGroupsChange"));
		}
		
		
		/*	[Bindable]
		[Setting(min=10,max=32)]
		public function get fontSize():int
		{
			return _fontSize;
		}
		
		public function set fontSize(value:int):void
		{
			this._fontSize = value;
			
			//breaks it 
			//StyleManager.getStyleDeclaration("global").setStyle("fontSize",value);
			
			
		}*/
		
		
		//read/unread content
		[Setting]
		public var autoScroll:Boolean = false;
		
		
		[Setting]
		public var appWidth:Number  = NaN;
		
		
		[Setting]
		public var appHeight:Number = NaN;
		
		
		[Setting]
		public var appX:Number		= 0;
		
		[Setting]
		public var appY:Number		= 0;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		private var _fontSize:int;
		private var _fontFamily:Object = "lucidaSans";
		private var _useInternationalFonts:Boolean;
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		[Setting]
		[Bindable(event="intFontsChange")]
		public function get useInternationalFonts():Boolean
		{
			return _useInternationalFonts;
		}
		
		/*
		 */
		
		public function set useInternationalFonts(value:Boolean):void
		{
			_useInternationalFonts = value;
			
			
			if(value)
			{
				_fontFamily = ["Helvetica","Arial"];
			}
			else
			{
				_fontFamily = ["lucidaSans"];
			}
			
			dispatchEvent(new Event("intFontsChange"));
		}
		
		
		/*
		 */
		
		[Bindable("intFontsChange")]
		public function get fontFamily():Object
		{
			return _fontFamily;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function MainUISettings(parentSettings:INotifiableSettings)
		{
			new SettingManager(new ChildSettings(parentSettings,"MainUISettings"),this);
		}

	}
}