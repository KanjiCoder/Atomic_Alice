package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.argHack.AAHackel;
	
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
			
			var a:String = AAHackel.dpKey;
			var b:String = AAHackel.dpKey;
		}
		
	}//class
}//package