package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
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
		
		public static function doStuff():void
		{
			var myDate:Date = new Date();
			var ms:int = myDate.getMilliseconds();
			trace(ms);
		}
		
	}//class
}//package