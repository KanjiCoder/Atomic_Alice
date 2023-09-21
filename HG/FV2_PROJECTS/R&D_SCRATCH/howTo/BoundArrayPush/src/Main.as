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
			
			var arr:Array = new Array();
			var p:Function = arr.push;
			
			p("hello");
			p("whats up?");
			
			for each(var s:String in arr)
			{
				trace(s);
			}
			
		}
		
	}
	
}