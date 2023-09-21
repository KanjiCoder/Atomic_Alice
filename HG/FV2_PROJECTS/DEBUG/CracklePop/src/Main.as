package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JMIM
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
			cracklePop();
		}
		
		/**
		  Write a program that prints out the numbers 1 to 100 (inclusive). 
		  If the number is divisible by 3, print Crackle instead of the number. 
		  If it's divisible by 5, print Pop. If it's divisible by both 3 and 5, 
		  print CracklePop. You can use any language. **/
		public function cracklePop():void
		{
			/** inclusive range start **/
			var startIndex:int = 1;
			/** inclusive range end **/
			var endIndex  :int = 100;
			/** output string for each iteration of loop. **/
			var outputLine:String;
			for (var i:int = startIndex; i <= endIndex; i++)
			{
				outputLine = "";
				outputLine = (0 == i % 3) ? outputLine + "Crackle" : outputLine;
				outputLine = (0 == i % 5) ? outputLine + "Pop"     : outputLine;
				if ("" == outputLine) { outputLine = i.toString(); }
				trace(outputLine);
			}
		}
		
	}//class	
}//package