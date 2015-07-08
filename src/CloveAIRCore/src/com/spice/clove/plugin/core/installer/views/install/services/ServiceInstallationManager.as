package com.spice.clove.plugin.core.installer.views.install.services
{
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallClovePluginControllerType;
	import com.spice.clove.plugin.install.AvailableExternalService;
	import com.spice.clove.plugin.install.AvailableInternalService;
	import com.spice.clove.plugin.install.IAvailableService;
	import com.spice.core.calls.CallQueueType;
	import com.spice.impl.queue.Queue;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	public class ServiceInstallationManager extends EventDispatcher implements IProxyBinding
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable] 
		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		private var _a:AvailableInternalService,_b:AvailableExternalService;
		
		
		
		private static var _avail:ArrayCollection;
		
		
		private var _installQueue:Queue;
		private var _initialized:Boolean;
		private var _availablePlugins:ArrayCollection;
		
		
						
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ServiceInstallationManager()
		{
			
			
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public function init(availablePlugins:ArrayCollection):void
        {
        	
        	if(this._initialized)
        	{
        		throw new Error("ServiceInstallationManager has already been initialized");
        	}
        	
        	this._initialized = true;
			
			this._availablePlugins = availablePlugins;
			
			
			//some items need to load bytes in order to grab the service installer
			/*var initQueue:Queue = new Queue();
			
			
			for each(var plug:IAvailableService in this._availablePlugins)
			{
				initQueue.addCue(plug);
			}*/
			
			this.dispatchEvent(new Event("availablePluginsChange"));
			
        }
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		
		/*
		 */
		
		[Bindable(event="availablePluginsChange")]
		public function get availableVisiblePlugins():ArrayCollection
		{
			var list:Function = function(inst:IAvailableService):Boolean{ return inst.visible; };
			
			var stack:Array = this.filter(list);
			
			return new ArrayCollection(stack);	
		}
		
		/*
		 */
		
		public function get selectedPlugins():ArrayCollection
		{
			var list:Function = function(inst:IAvailableService):Boolean{ return inst.selected && inst.visible; };
			
			var stack:Array = this.filter(list);
			
			return new ArrayCollection(stack);	
		}
		
        /*
		 */
		
		public function install():void
		{
			_installQueue = new Queue();
			
			new ProxyBind(_installQueue.getProxy(),this,[CallQueueType.QUEUE_COMPLETE],true);
			
			
			
			for each(var service:IAvailableService in this._availablePlugins)
			{
				
				if(ProxyCallUtils.getFirstResponse(CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_PLUGIN_FACTORY_CLASS,ClovePluginMediator.getInstance(),Object(service.factory).constructor))
					continue;
				
				//if the service is optional, and not selected then continue
				if(!service.selected)
					continue;		
				
				
				_installQueue.addCue(new InstallPluginCue(service));
			}
			
			
			//if there are items to install, start the queue manager, otherwise end the process
			if(_installQueue.getLength() > 0)
			{
				_installQueue.start();
			}
			else
			{	
				this.onQueueComplete();
			}
		}
		
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallQueueType.QUEUE_COMPLETE: return onQueueComplete();
			}
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function filter(callback:Function):Array
		{
			var stack:Array = [];
			
			for each(var installer:IAvailableService in this._availablePlugins)
			{
				if(callback(installer))
				{
					stack.push(installer);
				}
			}
			
			return stack;
		}
		
		/*
		 */
		
		private function onPluginsChange(event:CollectionEvent):void
		{
			this.dispatchEvent(new Event("availablePluginsChange"));
		}
		
		/*
		 */
		
		private function onQueueComplete():void
		{
			
			//notify on 100% complete
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
	}
}