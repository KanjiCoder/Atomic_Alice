package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.plainOldData.ButtonStyleData;
	import JM_LIB.plainOldData.StringInt;
	import JM_LIB.toolSystems.levelEditor.leMap.ui.LeMapUI;
	
	import JM_LIB.toolSystems.levelEditor.leMap.components.tileMapCore.LeMapCore;
	import JM_LIB.toolSystems.levelEditor.leMap.LeMap;
	import JM_LIB.toolSystems.levelEditor.tileMapLE.TMLE_AutoTileMethods;
	import JM_LIB.toolSystems.levelEditor.leMap.helpers.LeMapAndUI;
	import JM_LIB.toolSystems.levelEditor.leMap.LeMapFactory;
	
	//import JM_LIB.toolSystems.directoryPNGLoader.BitmapWithNameString;
	import JM_LIB.plainOldData.NamePathIndexBM;
	
	//import GameSpecificRegistries.Bomber01.FontReg;
	import GameSpecificRegistries.Bomber01.FontReg;
	
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		//[Embed(source = 'AutoGigerTileSet.PNG')]private static var AUTO_TILE_STRIP:Class;
		
		[Embed(source = "auto_angles.png")]private static var AUTO_ANGLES:Class;
		[Embed(source = "auto_plats.png")]private static var AUTO_PLATS:Class;
		[Embed(source = "auto_tiles.png")]private static var AUTO_BLOCKS:Class;
		
		private var _leMap:LeMap;
		private var _ui:LeMapUI;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//_leMap = new LeMap(30, 30, 16, 16);
			var mapAndUI:LeMapAndUI;
			var btnStyleData:ButtonStyleData = new ButtonStyleData();
			btnStyleData.fontData = FontReg.BLOCKFONT;
			mapAndUI = LeMapFactory.makeLeMapWithUI(30, 30, 16, 16, 160, 480, btnStyleData);
			_leMap = mapAndUI.map;
			_ui    = mapAndUI.ui;
			
			//_leMap.linkToUI(_ui);
			
			
			_leMap.tCore.setAutoStripSheet( new AUTO_ANGLES().bitmapData, TMLE_AutoTileMethods.STANDARD_AUTO, "ANGLES");
			_leMap.tCore.setAutoStripSheet( new AUTO_PLATS().bitmapData , TMLE_AutoTileMethods.PLATFORM_AUTO, "PLATS");
			_leMap.tCore.setAutoStripSheet( new AUTO_BLOCKS().bitmapData, TMLE_AutoTileMethods.STANDARD_AUTO, "BLOCKS");
			
			
			
			var f:Function = _leMap.tCore.setDefaultStateOfAutoTileSet;
			
			//the white marker that can be used to spawn player:
			//f(1, "ANGLES", "SpecialMarker");
			//f(0, "N/A", "Empty Space"); //create empty space tile Hmm... not quite the way to do this.
			
			f(2, "BLOCKS", "PlatRock");
			f(3, "ANGLES", "Bauxite");
			f(4, "ANGLES", "Giger");
			f(5, "BLOCKS", "Firon");
			f(6, "BLOCKS", "Dirt");
			f(7, "PLATS", "PermaPlat");
			
			//the reg-rec markers:
			//f(8, "BLOCKS", "regRec_TopLeft");
			//f(9, "BLOCKS", "regRec_BotRight");
			
			f(10, "BLOCKS", "K-Bomb");
			f(11, "BLOCKS", "PlataRay");
			f(12, "BLOCKS", "H-Bomb");
			f(13, "BLOCKS", "V-Bomb");
			f(14, "BLOCKS", "F-Bomb");
			f(15, "BLOCKS", "ExtaRay");
			
			//the 4 special greys:
			//f(16, "BLOCKS");
			//f(17, "BLOCKS");
			//f(18, "BLOCKS");
			//f(19, "BLOCKS");
			
			//f(20, "BLOCKS"); //orange
			//f(21, "BLOCKS"); //lime
			f(22, "BLOCKS", "PermaVent");
			//f(23, "BLOCKS");
			f(24, "ANGLES", "PermaDrag");
			//f(25, "BLOCKS");
			//f(26, "BLOCKS");
			//f(27, "BLOCKS");
			//f(28, "BLOCKS");
			//f(29, "BLOCKS");
			//f(30, "BLOCKS");
			//f(31, "BLOCKS");
			
			//_leMap.core.addSpriteRec(2, 3, "b", "START_DOOR", "Start Door", false);
			
			//make sure we start out using a valid tile value:
			_leMap._globalBrushContainer.tileValue = _leMap.tCore.ren.getBrushTileValueUsingMaterialName("Giger");
			
			
			//SPRITE RECTANGLE DATA:
			_leMap.sCore.addSpriteRecDefinition(2, 3, "b", "START_DOOR", "level start door", false);
			_leMap.sCore.addSpriteRecDefinition(2, 3, "r", "EXIT_DOOR" , "level exit door" , false);
			
			_leMap.sCore.addSpriteRecDefinition(2, 2, "r", "TODO_01", "R BTN Small", true);
			_leMap.sCore.addSpriteRecDefinition(2, 2, "g", "TODO_02", "G BTN Small", true);
			_leMap.sCore.addSpriteRecDefinition(2, 2, "b", "TODO_03", "B BTN Small", true);
			
			// Buttons that face up or down depending on where wall is: //
			_leMap.sCore.addSpriteRecDefinition(2, 3, "R", "TODO_04", "R BTN: U/D", true);
			_leMap.sCore.addSpriteRecDefinition(2, 3, "G", "TODO_05", "G BTN: U/D", true);
			_leMap.sCore.addSpriteRecDefinition(2, 3, "B", "TODO_06", "B BTN: U/D", true);
			
			// Buttons that face left or right depending on where wall is: //
			_leMap.sCore.addSpriteRecDefinition(3, 2, "R", "TODO_07", "R BTN: L/R", true);
			_leMap.sCore.addSpriteRecDefinition(3, 2, "G", "TODO_08", "G BTN: L/R", true);
			_leMap.sCore.addSpriteRecDefinition(3, 2, "B", "TODO_09", "B BTN: L/R", true);
			
			//add the promotion and demotion doors. (Up/Down doors)
			_leMap.sCore.addSpriteRecDefinition(2, 3, "RWWW", "TODO_12", "UP HARD DOOR", false);
			_leMap.sCore.addSpriteRecDefinition(2, 3, "WWWR", "TODO_13", "DN EASY DOOR", false);
			
			var verDoorPattern:String = "MMMMMWmWWmWWmWMMMMM";
			var horDoorPattern:String = "MWWWMMMMmmmMMMMWWWM";
			_leMap.sCore.addSpriteRecDefinition(3, 7, verDoorPattern, "TODO_20", "Ver Gate", true);
			_leMap.sCore.addSpriteRecDefinition(7, 3, horDoorPattern, "TODO_21", "Hor Gate", true);
			
			var verDoorOpenPattern:String = "gggggWGWWGWWGWggggg";
			var horDoorOpenPattern:String = "gWWWggggGGGggggWWWg";
			_leMap.sCore.addSpriteRecDefinition(3, 7, verDoorOpenPattern, "TODO_22", "Ver Open", true);
			_leMap.sCore.addSpriteRecDefinition(7, 3, horDoorOpenPattern, "TODO_23", "Hor Open", true);
			
			//_leMap.sCore.addSpriteRecDefinition(inWid:int, inHig:int, inColorCombo:String, inIDName:String, inDispName:String)
			
			///------------------------------------------------///
			//DO THIS AFTER ALL CONFIGURATIONS HAVE BEEN MADE!!!
			//add stuff to UI:
			_leMap.linkToUI( _ui );
			///------------------------------------------------///
			
			_ui.setFontData(FontReg.DIRTYPLAY);
			
			
			this.addChild( _leMap );
			this.addChild( _ui    );
			
			//debug test:
			var dbug:Vector.<StringInt> = _leMap.tCore.getRegisteredMaterials();
			//trace("hi");
			
			var db:Vector.<NamePathIndexBM> = _leMap.tCore.getRegisteredMaterialsWithPreviewImages();
			trace("hi");
			
			//need this hack to get UI working correctly:
			_ui.reInitAtNewSize(_ui._uiBounds);//hack
			
		}//init
		
	}//class
}//package

//Note: Savannah: Sunday at century ballroom:
//July 20th. Boffing, Marker Knife Fight, "The Gift Of Fear"
//She is from Tacoma.