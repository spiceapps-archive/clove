package com.spice.monkeyPatch.menu
{
	import flash.display.NativeMenuItem;
	
	public class MenuItem extends NativeMenuItem
	{
		public function MenuItem(label:String = "",isSep:Boolean = false)
		{
			
			super(label,isSep);
		}
	}
}