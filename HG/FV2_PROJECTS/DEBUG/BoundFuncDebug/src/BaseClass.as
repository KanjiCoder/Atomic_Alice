package  
{
	/**
	 * ...
	 * @author JMIM
	 */
	public class BaseClass 
	{
		
		protected var _someNumber:int = 0;
		
		public function BaseClass() 
		{
			
		}
		
		public function bindThis():void
		{
			if (_someNumber == 0)
			{
				_someNumber = 77;
			}
			trace("_someNumber ==" + _someNumber);
		}
		
		public function callThis():void
		{
			if (_someNumber == 0)
			{
				_someNumber = 88;
			}
			trace("_someNumber ==" + _someNumber);
		}
		
	}

}