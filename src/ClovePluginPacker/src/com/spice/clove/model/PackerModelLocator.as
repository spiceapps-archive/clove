package com.spice.clove.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	
	
	[Bindable] 
	public class PackerModelLocator implements IModelLocator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private static var _model:PackerModelLocator;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PackerModelLocator()
		{
			if(_model)
			{
				throw new Error("only one instance of PackerModelLocator can be instantiated");
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function getInstance():PackerModelLocator
		{
			if(!_model)
			{
				_model = new PackerModelLocator();
			}
			
			return _model;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var initModel:InitModel = new InitModel();
        
        
        public var packModel:PackModel = new PackModel();
        
        public var viewModel:ViewModel = new ViewModel();
        
        
        public var swcInfoModel:SWCInfoModel = new SWCInfoModel();
        
        
        public var configModel:ConfigModel = new ConfigModel();
        
        public var userModel:UserModel = new UserModel();

		public var plugin:PluginListModel = new PluginListModel();
	}
}