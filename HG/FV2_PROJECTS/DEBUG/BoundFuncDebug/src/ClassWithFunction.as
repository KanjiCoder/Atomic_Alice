package  
{
	/**
	 * ...
	 * @author JMIM
	 */

	public class ClassWithFunction extends BaseClass
	{
		public function ClassWithFunction() { };
		
		override public function bindThis():void
		{
			if (_someNumber == 0)
			{
				_someNumber = 77;
			}
			trace("_someNumber ==" + _someNumber);
		}
		
		override public function callThis():void
		{
			if (_someNumber == 0)
			{
				_someNumber = 88;
			}
			trace("_someNumber ==" + _someNumber);
		}

		
	}//class
}//package