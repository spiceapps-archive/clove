package
{
	import com.spice.patterns.proxy.AProxyCall;
	import com.spice.patterns.proxy.IAProxy;
	import com.spice.patterns.proxy.IAProxyCall;
	import com.spice.patterns.proxy.IAProxyController;
	import com.spice.concrete.patterns.proxy.IProxyResponseHandler;

	public class BindingTarget //implements IObs
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _proxy:DataBindingController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BindingTarget()
		{
			_target = new Target();
			_target.getBinder().addObserver(this);
						
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getBindingCall(name:String):IAProxyCall
		{
			
		}
		
		/**
		 */
		
		public function getBindedData(
		
		
	}
}