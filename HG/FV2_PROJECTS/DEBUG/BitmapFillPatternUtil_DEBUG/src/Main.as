package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.graphics.BitmapFillPatternUtil;
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
			
			var bmDat:BitmapData = new BitmapData(300, 300, true, 0x00);
			var bmVis:Bitmap = new Bitmap(bmDat);
			this.addChild(bmVis);
			//BitmapFillPatternUtil.makeSimpleSquareGradient(bmDat,  0xFF0000FF, 0xFFFF0000, true);
			BitmapFillPatternUtil.makeRadialGradient(bmDat, 0xFFFF0000, 0xFF0000FF);
			
		}
		
	}
	
}