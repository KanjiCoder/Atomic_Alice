package
{
	//STATISTICS SHOW 640 x 480 is resolution of highest paying games according to:
	//http://www.flashgamelicense.com/blog/2010/01/looking-back-at-2009-trends-and-statistics/
	
	/*
	 * Story Idea:
		 * Game called "L-Bomb"
		 * Survival horror game.
		 * When you were younger, something made you immortal.
		 * Snake bite? Chemical? Pact with satan?
		 * 
		 * Your ex(Girlfriend/Boyfriend) is trying to kill you.
		 * They are already dead and there spirit is after you?
		 * Or have they conjured a curse to come after you?
		 * 
		 * The gender of the main character should be ambiguious.
		 * As well as the gender of the stalker.
		 * 
		 * 
	 * 
	 * 
	 * 
	 */
	
	 import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.SaveDataReg;
	
	 import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.MenuReg;
	 import JM_GAME_LIBS.flixelBasedGames.subSonicShock.states.BlankState;
	import JM_LIB.MEM;
	import com.divillysausages.gameobjeditor.component.SliderComponent;
	import flash.events.Event;
	import flash.display.Sprite;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.maps.DevMapLoaderSSS;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.maps.DevSpacerMapLoaderSSS;
	import JM_LIB.collections.bmDict.IndexedBitmapDictionary;
	import JM_LIB.helperTypes.LevelRegHelper;
	import JM_LIB.loading.loadingScreen.DevLoadingScreen;
	
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.GameReg;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.BasicReg;
	//import JM_LIB.UI.focusHelper.FocusManager;
	
	import com.greensock.plugins.SetActualSizePlugin;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.NetFilterEvent;
	import flash.geom.Rectangle;
	import net.hires.debug.Stats;
	import JM_EXT.org.flixel.extendedFlixelClasses.FlxGame_EXT;
	import JM_GAME_LIBS.flixelBasedGames.BasicGameInitRegistry;
	import org.flixel.*;
	import JM_LIB.graphics.utils.fill.BitmapFillPatternUtil;
	//import JM_LIB.graphics.BitmapFillPatternUtil;
	
	import JM_LIB.UI.components.fluidBox.FluidBoxMasterCage;
	import JM_LIB.UI.components.fluidBox.FluidBoxUI;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.FluidLayoutReg;
	
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.functionRegistries.PauseReg;
	
	import com.mochiBot.MochiBot;
	import com.mochiBot.MyMochiBotList;
	//import config.GameSwitchBoard;
	import JM_LIB.configTypes.botData.BotTrackerData;
	
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.RegistryInitializer;
	
	import config.GameSwitchBoard;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.assets.SubSonicShockDevAssetLoader;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.states.AssetLoaderState;
	import JM_LIB.configTypes.assetPack.GenericAssetPack;
	
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.LevelReg;
	import JM_LIB.collections.jsonDict.JSONDictUsingGameDifficultyModeKeys;
	import JM_LIB.configTypes.mData4LevelPacks.loader.MData4PNGLevPacks_Loader;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.maps.MapMetaDataLoaderSSS;
	
	import JM_LIB.loading.loadingScreen.GlobalDevLoadingScreenContainer;
	
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.initializers.PlayState2Initializer;
	import JM_EXT.org.flixel.extendedFlixelClasses.FlxState_EXT;
	
	//import com.sociodox.theminer.TheMiner;
	
	/// SURPRISE ATTACK !!!! ///
    //http://surpriseattackgames.com/
	

	
	//My states and how I initialize the game need to be refactored so heavily, that it is better to make a
	//MenuState2 and PlayState2 and start over, referencing my original states as I go.
	//import JM_GAME_LIBS.flixelBasedGames.subSonicShock.states.MenuState;
	
	
    //[SWF(width = "400", height = "300", backgroundColor = "#000000")]
	
	
	//Links the Preloader.as to Main.as
	//http://flashgamedojo.com/wiki/index.php?title=Preloader_(Flixel)
	//[Frame(factoryClass = "Preloader")]
	//[Frame(factoryClass = "Preloader")]

	//AAAAHHH!!!! The frame directive probably has to go directly above the class definition,
	//with no white space.
	[Frame(factoryClass = "Preloader")]
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	public class Main extends Sprite //MovieClip //Changed to extending sprite. 2014.01.17
	{
		//TODO: These const settings should be in the "BasicGameInitRegistry".
		//The BasicGameInitRegistry.initBasics should be done away with in favor of
		//having all the data that is supplied to initBasics simply INCLUDED in the BasicGameInitRegistry.
		
		/** A debugging flag to see what our memory usage is if we go straight game without using any menus **/
		//private static const DEBUG_GO_STRAIGHT_TO_GAME:Boolean = false;
		
		public var fGame:FlxGame_EXT;
		public var hudBMP:BitmapData;
		public var hudVIS:Bitmap;
		//public var focusMGR:FocusManager = new FocusManager();
		
		
		/** This loader will only be invoked in dev mode. Needed to front-load all assets before game init begins. **/
		private var _devAssetLoader:SubSonicShockDevAssetLoader;
		private var _devAssetsReady:Boolean = false;
		
		/** This loader is only invoked in dev mode. Used to front-load all maps before game init begins. **/
		private var _devMapLoader:DevMapLoaderSSS;
		private var _devMapsReady:Boolean = false;
		
		private var _devSpacerMapLoader:DevSpacerMapLoaderSSS;
		private var _devSpacerMapsReady:Boolean = false;
		
		/** This loader is only invoked in DEV mode. Used to front load all of the decals used in levels before the game init begins. **/
		private var _mapMetaDataLoader:MData4PNGLevPacks_Loader;
		private var _mapMetaReady:Boolean = false;
		
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}//main
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			init_game();
		}
		
		//In effort to re-factor game so that pre-loader works, I have put the code from
		//"Main" into init_game and modelling my code after an empty "AS3 with Pre-loader" project.
		private function init_game():void
		{
			//Initializing the save data registry will tell the game what Derivative it needs to be in
			//within the "ABTestReg"
			SaveDataReg.init();
			
			/// NOTE: You need to edit mochibot to NOT be throwing errors if unable to connect to the internet! ///
			//Testing out my first ever mochi bot.
			//MochiBot.track(this, GameSwitchBoard.modeData.botData.mochi.mochiBotID);
			
			//init the game switch board:
			//we need to put this HERE, not inside the flixel game. Because we need to make absolutely sure all of our assets are initialized BEFORE we start the game.
			
			if (GameSwitchBoard.modeData.modeName == GameSwitchBoard.GAME_MODE_GAMEDEV50)
			{
				var devScreen:DevLoadingScreen = GlobalDevLoadingScreenContainer.getScreen();
				devScreen.init(this.stage, this.stage.stageWidth, this.stage.stageHeight);
				devScreen.setMessage("Hello World!");
				
				//if we are in dev mode, we are going to load the assets we need into the game switch board. THEN we will start up the game.
				//TODO: An asset loader UI NOT BASED IN FLIXEL would be nice for this part.
				_devAssetLoader = new SubSonicShockDevAssetLoader();
				_devAssetLoader.initAndLoad( onDevAssetsLoaded, GlobalDevLoadingScreenContainer.setMessage );
				
				//Dev MAIN levels:
				_devMapLoader = new DevMapLoaderSSS();
				_devMapLoader.createGameDevLevelPack( onDevLevelsLoaded , GlobalDevLoadingScreenContainer.setMessage);
				
				//Dev SPACER levels:
				_devSpacerMapLoader = new DevSpacerMapLoaderSSS();
				_devSpacerMapLoader.createGameDevLevelPack( onDevSpacerLevelsLoaded , GlobalDevLoadingScreenContainer.setMessage);
				
				//commenting out decal loading until we know that we have successfully
				//refactored out DirectoryPNGLoader core into the base class of DirectoryLoader
				//load the decals in a similiar fashion the maps:
				_mapMetaDataLoader = new MapMetaDataLoaderSSS();
				_mapMetaDataLoader.initAndLoad( onMapMetaDataLoaded, GlobalDevLoadingScreenContainer.setMessage);
			}
			else
			{
				finalizeInitBecauseAssetsAreReady();
			}
			
		}//init_game
		
		private function finalizeInitBecauseAssetsAreReady():void
		{
			CONFIG::debug
			{//::debug::debug::debug::debug::debug
				trace("before finalizeInitBecauseAssetsAreReady");
				MEM.doMemoryTrace();
			}//::debug::debug::debug::debug::debug
			
			//remove the dev loader screen!
			GlobalDevLoadingScreenContainer.remove();
			
			//fGame = new FlxGame_EXT(480/2, 480/2, MenuState2, 1, BasicReg.FPS, BasicReg.FPS, true);
			//BasicGameInitRegistry.initBasics(fGame, BasicReg.FPS, BasicReg.SPEED_MULTIPLIER);
			
			//fill BasicReg with data from GameSwitchBoard, eventually get rid of BasicReg:
			BasicReg.GAME_WID = GameSwitchBoard.modeData.basicData.GAME_WID;
			BasicReg.GAME_HIG = GameSwitchBoard.modeData.basicData.GAME_HIG;
			
			fGame = new FlxGame_EXT(BasicReg.GAME_WID, BasicReg.GAME_HIG, BlankState, 1, BasicReg.FPS, BasicReg.FPS, true);
			BasicGameInitRegistry.initBasics(fGame, BasicReg.FPS, BasicReg.SPEED_MULTIPLIER);
			
			
			//Handles any interconnections between registries that need to be handled!
			RegistryInitializer.init(this.stage);
			
			//Because the menu registry depends on this, you will init this BEFORE calling the RegistryInitializer
			FluidLayoutReg.init(this.stage);
			
			//fGame = new FlxGame_EXT(BasicReg.GAME_WID, BasicReg.GAME_HIG, MenuState2, 1, BasicReg.FPS, BasicReg.FPS, true);
			//BasicGameInitRegistry.initBasics(fGame, BasicReg.FPS, BasicReg.SPEED_MULTIPLIER);
			FluidLayoutReg.gameHolder_game.addChild(fGame);
			
			//Debugger profiler.
			//this.addChild(new TheMiner()); 
			
			//REMOVING THIS:
			//BECAUSE:
			//1: Looks like shit.
			//2: The seizure warning screen gaurantees us focus.
			//Init the focus manager. Responsible for blurring the screen when the game is out of focus:
			//focusMGR.init(this, BasicReg.SWF_WID, BasicReg.SWF_HIG, defaultFocusHackFunction, true);
			
		
			CONFIG::debug
			{//::debug::debug::debug::debug::debug
				//putting this before the ASYNC debug code so we get a consistent readout.
				trace("AFTER finalizeInitBecauseAssetsAreReady");
				MEM.doMemoryTrace();
			}//::debug::debug::debug::debug::debug
			
			
			//MenuReg.complyMenu.showMenu();
			MenuReg.passMenu.showMenu();
		
			//Finalize not really needed at the moment.
			//Finalize the loading of save data now that everything is ready:
			//SaveDataReg.finalize();
			
		}//finalizeInitBecauseAssetsAreReady
		
		private function onDevAssetsLoaded():void
		{
			GlobalDevLoadingScreenContainer.setMessage("Dev Assets Loaded!");
			//set the asset data from the asset loader into our game switch board's asset data slot:
			var gap:GenericAssetPack = _devAssetLoader.getAssetPack();
			GameSwitchBoard.modeData.assetData = gap;
			_devAssetsReady = true;
			
			maybeFinalizeInit();
			
		}//onDevAssetsLoaded
		
		private function onDevLevelsLoaded():void
		{
			GlobalDevLoadingScreenContainer.setMessage("Dev Levels Loaded!");
			var lev:LevelRegHelper = _devMapLoader.getDevLevelPack();
			GameSwitchBoard.modeData.mapData.mainMapData = lev;
			_devMapsReady = true;
			
			maybeFinalizeInit();
			
		}//onDevLevelsLoaded
		
		/** Added:2014.09.26 to support the spacer levels in the dev version **/
		private function onDevSpacerLevelsLoaded():void
		{
			GlobalDevLoadingScreenContainer.setMessage("Dev SPACER Levels Loaded.");
			var lev:LevelRegHelper = _devSpacerMapLoader.getDevLevelPack();
			GameSwitchBoard.modeData.mapData.spacerMapData = lev;
			_devSpacerMapsReady = true;
			maybeFinalizeInit();
		}//onDevSpacerLevelsLoaded
		
		
		
		
		private function maybeFinalizeInit():void
		{
			if (_devAssetsReady && _devMapsReady && _devSpacerMapsReady && _mapMetaReady)
			{
				finalizeInitBecauseAssetsAreReady();
			}
		}//maybeFinalizeInit
		
		private function onMapMetaDataLoaded():void
		{
			GlobalDevLoadingScreenContainer.setMessage("Map Meta Data Has been loaded! Now packaging.!");
			
			GameSwitchBoard.modeData.mapMeta = _mapMetaDataLoader.getData();
			_mapMetaReady = true;
			
			GlobalDevLoadingScreenContainer.setMessage("Map Meta Data Packaged!!");
			
			maybeFinalizeInit();
			
			
			//CONFIG::release { throw new Error("Still working on this code."); }
		}//onMapMetaDataLoaded
		
		
		/** Returns TRUE if we test for being in focus **/
		private static function defaultFocusHackFunction():Boolean
		{
			return ( FlxG.keys.any() );
		}
		
		/*
		// A hack start game function to see how much memory the game uses WITHOUT any of our UI elements. //
		private static function HACK_START():void
		{
			if (!PlayState2Initializer.LC2_playState.ok)
			//if(true)
			{
				trace("Calling PlayState2Initializer.init()...");
				//If they playstate has not been created yet, create it.
				//The init function is safe to call agian at a later date if something (like the camera) is destroyed.
				PlayState2Initializer.init();
			}
			

			FlxG.switchState( PlayState2Initializer.LC2_playState.obj as FlxState_EXT );
		}//HACK_START
		*/
			
	}//class
}//package


