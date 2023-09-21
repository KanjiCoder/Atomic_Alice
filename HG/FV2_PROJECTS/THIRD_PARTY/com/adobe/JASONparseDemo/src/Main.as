package 
{
	import com.adobe.serialization.json.JSON;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		[Embed(source = 'PixelKey.json', mimeType="application/octet-stream")]private static var PIXELKEY :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			trace("TESTING 123");
			var pixKey:Object = JSON.decode( new PIXELKEY(), true );
			
			for(var prop:String in pixKey)
			{
				trace(prop);
			}
		}
		
	}
	
}