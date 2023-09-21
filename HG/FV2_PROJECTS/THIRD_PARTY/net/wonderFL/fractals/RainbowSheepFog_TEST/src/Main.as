package 
{
	//Can't get this one to work.
	//Source::   http://wonderfl.net/c/qR3J
	
	
	import net.wonderFL.fractals.rainbowSheepFog.RainbowSheepFog;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends RainbowSheepFog 
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
		
	}//class
}//package