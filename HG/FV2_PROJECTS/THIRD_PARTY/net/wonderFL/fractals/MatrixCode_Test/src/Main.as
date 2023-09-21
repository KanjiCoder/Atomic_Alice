package 
{
	import net.wonderFL.fractals.matrixCode.MatrixCode;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//http://wonderfl.net/c/3UMP/read
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends MatrixCode 
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