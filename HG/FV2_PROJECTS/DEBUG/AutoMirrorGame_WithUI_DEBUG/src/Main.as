package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.miniGames.autoMirror.AutoMirrorGameWithUI;
	import JM_LIB.miniGames.autoMirror.components.tileMapAMG.TileMapAMG_UI;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'AutoTileStrip.PNG')]private static var AUTO_TILE_STRIP:Class;
		[Embed(source = 'UICluster.PNG')]private static var UI_CLUSTER:Class;
		
		private var _miniGame:AutoMirrorGameWithUI;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			/*
			var autoTileStripBitmap:BitmapData = new AUTO_TILE_STRIP().bitmapData;
			_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, autoTileStripBitmap, false);
			*/
			
			
			var autoTileStripBitmap:BitmapData = new UI_CLUSTER().bitmapData;
			_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, autoTileStripBitmap, true);
			var ui:TileMapAMG_UI = _miniGame.getUI();
			ui.setToUsePointBrush();
			
			this.addChild(_miniGame);
			
		}
		
	}//class
}//package