package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.encoding.base32.PNGTileMapValueEncoder.PNGTileMapValueEncoderUtil;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		[Embed(source = "AB_TEST.png")]public static var AB_TEST:Class;
		[Embed(source="AB_TEST2.png")]public static var AB_TEST2:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var bm:BitmapData = new AB_TEST2().bitmapData;
			var encodedText:String = PNGTileMapValueEncoderUtil.encodeBitmap(bm, true);
			trace("hi");
		}
		
	}
	
}