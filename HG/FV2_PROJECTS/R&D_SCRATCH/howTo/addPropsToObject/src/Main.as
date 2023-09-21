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
			var obj:Object = new Object();
			if ( obj.hasOwnProperty("COOKIE") ) { trace("this shouldn't happen"); }
			else { trace("GOOD!"); }
			
			obj["COOKIE"] = 7;
			
			if ( obj.hasOwnProperty("COOKIE") ) { trace("YES!!!"); }
			else { trace("NO NO NO"); }
			
			trace("meow");
		}
		
	}
	
}