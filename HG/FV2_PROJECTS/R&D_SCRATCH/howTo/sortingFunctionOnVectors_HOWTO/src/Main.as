package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			sortTest();
		}
		
		public function sortTest():void
		{
			var num:Number;
			var vec:Vector.<int> = new Vector.<int>(0);
			for (var i:int = 0; i < 100; i++)
			{
				num = i * Math.random();
				vec[i] = int(num);
			}
			
			traceVector( vec );
			vec.sort( numSortFunction);
			traceVector( vec );
			
		}
		
		public function traceVector(inVec:Vector.<int>):void
		{
			trace("begin output:::");
			for (var i:int = 0; i < inVec.length; i++)
			{
				trace(inVec[i]);
			}
		}
		
		private static function numSortFunction(a:int, b:int):int
		{
			if (a < b ) { return -1; }
			if (a > b ) { return  1; }
			if (a == b) { return  0; }
			
			//for compiler error. Should never reach here.
			throw new Error("should never execute to this line");
			return 0;
		}//numSortFunction
		
	}//class
}//package