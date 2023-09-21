package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import de.polygonal.math.PM_PRNG;
	
	/**
	 * ...
	 * @author JMIM
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
			
			doStuff();
			
		}
		
		private function doStuff():void
		{
			var rGen:PM_PRNG = new PM_PRNG();
			rGen.seed = 345;
			
			var num:int;
			for (var i:int = 0; i < 100; i++)
			{
				num = rGen.nextInt();
				trace(num);
			}
		}
		
	}//class
}//package