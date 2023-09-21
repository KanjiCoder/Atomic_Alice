package 
{
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.miniGames.autoMirror.AutoMirrorGameWithUI;
	import JM_LIB.miniGames.autoMirror.components.tileMapAMG.TileMapAMG_TOOL;
	
	
	
	/**
	 * AUTO-GIGER STRIP GAME
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'AutoGigerTileSet.PNG')]private static var AUTO_TILE_STRIP:Class;
		[Embed(source = 'Pack01.PNG')]private static var PACK_01:Class;
		[Embed(source = 'Pack02.PNG')]private static var PACK_02:Class;
		[Embed(source = 'Pack03.PNG')]private static var PACK_03:Class;
		
		private var _miniGame:AutoMirrorGameWithUI;
		private var _tool:TileMapAMG_TOOL;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var autoTileStripBitmap:BitmapData = new AUTO_TILE_STRIP().bitmapData;
			//_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, autoTileStripBitmap);
			_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, autoTileStripBitmap, false);
			//_miniGame.setLogoText("BAUXITE TEST");
			this.addChild(_miniGame);
			
			_tool = _miniGame.getTool();
			_tool.pushTileMapPack( new PACK_01().bitmapData, "PACK_01" );
			_tool.setSlideShowModeOnOff(true);
			
		}
		
	}//class
}//package