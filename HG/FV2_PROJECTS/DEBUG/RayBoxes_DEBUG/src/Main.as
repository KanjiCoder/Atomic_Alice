package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.graphics.bitmapParser.rayBox.BitmapParser_RayBoxes;
	import JM_LIB.graphics.bitmapParser.rayBox.TMRayBox;
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'PNGMAP00.png')]private static var PNGMAP00 :Class;
		[Embed(source = '2X2.png')]private static var PNG_2X2 :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//var bm:BitmapData = new PNG_2X2().bitmapData;
			var bm:BitmapData = new PNGMAP00().bitmapData;
			
			var rbv:Vector.<TMRayBox> = BitmapParser_RayBoxes.getRayBoxes( bm );
			BitmapParser_RayBoxes.debug_drawRayBoxes(bm, rbv);
			
			var bmVis:Bitmap = new Bitmap( bm );
			bmVis.scaleX = 4;
			bmVis.scaleY = 4;
			this.addChild(bmVis);
			
			trace("hello WTF my window?");
		}
		
	}
	
}