//GAME NAME IDEAS:
/*
 * 
 * UPDATE ON NOTES: 2014.08.22:
	 * A name should not center around the mechanics.
	 * Angry Birds after all is not called "Catapult".
	 * The name needs to:
		 * 1. Invoke A Brand Identity.
		 * 2. Be highly suggestive of a character or story.
		 * 3. Extention of #2: The name needs to invoke imagery in the
		 *    mind of the consumer. When imagery is invoked, people remember.
		 *    Because the mind likes storys and pictures.
		 * 
	 *TODO: When you get back from Grandmas. Go get laid.
	 *      Will have to stop masturbating 7 days before Monday.
 
 TODO: Have sex with amanda on camera with tripod.
 TODO: For every 100 girls you talk to. You should get laid.
 Start keeping count and being agressive.
 * 
 * Blast Out
Infinity Bomber
Dungeon Blaster
LBOM
LB
INF B

LBomb (Could play off this? Creepy Stalker story line?)
Your '


Name that includes the mechancs?
1. Bombs.
2. Blocks.
3. Destruction of blocks.
4. Lights.
Light Bomber --Name of a plane.



Quarantine Escape
Hazard Escape
Death Blocks
Intruder Quarantine --Cooler sounding.
Curse Complex  --Easier to type and say.
CurseD Complex --Makes note of the D as well as looks like "CDC"
                 Which is "centers for disease prevention"

Hell Complex --Hell is more universal of an idea than curse?
               Maybe not. But shorter and easier to say.
			   
Tech Terror

Hell Tech -- Cant use. Name of crappy company.
Hell Bomb -- Name of tattoo parlor.
Bomb Barracks
Bomb Room
Bomb Base
Hell Base
Base Blaster - Name of like.. Stereo system or something.
Tech Trap
Fuse Trap
Bomb Gate -terrorism undertones.
Fuse Cult vs Bomb Cult
Hell Fuse vs Fuse Cult : Hell Fuse looks like it has a lot of hits. Unlike fuse cult.

Fuse of Fury (Furry vs Fury... Too hard to spell)
			   
Lone Fuse

Boom Doom --Led me here... But I still like it. http://new.gloomboomdoom.com/portalgbd/homegbd.cfm

Doom Room -- Has hits on search engine that seem connected to Doom.

Death Complex -- 6 results searching newgrounds.

Escape From Cult Complex
Escape From Death Complex
Bomb Cult Blast Out


Bomb Cult  - ZERO matches on newgrounds.
Dark Fuse  - Zero matches
Alone With Bombs
Flash in the dark

Mood Boom (palandrome)
Mode eBom -Also a palandrome.

ModeboM -- A bit confusing to look at But unique.

mod e bom
mod e bom cult

Bomb Trap --gets booby trap when I google this phrase.

Part rap
par trap
partrap

ill kill

Shadow
Cult

Intruder
Quarantine

Made up words:
BlastMare

Hazard
Light
Survivoer
Lone
Fuse
Flash

Curse 
Light Hazard

Bomb Hazard

Nothing left to lose
Shades of Kaboom

Words:
NightMare


Names of games with similar mood:
Dead Space
Fatal Frame
Resident Evil
Dark Corners


*/







