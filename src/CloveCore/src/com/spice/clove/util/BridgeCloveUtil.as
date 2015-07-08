package com.spice.clove.util
{
	import com.bridge.module.component.ComponentModule;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.ComponentClassDefinition;
	
	import flash.display.DisplayObject;
	
	/*
	  @Depricated 
	  @author craigcondon
	  
	 */	
	 
	public class BridgeCloveUtil
	{
		public static function setRoute(route:DisplayObject,name:String,node:BridgeNode):void
		{
			var comp:ComponentModule = node.nodeLibrary.getModule(ComponentModule)[0];
			comp.setRouterNode(name,new ComponentClassDefinition(route));
			
		}

	}
}