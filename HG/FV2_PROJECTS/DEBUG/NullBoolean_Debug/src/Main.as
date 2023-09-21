package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JMim
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
			
			var b:Boolean = null;
			if (b == null)
			{
				trace("b == null");
			}
			
			if (b == false)
			{
				trace("b == false");
			}
			
			if (b == true)
			{
				trace("b == true");
			}
		}
		
	}
	
}