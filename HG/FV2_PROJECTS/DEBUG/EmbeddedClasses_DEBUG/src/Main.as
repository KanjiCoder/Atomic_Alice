package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.utils.describeType;
	import XML;
	
	import mx.core.BitmapAsset;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'TEST.PNG')]private static var TEST :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var instance:Object = new TEST();
			var x:XML = describeType(instance);
			
			trace("hello");
			
			var bm:BitmapData = new BitmapData(40, 40, true, 0x00);
		
			
		}
		
	}
	
}