package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import JM_LIB.toolSystems.superAutoTileMaker.MetaTileGrid;
	import JM_LIB.toolSystems.superAutoTileMaker.TileCoordinateMapperUtil;
	import JM_LIB.toolSystems.superAutoTileMaker.MetaTileFactory;
	import JM_LIB.toolSystems.superAutoTileMaker.TileMapEmulator;
	
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
			
			//make default texture:
			var tcmu:TileCoordinateMapperUtil = new TileCoordinateMapperUtil(256, 16);
			//var tcmu:TileCoordinateMapperUtil = new TileCoordinateMapperUtil(16, 8);
			
			var bmData:BitmapData = new BitmapData(tcmu.bitmapDiameterInPixels, tcmu.bitmapDiameterInPixels, true, 0xFF00FF00);
			tcmu.debugDraw_showAllBitPatterns(bmData);
			

			
			//tile map emulator test;
			var tme:TileMapEmulator = new TileMapEmulator(24,24, tcmu.getTileDiameter(), tcmu.getTileDiameter() );
			tme.y = bmData.height + 1;
			this.addChild(tme);
			tme.loadTileSheetBitmap(bmData, 16, 16);
			
		}
		
	}
	
}