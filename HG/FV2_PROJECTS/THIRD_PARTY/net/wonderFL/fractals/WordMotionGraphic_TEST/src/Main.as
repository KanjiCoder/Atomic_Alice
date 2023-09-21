package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.wonderFL.fractals.wordMotionGraphic.WordMotionGraphic;
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends WordMotionGraphic 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}