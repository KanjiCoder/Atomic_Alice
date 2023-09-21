package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.toolSystems.levelEditor.tileMapLE.renderModel.TMapLE_RenderModel;
	
	import JM_LIB.toolSystems.levelEditor.tileMapLE.TMapLevelEditor;
	import JM_LIB.toolSystems.levelEditor.tileMapLE.TMLE_AutoTileMethods;
	
	import JM_LIB.toolSystems.levelEditor.tileMapLE.util.TMLE_StripDataMaker;
	
	import net.hires.debug.Stats;
	
	import JM_EXT.org.flixel.utils.pngLevelMapUtils.PNGColorMapNoAlpha;
	import JM_EXT.com.adobe.utils.BitmapSaverUtil;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		 [Embed(source = "3_4_14_steel_beams.png")] private static var BMClass:Class;
		 [Embed(source = "ConcreteTiles.png")] private static var CONCRETE_BLOCKS:Class;
		 
		 /** A sheet full of auto-tiling blocks! **/
		 [Embed(source = "auto_tiles.png")] private static var AUTO_BLOCK_SHEET:Class;
		 
		 [Embed(source = "auto_angles.png")] private static var AUTO_ANGLE_SHEET:Class;
		 
		 [Embed(source = "auto_plats.png")] private static var AUTO_PLATS_SHEET:Class;
		 
		 [Embed(source = "editor_icon_tiles.png")] private static var ICON_SHEET:Class;
		 
		 
		
	    public var editor:TMapLevelEditor;
		public var stripDataMaker:TMLE_StripDataMaker = new TMLE_StripDataMaker();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			initTheStuff();
			
			this.addChild( new Stats() );
		}
		
		public function initTheStuff():void
		{
			var gameWidth:int = 30;
			var gameHeight:int = 30;
			var inAutoTileStripData:BitmapData = new BMClass().bitmapData;
			
			editor = new TMapLevelEditor(640, 480, this.stage);
			
			//editor.setAutoTileStrip(inAutoTileStripData, 1, 0, TMLE_AutoTileMethods.STANDARD_AUTO);
			//editor.setAutoTileStrip(new CONCRETE_BLOCKS().bitmapData, 2, 0, TMLE_AutoTileMethods.STANDARD_AUTO);
			
			//editor.setAutoTileStrip(new CONCRETE_BLOCKS().bitmapData, 1, 0, TMLE_AutoTileMethods.STANDARD_AUTO);
			//editor.setAutoTileStrip(inAutoTileStripData, 2, 0, TMLE_AutoTileMethods.STANDARD_AUTO);
			
			var blocks:BitmapData = new AUTO_BLOCK_SHEET().bitmapData;
			var angles:BitmapData = new AUTO_ANGLE_SHEET().bitmapData;
			var plats :BitmapData = new AUTO_PLATS_SHEET().bitmapData;
			var icons :BitmapData = new ICON_SHEET().bitmapData;
			//var icons :BitmapData = new ICON_SHEET().bitmapData;
			
			//editor.loadAutoTileStripSheet(blocks, 0, TMLE_AutoTileMethods.ICON_AUTO);
			//editor.loadAutoTileStripSheet(angles, 1, TMLE_AutoTileMethods.STANDARD_AUTO);
			//editor.loadAutoTileStripSheet(plats , 2, TMLE_AutoTileMethods.PLATFORM_AUTO);
			
			
			//load up object that will handle dissecting the strips for you:
			var BLOCK_state:int = 0;
			var ANGLE_state:int = 1;
			var PLATF_state:int = 2;
			var ICONS_state:int = 3;
			stripDataMaker.loadStripSheet(blocks, BLOCK_state, TMLE_AutoTileMethods.STANDARD_AUTO);
			stripDataMaker.loadStripSheet(angles, ANGLE_state, TMLE_AutoTileMethods.STANDARD_AUTO);
			stripDataMaker.loadStripSheet(plats , PLATF_state, TMLE_AutoTileMethods.PLATFORM_AUTO);
			stripDataMaker.loadStripSheet(icons , ICONS_state, TMLE_AutoTileMethods.ICON_AUTO);
			
			//stripDataMaker.configureStripSettings(0 , BLOCK_state, BLOCK_state); //empty space block.
			
			
			stripDataMaker.configureStripSettings(1 , ANGLE_state, ANGLE_state);
			stripDataMaker.configureStripSettings(2 , ANGLE_state, BLOCK_state);
			stripDataMaker.configureStripSettings(3 , ANGLE_state, ANGLE_state);
			stripDataMaker.configureStripSettings(4 , ANGLE_state, ANGLE_state);
			stripDataMaker.configureStripSettings(5 , ANGLE_state, BLOCK_state);
			stripDataMaker.configureStripSettings(6 , ANGLE_state, BLOCK_state);
			stripDataMaker.configureStripSettings(7 , ANGLE_state, ANGLE_state);
			stripDataMaker.configureStripSettings(8 , ANGLE_state, ANGLE_state);
			stripDataMaker.configureStripSettings(9 , ANGLE_state, ANGLE_state);
			stripDataMaker.configureStripSettings(10, ANGLE_state, ANGLE_state);
			
			/*
			stripDataMaker.configureStripSettings(11, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(12, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(13, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(14, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(15, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(16, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(17 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(18 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(19 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(20 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(21 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(22 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(23 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(24 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(25 , BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(26, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(27, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(28, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(29, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(30, BLOCK_state, PLATF_state);
			stripDataMaker.configureStripSettings(31, BLOCK_state, PLATF_state);
			*/
			
			var renderModel:TMapLE_RenderModel = editor.getRenderModel();
			stripDataMaker.loadDataIntoRenderModel( renderModel, 16);
			
			
			//editor.loadAutoTileStripSheet(blockTileBM, 1, );
			//editor.loadAutoTileStripSheet(angleTileBM, 2);
			//editor.loadAutoTileStripSheet(platfTileBM, 3, 2);
		
			this.addChild(editor);
			
			var template:BitmapData = PNGColorMapNoAlpha.getAutoTileTemplate(16, 16, 16);
			var bmSaver:BitmapSaverUtil = new BitmapSaverUtil();
			bmSaver.useWatermark = false;
			bmSaver.openDialogForBitmapSave( template);
		}
		
	}//class	
}//package