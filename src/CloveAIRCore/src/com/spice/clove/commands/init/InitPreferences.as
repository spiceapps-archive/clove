package com.spice.clove.commands.init
{
	import com.spice.air.utils.*;
	import com.spice.clove.command.initialize.IInitializer;
	import com.spice.clove.commandEvents.CloveAIREvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.models.CloveAIRModelLocator;
	import com.spice.clove.plugin.column.GroupColumn;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallAppMenuType;
	import com.spice.clove.plugin.core.calls.data.AddRootMenuItemData;
	import com.spice.clove.root.core.calls.CallRootPluginType;
	import com.spice.clove.view.window.SubmitBugWindow;
	import com.spice.events.QueueManagerEvent;
	import com.spice.utils.queue.cue.ICue;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import mx.core.Application;
	import mx.events.AIREvent;
	import mx.events.FlexEvent;
	
	public class InitPreferences extends EventDispatcher implements ICue, IInitializer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:CloveAIRModelLocator = CloveAIRModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		
		public function InitPreferences()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/*
		*/
		
		public function get completeMessage():String
		{
			return "loaded menu items";
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		public function init():void
		{
			
			var nativeMenu:* = NativeApplication.supportsMenu ? Application.application.nativeApplication : Application.application.nativeWindow;
			
			var isMac:Boolean = Capabilities.os.search("Mac") > -1;
			
			
			//command for Mac, control for any other opperating system
			var ctrlKey:int = isMac ? Keyboard.COMMAND : Keyboard.CONTROL;
			
			var appName:String = AirUtils.getApplicationName();
			
			
			
			var appMenuItem:NativeMenuItem = new NativeMenuItem(appName);
			appMenuItem.submenu = new NativeMenu();
			
			
			var checkUpdate:NativeMenuItem = new NativeMenuItem("Check for Updates...");
			checkUpdate.addEventListener(Event.SELECT,onCheckUpdate);
			
			
			//preferences
			var prefs:NativeMenuItem = new NativeMenuItem("Preferences");
			prefs.addEventListener(Event.SELECT,onPrefsSelect);
			prefs.enabled = true;
			prefs.keyEquivalentModifiers = [ctrlKey];
			prefs.keyEquivalent			 = ",";
			
			
			//close window
			//NOTE: this works, so why did I remove it??? Windows Issue?
			//			var hideWindow:NativeMenuItem = new NativeMenuItem("Hide "+appName);
			//			hideWindow.addEventListener(Event.SELECT,onHideWindow);
			//			hideWindow.keyEquivalentModifiers = [ctrlKey];
			//			hideWindow.keyEquivalent          = "h";
			
			//refresh
			var refreshItem:NativeMenuItem = new NativeMenuItem("Refresh");
			refreshItem.addEventListener(Event.SELECT,onRefreshServices);
			refreshItem.keyEquivalentModifiers = [ctrlKey];
			refreshItem.keyEquivalent          = "r";
			
			
			var quit:NativeMenuItem = new NativeMenuItem("Quit");
			quit.addEventListener(Event.SELECT,onQuit);
			quit.keyEquivalentModifiers = [ctrlKey];
			quit.keyEquivalent          = "q";
			
			
			//			appMenuItem.submenu.addItem(checkUpdate);
			//			appMenuItem.submenu.addItem(new NativeMenuItem("",true));
			//			appMenuItem.submenu.addItem(hideWindow);
			
			
			
			
			
			
			if(isMac)
			{
				var mnu:NativeMenu = nativeMenu.menu.getItemAt(0).submenu;//Application
				
				
				var aboutApp:NativeMenuItem = mnu.removeItemAt(0);
				var hideApp:NativeMenuItem = mnu.removeItemAt(1);
				var hideOthers:NativeMenuItem = mnu.removeItemAt(1);
				var showAll:NativeMenuItem = mnu.removeItemAt(1);
				
				appMenuItem.submenu.addItem(aboutApp);
				appMenuItem.submenu.addItem(checkUpdate);
				appMenuItem.submenu.addItem(new NativeMenuItem("",true));
				appMenuItem.submenu.addItem(prefs);
				appMenuItem.submenu.addItem(new NativeMenuItem("",true));
				appMenuItem.submenu.addItem(hideApp);
				appMenuItem.submenu.addItem(hideOthers);
				appMenuItem.submenu.addItem(showAll);
				
				
			}
			else
			{
				appMenuItem.submenu.addItem(checkUpdate);
				appMenuItem.submenu.addItem(new NativeMenuItem("",true));
				appMenuItem.submenu.addItem(prefs);
				appMenuItem.submenu.addItem(new NativeMenuItem("",true));
				appMenuItem.submenu.addItem(refreshItem);
			}
			
			
			appMenuItem.submenu.addItem(new NativeMenuItem("",true));
			appMenuItem.submenu.addItem(quit);
			
			
			var fileMenu:NativeMenuItem = new NativeMenuItem("File");
			fileMenu.submenu = new NativeMenu();
			
			//add group
			var addGroup:NativeMenuItem = new NativeMenuItem("New Group");
			addGroup.addEventListener(Event.SELECT,onAddGroupSelect);
			addGroup.keyEquivalentModifiers = [Keyboard.SHIFT,ctrlKey];
			addGroup.keyEquivalent = "G";
			
			//add column
			var addColumn:NativeMenuItem = new NativeMenuItem("New Column");
			addColumn.addEventListener(Event.SELECT,onAddColumnSelect);
			addColumn.keyEquivalentModifiers = [Keyboard.SHIFT,ctrlKey];
			addColumn.keyEquivalent = "N";
			
			
			
			
			//close window
			var closeWindow:NativeMenuItem = new NativeMenuItem("Close "+appName);
			closeWindow.addEventListener(Event.SELECT,onCloseWindow);
			closeWindow.keyEquivalentModifiers = [ctrlKey];
			closeWindow.keyEquivalent          = "w";
			
			
			
			with(fileMenu.submenu)
			{
				addItem(addGroup);
				addItem(addColumn);
				addItem(new NativeMenuItem("",true));
				addItem(closeWindow);
			}
			
			
			var windowMenu:NativeMenuItem = new NativeMenuItem("Window");
			windowMenu.submenu = new NativeMenu();
			
			var minimize:NativeMenuItem = new NativeMenuItem("Minimize");
			minimize.addEventListener(Event.SELECT,onMinimizeWindow);
			minimize.keyEquivalentModifiers = [ctrlKey];
			minimize.keyEquivalent = "m";
			
			windowMenu.submenu.addItem(minimize);
			
			
			var editMenu:NativeMenuItem = new NativeMenuItem("Edit");
			editMenu.submenu = new NativeMenu();
			//cut
			
			var cut:NativeMenuItem = new NativeMenuItem("Cut");
			cut.addEventListener(Event.SELECT,onCut);
			cut.keyEquivalentModifiers = [ctrlKey];
			cut.keyEquivalent          = "x";
			
			
			//copy
			var copy:NativeMenuItem = new NativeMenuItem("Copy");
			copy.addEventListener(Event.SELECT,onCopy);
			copy.keyEquivalentModifiers = [ctrlKey];
			copy.keyEquivalent          = "c";
			
			//paste
			var paste:NativeMenuItem = new NativeMenuItem("Paste");
			paste.addEventListener(Event.SELECT,onPaste);
			paste.keyEquivalentModifiers = [ctrlKey];
			paste.keyEquivalent          = "v";
			
			//select all
			var selectAll:NativeMenuItem = new NativeMenuItem("Select All");
			selectAll.addEventListener(Event.SELECT,onSelectAll);
			selectAll.keyEquivalentModifiers = [ctrlKey];
			selectAll.keyEquivalent          = "a";
			
			with(editMenu.submenu)
			{
				addItem(cut);
				addItem(copy);
				addItem(paste);
				addItem(selectAll);
			}
			//close target window
			
			
			
			var betaMenu:NativeMenuItem = new NativeMenuItem("Beta");
			betaMenu.submenu = new NativeMenu();
			
			//beta
			var subBug:NativeMenuItem = new NativeMenuItem("Submit Bug");
			subBug.addEventListener(Event.SELECT,onSubmitBug);
			
			var vsf:NativeMenuItem = new NativeMenuItem("View Support Forums");
			vsf.addEventListener(Event.SELECT,onViewSupportForums);
			
			var eu:NativeMenuItem = new NativeMenuItem("Email Us");
			eu.addEventListener(Event.SELECT,onEmailUs);
			//views
			
			var fresh:NativeMenuItem = new NativeMenuItem("Wipe Settings");
			fresh.addEventListener(Event.SELECT,onWipeSettings);
			
			betaMenu.submenu.addItem(fresh);
			
			ProxyCallUtils.quickCall(CallAppMenuType.REGISTER_APP_ROOT_MENU_ITEM,ClovePluginMediator.getInstance(),new AddRootMenuItemData("",appMenuItem));
			ProxyCallUtils.quickCall(CallAppMenuType.REGISTER_APP_ROOT_MENU_ITEM,ClovePluginMediator.getInstance(),new AddRootMenuItemData("",fileMenu));
			ProxyCallUtils.quickCall(CallAppMenuType.REGISTER_APP_ROOT_MENU_ITEM,ClovePluginMediator.getInstance(),new AddRootMenuItemData("",editMenu));
			ProxyCallUtils.quickCall(CallAppMenuType.REGISTER_APP_ROOT_MENU_ITEM,ClovePluginMediator.getInstance(),new AddRootMenuItemData("",windowMenu));
			ProxyCallUtils.quickCall(CallAppMenuType.REGISTER_APP_ROOT_MENU_ITEM,ClovePluginMediator.getInstance(),new AddRootMenuItemData("",betaMenu));
			
			if(Application.application.nativeWindow)
			{
				this.init2();
			}
			else
			{
				Application.application.addEventListener(FlexEvent.INITIALIZE,init2);
			}
			
			dispatchEvent(new QueueManagerEvent(QueueManagerEvent.CUE_COMPLETE));
		}
		
		
		private function init2(event:FlexEvent = null):void
		{
			if(event)
			{
				event.currentTarget.removeEventListener(event.type,init2);
			}
			
			ProxyCallUtils.quickCall(CallAppMenuType.APP_ROOT_MENU_INITIALIZE,ClovePluginMediator.getInstance());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		private function onPrefsSelect(event:Event):void
		{
			new CloveEvent(CloveEvent.OPEN_PREFERENCES).dispatch();
		}
		
		
		/*
		*/
		
		private function onAddColumnSelect(event:Event):void
		{
			new CloveEvent(CloveEvent.ADD_COLUMN).dispatch();
		}
		
		/*
		*/
		
		private function onAddGroupSelect(event:Event):void
		{
			new CloveEvent(CloveEvent.ADD_COLUMN,new GroupColumn()).dispatch();
		}
		
		
		/**
		 */
		
		private function onCut(event:Event):void
		{
			NativeApplication.nativeApplication.cut();
		}
		
		/**
		 */
		
		private function onCopy(event:Event):void
		{
			NativeApplication.nativeApplication.copy();
		}
		
		/**
		 */
		
		private function onPaste(event:Event):void
		{
			NativeApplication.nativeApplication.paste();
		}
		
		/**
		 */
		
		private function onSelectAll(event:Event):void
		{
			NativeApplication.nativeApplication.selectAll();
		}
		
		
		
		/*
		*/
		
		private function onCloseWindow(event:Event):void
		{
			
			
			
			//behaviour is a bit different accross opperating systems. Mac command W hides the window, whereas ctrl W on Windows
			//closes the window	
			
			var activeWin:NativeWindow = NativeApplication.nativeApplication.activeWindow;
			
			if(activeWin != Application.application.nativeWindow && activeWin)
			{
				activeWin.dispatchEvent(new Event(Event.CLOSING));
				
				activeWin.close();
			}
			else
			{
				//make sure that the window being closed isn't the main window, so we can re-open it
				onHideWindow(event);
			}
		}
		
		/**
		 */
		
		private function onMinimizeWindow(event:Event):void
		{
			NativeApplication.nativeApplication.activeWindow.minimize();
			
		}
		/*
		*/
		
		private function onHideWindow(event:Event):void
		{
			
			for each(var window:NativeWindow in NativeApplication.nativeApplication.openedWindows)
			{
				window.visible = false;
			}
			
			
			//listen for when the user selects the app, then make it visible again
			Application.application.addEventListener(AIREvent.APPLICATION_ACTIVATE,onShowMainWindow);
			//			NativeApplication.nativeApplication.addEventListener(Event.USER_PRESENT,onShowMainWindow);
			
		}
		
		/*
		*/
		
		private function onShowMainWindow(event:*):void
		{
			
			for each(var window:NativeWindow in NativeApplication.nativeApplication.openedWindows)
			{
				window.visible = true;
			}
		}
		
		
		/*
		*/
		
		private function onQuit(event:Event):void
		{
			
			NativeApplication.nativeApplication.dispatchEvent(new Event(Event.EXITING));
			NativeApplication.nativeApplication.dispatchEvent(new Event(Event.CLOSING));
			Application.application.nativeWindow.dispatchEvent(new Event(Event.CLOSING));
			  
			
		}
		
		
		
		/*
		*/
		
		private function onCheckUpdate(event:Event):void
		{
			new CloveEvent(CloveEvent.CHECK_UPDATE).dispatch();
		}
		
		/*
		*/
		
		private function onRefreshServices(event:Event):void
		{
			ProxyCallUtils.quickCall(CallRootPluginType.REFRESH_ALL_FEEDS,ClovePluginMediator.getInstance());
		}
		
		/*
		*/
		
		private function onSubmitBug(event:Event):void
		{
			//flash.net.navigateToURL(new URLRequest(_model.urlModel.bugSupportUrl));
			
			SubmitBugWindow.openWindow();
		}
		
		/*
		*/
		
		private function onViewSupportForums(event:Event):void
		{
			flash.net.navigateToURL(new URLRequest(_model.mainModel.urlModel.supportForumUrl));
		}
		
		/*
		*/
		
		public function onEmailUs(event:Event):void
		{
			
		}
		
		/*
		*/
		
		private function onWipeSettings(event:Event):void
		{
			new CloveAIREvent(CloveAIREvent.WIPE_SETTINGS).dispatch();
		}
		
	}
}