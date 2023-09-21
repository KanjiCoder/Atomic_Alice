package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import TheStatic;
	
	/**
	 * ...
	 * @author 
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
			
			loopThroughStaticClass();
			
		}
		
		private function loopThroughStaticClass():void
		{
			
			var someString:String = TheStatic["A"] ;
			trace(someString);
			
			var theClass:Class = TheStatic;
			var string2:String = theClass["B"];
			trace(string2);
		}
		
	}
	
}