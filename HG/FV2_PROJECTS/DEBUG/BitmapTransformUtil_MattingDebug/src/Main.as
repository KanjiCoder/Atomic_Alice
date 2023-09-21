package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.graphics.color.bitmapColorStatsUtil.BMColorStats;
	import JM_LIB.graphics.utils.BitmapTransformUtil;
	import JM_LIB.graphics.color.bitmapColorStatsUtil.BitmapColorStatsUtil;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'SolidBLACKLightOnAlpha.PNG')] private static var BLACK :Class;
		[Embed(source = 'SolidWhiteLightOnAlpha.PNG')] private static var WHITE :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			doTest();
		}
		
		private function doTest():void
		{
			var b:BitmapData = (new BLACK().bitmapData);
			var w:BitmapData = (new WHITE().bitmapData);
			var s:Number = 8;
			var bVIS:Bitmap = new Bitmap(b);
			var wVIS:Bitmap = new Bitmap(w);
			this.addChild(bVIS);
			this.addChild(wVIS);
			bVIS.scaleX = s; bVIS.scaleY = s;
			wVIS.scaleX = s; wVIS.scaleY = s;
			wVIS.x = (bVIS.width);
			
			var cBLACK:uint = 0xFF000000;
			var cWHITE:uint = 0xFFFFFFFF;
			//BitmapTransformUtil.addBGColorToBitmapWithAlphaBackground(b, cWHITE);
			//BitmapTransformUtil.addBGColorToBitmapWithAlphaBackground(w, cWHITE);
			
			//BitmapColorStatsUtil.collectStats(w);
			//var bmStats:BMColorStats = BitmapColorStatsUtil.results;
			
			var isAllSolidBlack_B:Boolean = BitmapColorStatsUtil.detectSolidColor(b, 0xFF000000);
			var isAllSolidWhite_B:Boolean = BitmapColorStatsUtil.detectSolidColor(b, 0xFFFFFFFF);
			
			var isAllSolidBlack_W:Boolean = BitmapColorStatsUtil.detectSolidColor(w, 0xFF000000);
			var isAllSolidWhite_W:Boolean = BitmapColorStatsUtil.detectSolidColor(w, 0xFFFFFFFF);
			
			trace("mewo");
		}
		
	}//class
}//package