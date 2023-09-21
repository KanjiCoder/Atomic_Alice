package 
{
	import net.wonderFL.fractals.viralSpiralGraph.ViralSpiralGraph;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends ViralSpiralGraph 
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