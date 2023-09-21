package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.bitWise.EnumsToUintPacker;
	
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
			
			var out:uint = EnumsToUintPacker.packEnumsIntoUint([1, 2, 3, 4, 5, 11, 12, 13, 14, 15, 21, 22, 23, 24, 25, 31, 32]);
			out = EnumsToUintPacker.packEnumsIntoUint([1, 32]);
			trace("out==" + out.toString(2));
		}
		
	}
	
}