package 
{
	import net.wonderFL.fractals.wormFlower.WormFlower;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//http://wonderfl.net/c/xxH1
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends WormFlower 
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
		}
		
	}
	
}