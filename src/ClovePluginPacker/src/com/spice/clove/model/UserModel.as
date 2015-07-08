package com.spice.clove.model
{
	import com.spice.clove.vo.UserVO;
	import com.spice.utils.storage.SharedObjectSettings;
	import com.spice.utils.storage.persistent.SettingManager;
	
	
	[Bindable] 
	public class UserModel
	{
		
		[Setting]
		public var currentUser:UserVO;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function UserModel()
		{
			new SettingManager(new SharedObjectSettings('user'),this);
		}

	}
}