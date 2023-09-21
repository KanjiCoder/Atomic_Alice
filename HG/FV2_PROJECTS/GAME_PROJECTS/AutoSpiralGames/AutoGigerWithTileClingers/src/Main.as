package 
{
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import JM_LIB.miniGames.autoMirror.AutoMirrorGameWithUI;
	import JM_LIB.miniGames.autoMirror.components.tileMapAMG.TileMapAMG_TOOL;
	
	import JM_LIB.geom.tileMap.polyTileClinger.helpers.updater.PTClingerUpdater;
	import JM_LIB.geom.tileMap.polyTileClinger.PolyTileClinger;
	
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
		
		/** The object that updates the position of PolyTileClinger objects. **/
		private var _pUpdater:PTClingerUpdater;
		
		/** The buffer we draw the clingers to. **/
		private var _buffer:BitmapData;
		/** The visible bitmap that we use so we can see the buffer. **/
		private var _buffer_VIS:Bitmap;
		
		private var _filter:BlurFilter = new BlurFilter(7, 7, 1);
		private var zz:Point = new Point(0, 0);
		
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
			_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, autoTileStripBitmap);
			//_miniGame.setLogoText("BAUXITE TEST");
			this.addChild(_miniGame);
			
			_tool = _miniGame.getTool();
			_tool.pushTileMapPack( new PACK_01().bitmapData, "PACK_01" );
			_tool.setSlideShowModeOnOff(false);
			
			_pUpdater = new PTClingerUpdater();
			_pUpdater.init(16, 16, 30, 30, _tool.getTile, "_tool.getTile");
			_pUpdater.setAutoTileSet(1, PTClingerUpdater.AUTO_ANGLES); //Set autotile set #1 to be AUTO_ANGLES.
			
			//Use this function to get testing right away:
			//_pUpdater.addNewClingerOnEveryTile();
			
			_pUpdater.addNewClingerOnEveryTile_usingSudoRandomSpeedArray([ -0.06, 0.06]);
			
			_buffer = new BitmapData(16 * 32, 16 * 32, true, 0x00);
			_buffer_VIS = new Bitmap( _buffer );
			this.addChild(_buffer_VIS);
			
			this.addEventListener(Event.ENTER_FRAME, updateLoop);
			
		}
		
		private function updateLoop(evt:Event):void
		{
			_pUpdater.update();
			_buffer.applyFilter(_buffer, _buffer.rect, zz, _filter);
			//_buffer.fillRect(_buffer.rect, 0x01);
			_pUpdater.debugDraw(_buffer);
			
		}
		
	}//class
}//package