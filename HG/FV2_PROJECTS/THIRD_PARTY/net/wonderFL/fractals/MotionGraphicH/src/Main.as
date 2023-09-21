package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.wonderFL.fractals.motionGraphicH.MotionGraphicH;
	
	// Source: http://wonderfl.net/c/4w1m
	//Cant get this one to work.
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends MotionGraphicH 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:MouseEvent):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}