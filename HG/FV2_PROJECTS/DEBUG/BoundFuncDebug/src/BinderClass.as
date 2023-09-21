package  
{
	import ClassWithFunction;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class BinderClass 
	{
		private var _boundFunction:Function; //A variable with type "function". Think of it like a function pointer in C++.
		
		public function BinderClass(inClassWithFunction:ClassWithFunction) 
		{
			_boundFunction = inClassWithFunction.bindThis;
		}
		
		public function callBoundFunction():void
		{
			_boundFunction();
		}
		
	}

}