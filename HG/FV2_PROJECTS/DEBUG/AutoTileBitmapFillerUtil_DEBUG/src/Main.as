package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import JM_LIB.graphics.utils.tileMapFiller.AutoTileBitmapFillerUtil;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.graphics.utils.tileMapFiller.AutoTileStripPOD;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		[Embed(source = 'AUTO_STRIP.png')]private static var AUTO_STRIP:Class;
		[Embed(source = 'UI_CLUSTER.png')]private static var UI_CLUSTER:Class;
		
		private var _strip:BitmapData
		private var _clust:BitmapData;
		
		private var _auto_strip:AutoTileStripPOD;
		private var _auto_clust:AutoTileStripPOD;
		
		private var _bm:BitmapData;
		private var _bm_DISP:Bitmap;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_strip = new AUTO_STRIP().bitmapData;
			_clust = new UI_CLUSTER().bitmapData;
			
			_auto_strip = AutoTileStripPOD.easyMake(_strip, "MEOW");
			_auto_clust = AutoTileStripPOD.easyMake(_clust, "RAWR");
			
			_bm = new BitmapData(100, 100, true, 0x00);
			//AutoTileBitmapFillerUtil.setAnonymousStripData(_auto_clust);
			AutoTileBitmapFillerUtil.setAnonymousStripData(_auto_strip);
			AutoTileBitmapFillerUtil.fillBitmap(_bm, 0);
			
			_bm_DISP = new Bitmap( _bm);
			this.addChild( _bm_DISP);
			
		}
		
	}//class
}//package