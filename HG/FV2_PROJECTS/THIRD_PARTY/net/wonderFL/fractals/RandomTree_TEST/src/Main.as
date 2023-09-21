package 
{
	
	//Source: http://wonderfl.net/c/zVL2
	
	import flash.display.Sprite;
	import flash.events.Event;
	import net.wonderFL.fractals.randomTree.RandomTree;
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends RandomTree 
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