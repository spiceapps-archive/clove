package com.spice.clove.commands
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.air.utils.AirUtils;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.utils.StringUtil;
	
	public class CheckUpdateCommand implements ICommand
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private static var _updater:ApplicationUpdaterUI;
		
		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		private var _url:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		
		public function CheckUpdateCommand()
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
			_url = ProxyCallUtils.getFirstResponse(CallAppCommandType.GET_UPDATE_URL,ClovePluginMediator.getInstance());
			
//			_url = "http://architectd.com/Spice/index.php/brand/app/update/Clove.xml";
			if(!_url || _url == "//?#CLOVE_UPDATE_URL")
				return;
			
			//new ProxyCall(CallClovePluginType.CHECK_FOR_UPDATESd, ClovePluginMediator.getInstance()).dispatch(); 
			
			
			////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//note: we load the XML file with the version FIRST, before initialzing the 
			//ApplicationUpdaterUI because it's VERY slow.
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			
			var loader:URLLoader = new URLLoader(new URLRequest(_url));
			loader.addEventListener(Event.COMPLETE,onUpdateLoad);
			
			
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		  
		private function onUpdateLoad(event:Event):void
		{
			try
			{
				var ex:XML = new XML(event.target.data);
				 namespace items = "http://ns.adobe.com/air/framework/update/description/1.0";
				use namespace items;
				
				if(StringUtil.trim(ex.version) != StringUtil.trim(AirUtils.getApplicationVersion()))
				{
					Logger.log("New version ready! old="+AirUtils.getApplicationVersion()+" new="+ex.version,this);
					this.init();
				}
			}catch(e:Error)
			{
				Logger.logError(e);
			}
		}
		
		/**
		 */
		
		private function init():void
		{
			if(!_updater)
			{
				_updater = new ApplicationUpdaterUI();
				_updater.updateURL = this._url;
				
				_updater.addEventListener(UpdateEvent.INITIALIZED,onUpdate);
				_updater.addEventListener(ErrorEvent.ERROR,onError);
				_updater.isCheckForUpdateVisible = false;
				_updater.initialize();//so fucking slow >.>
				return;
			}
			_updater.checkNow();	
		}
		/*
		*/
		
		private function onUpdate(event:UpdateEvent):void
		{
			
			event.target.removeEventListener(event.type,onUpdate);
			
			_updater.checkNow();	
		}
		
		/*
		*/
		
		private function onError(event:ErrorEvent):void
		{
			event.target.removeEventListener(event.type,onError);
			
			//			Alert.show(event.toString());
		}
		
	}
}