package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.graphics.tileMakers.GradientAutoTileSetMaker;
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
			var bmDat:BitmapData;
			var bmVis:Bitmap;
			bmDat = GradientAutoTileSetMaker.makeAutoTileStrip_SQUAREGRADIENT(16, 16, 0xFFFF0000, 0xFF000000);
			bmVis = new Bitmap(bmDat);
			this.addChild(bmVis);
		}
		
	}
	
}