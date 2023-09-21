package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.describeType;
	
	import mx.core.ByteArrayAsset;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'JSON_FILE.json', mimeType='application/octet-stream')]private static const JSON_FILE:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var j:ByteArrayAsset = new JSON_FILE();
			var x:XML = describeType(j);
			
			//var baa:ByteArrayAsset = new ByteArrayAsset();
			//baa.readBytes;
			
			trace("What do we have?");
			
			
		}
		
	}
	
}