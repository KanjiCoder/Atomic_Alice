package 
{
	import net.wonderFL.fractals.creepyCellText.CreepyCellText;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends CreepyCellText 
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