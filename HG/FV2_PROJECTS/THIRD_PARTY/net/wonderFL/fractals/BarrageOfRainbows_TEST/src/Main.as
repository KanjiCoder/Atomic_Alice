package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.wonderFL.fractals.barrageOfRainbows.BarrageOfRainbows;
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends BarrageOfRainbows 
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