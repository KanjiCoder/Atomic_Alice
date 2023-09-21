package
{
	import JM_EXT.org.flixel.extendedFlixelClasses.FlxState_EXT;
	import JM_EXT.org.flixel.extendedFlixelClasses.FlxCamera_EXT;
	import JM_EXT.org.flixel.gameObjects.emulatableSprite.EmulatableSprite;
	import JM_EXT.org.flixel.gameObjects.cameraStuff.VelocityShiftedCameraFocalPoint;
	import JM_EXT.org.flixel.lazyContainers.Lazy_FlxCamera_EXT;
	import JM_EXT.org.flixel.plainOldData.BMBombPOD;
	import JM_EXT.org.flixel.plainOldData.KeyMapPOD;
	import JM_EXT.org.flixel.plainOldData.TileSheetPOD;
	import JM_EXT.org.flixel.plainOldData.withGettersAndSetters.TileMapCreationKeyGAS;
	import JM_EXT.org.flixel.systems.explosionMap.ExplosionChunkSprite;
	import JM_EXT.org.flixel.systems.explosionMapWithBombs.ExplosionMapWithBombs;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import JM_EXT.org.flixel.gameObjects.explosiveSprite.ExplosiveSprite;
	import JM_GAME_LIBS.flixelBasedGames.games.bombermanZombieEscape.gameObjects.BigBadGuy;
	import JM_GAME_LIBS.flixelBasedGames.games.bombermanZombieEscape.gameObjects.ExitDoorSprite;
	import JM_GAME_LIBS.flixelBasedGames.games.bombermanZombieEscape.gameObjects.LevelStartDoor;
	import JM_GAME_LIBS.flixelBasedGames.games.bombermanZombieEscape.gameObjects.PlayerYou;
	import org.flixel.*;
	import JM_LIB.utils.frameRateUtil.FrameRateUtil;
	import JM_EXT.org.flixel.gameObjects.PathTrolley;
	import JM_EXT.org.flixel.gameObjects.SmartGravityBoundStalker;
	import JM_GAME_LIBS.flixelBasedGames.BasicGameInitRegistry;
	import org.flixel.system.input.Input;
	import JM_EXT.org.flixel.AI.KeyboardAI.SuperDumbKeyboardAI;
	import JM_EXT.org.flixel.utils.pngLevelMapUtils.PNGColorMapNoAlpha;
	import JM_GAME_LIBS.flixelBasedGames.gameRegistries.bombermanZombieEscapeRegistry.ControlHandlerRegistry;
	
	import JM_GAME_LIBS.flixelBasedGames.gameRegistries.bombermanZombieEscapeRegistry.GameReg;
	
	import JM_EXT.org.flixel.extendedFlixelClasses.FlxTileMap_EXT;
	
	import JM_EXT.org.flixel.utils.RandomUtil_Flx;
	import org.flixel.FlxG;

	public class PlayState extends FlxState_EXT
	{
		
		private var _stalker:SmartGravityBoundStalker;
		private var UPF_When_UPS_200:Number; // = BasicGameInitRegistry.getUnitsPerFrame(200);
		
		private var _keyboardAI:SuperDumbKeyboardAI;
		
		private var _colorChangeButtonPressTimes:int = 1;
		private var _colorTileIndex:int = 110;
		
		/** @param _explosionMap used to control explosions in game */
		private var _explosionMap:ExplosionMapWithBombs;
		
		//TODO
		//Make all speeds relative to the frame rate.
		//That way, changing framerate willl not change relative appearance of motion.
		//public const FPS:int = 30; //game frames per second.
		//public const SPEED_MULTIPLIER:Number = 30;
		private var getUPF:Function = FrameRateUtil.getUnitsPerFrame;
		

		
		
		
		// Tileset that works with AUTO mode (best for thin walls) mmmmmmmmmmmm
		[Embed(source = 'auto_tiles.png')]private static var auto_tiles:Class;
		
		
		//Tileset that is used for the bomberman style explosions:
		[Embed(source = 'bomberManExplosionTiles.png')]private static var explosionTiles :Class;
		
		//Tileset used as our bombs:
		[Embed(source = 'bombTiles.png')]private static var bombTiles :Class;
		
		
		
		[Embed(source = 'map_4x_auto.txt' , mimeType = 'application/octet-stream')]private static var default_auto :Class;
		
		

		//[Embed(source = "spaceman.png")] private static var ImgSpaceman:Class;
		//[Embed(source = "spacemanStrip.png")] private static var ImgSpacemanLarge:Class;
		[Embed(source = "spacemanHeadStrip.png")] private static var ImgSpacemanHead:Class; //figure out if collision looks at ZERO alpha or not.
		
		private var _levelWonOrLost:Boolean = false; //if true, the level has been set to won, or lost.
		
		// Some static constants for the size of the tilemap tiles
		public const TILE_WIDTH:uint = 16;
		public const TILE_HEIGHT:uint = 16;
		
		// The FlxTilemap we're using
		private var collisionMap:FlxTileMap_EXT;
		
		// make camera:
		//private var theCam:FlxCamera_EXT;
		private function get theCam():FlxCamera_EXT
		{ 
			return GameReg.playCameraHolder.forceGetStrict();
		}
		
		
		// Box to show the user where they're placing stuff
		private var highlightBox:FlxObject;
		
		// Player modified from "Mode" demo
		public var player:PlayerYou;
		private var _cameraHelper:VelocityShiftedCameraFocalPoint;
		private const CHAR_COUNT:int = 3; //3 character sprite sets.
		private var charUsed:int = 1;
		
		// Some interface buttons and text
		private var quitBtn:FlxButton;

		
		override public function create():void
		{
			if (GameReg.playState != null) 
			{ 
				resetState();
				
				return;
			}
			
			initForceGetters();
			
			GameReg.playState = this; //register play state so it is never re-created.
			
			initSpeedConstants();
			
		
			GameReg.playStateInitialized = true;
			
			// Creates a new tilemap with no arguments
			collisionMap = new FlxTileMap_EXT();
			collisionMap.fuseType = FlxTilemap.FUSETYPE_NONE; //TODO: refactor so you are not butchering the current flixel package with your fuse types.
			GameReg.collisionMapHolder.obj = collisionMap;
			
			//dependency loop. Figure out how to reconcile!
			//HACK:  reconcile: load map twice. Once without using special stuff, then again using special stuff.
			initTileMap(false);
			initExplosionMap(); //depends on initTileMap
			initTileMap(true); //depends on initExplosionMap. TRUE will use special data that requires initExplosionMap.
			GameReg.explosionMapHolder.obj = _explosionMap;
				
			setupPlayer();	
			add(player);
			add(collisionMap);
		
		
		
		
		
		
		
			highlightBox = new FlxObject(0, 0, TILE_WIDTH, TILE_HEIGHT);
		
			
			makeNewPlayCamera();
			makeHUD();
			
			initStalker(); //depends on initTileMap
			
			//Make it so player can trip proximity mines.
			_explosionMap.registerCollisionSprite(player,true,true);
			_explosionMap.setCameraHolderForCollisionDetection(GameReg.playCameraHolder);
			//_explosionMap.registerCollisionSprite(_stalker);
			trace("create over");
			
		}//create
		
		private function initTileMap(laySprites:Boolean=false):void
		{
			var curMapPng:Class = GameReg.getLevelPNG();
			if (laySprites)
			{
				var tmKey:TileMapCreationKeyGAS = new TileMapCreationKeyGAS(this);
				tmKey.mapFunctionToIndex(tileMapKey_layProximityMine, PNGColorMapNoAlpha.BLUE_INDEX );
				tmKey.mapFunctionToIndex(tileMapKey_setLevelStartDoor, PNGColorMapNoAlpha.DARK_BLUE_INDEX);
				tmKey.mapFunctionToIndex(tileMapKey_setExitDoor, PNGColorMapNoAlpha.DARK_RED_INDEX);
				collisionMap.loadMapUsingPNG_16Bit(curMapPng, new TileSheetPOD(auto_tiles, TILE_WIDTH, TILE_HEIGHT), tmKey , FlxTilemap.AUTO);
			}
			else
			{
				collisionMap.loadMapUsingPNG_16Bit(curMapPng, new TileSheetPOD(auto_tiles, TILE_WIDTH, TILE_HEIGHT), null  , FlxTilemap.AUTO);
			}
			add(collisionMap);
		}
				
		private function initStalker():void
		{
			_stalker = new BigBadGuy(); //enemy SPECIFIC to Bomberman Zombie Escape.
			/*
			_stalker = new SmartGravityBoundStalker(30, 30,collisionMap,this,GameReg.playCameraHolder);
			_stalker.loadGraphic(ImgSpacemanLarge, true, true, 32, 32);
			_stalker.setTarget(player);
			_stalker.start();
			//_stalker.debuggerCamera = theCam;
			
			//animations
			_stalker.addAnimation("idle", [0]);
			_stalker.addAnimation("run", [1, 2, 3, 0], 12);
			_stalker.addAnimation("jump", [4]);
			*/
			add(_stalker);
		}
		
		private function initSpeedConstants():void
		{
			//UPS_200 is 200 UNITS PER SECOND, converted into units per frame.
			//Units per frame changes depending on frame rate, hence the strange name of
			//UPS_200 when it actually stores units per frame.
			//Think of it as: Units Per Frame when Units Per Second is 200. UPF_When_UPS_200
			UPF_When_UPS_200 = BasicGameInitRegistry.getUnitsPerFrame(200); //UPS_200 = 200 "units per second".
		}
		
		private function initExplosionMap():void
		{
			trace("initExplosionMap()");
			_explosionMap = new ExplosionMapWithBombs(this, collisionMap, 
			                                          new TileSheetPOD(explosionTiles, TILE_WIDTH, TILE_HEIGHT), 
			                                          new TileSheetPOD(bombTiles,TILE_WIDTH,TILE_HEIGHT)      );
		}
		
		
		
		private function makeHUD():void
		{

			quitBtn = new FlxButton(FlxG.stage.stageWidth - 80 - 4, FlxG.stage.stageHeight - 24, "Re-Start",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } ); } );
			add(quitBtn);
			
			//make it have static position on screen.
			quitBtn      .scrollFactor.x = quitBtn      .scrollFactor.y = 0;
			
		}
		
		//what to do when two crates collide.
		private function crateOnCrateAction(c1:FlxSprite, c2:FlxSprite):void
		{
			
		}
		
		private function crateOnWallAction(b1:FlxBasic, b2:FlxBasic):void
		{
			//get the object that is NOT the wall, but our sprite.
			var b:FlxSprite;
			if (b1 is FlxSprite) { b = b1 as FlxSprite; }
			else
			if (b2 is FlxSprite) { b = b2 as FlxSprite; }
			
			if (b1 is Sprite && b2 is Sprite) { throw new Error("both sprites"); }
			
			b.acceleration.x = 0 - b.acceleration.x;
			b.acceleration.y = 0 - b.acceleration.y;
		}
		
		public function playerOnCrateAction(b1:FlxBasic, b2:FlxBasic):void
		{
			//TODO: Make crates a special class.
			//HACK: get the object that IS the crate:
			var b:FlxSprite; //the crate object. The object being pushed.
			var p:FlxSprite; //the player object, the one doing the pushing.
			if (b1 != player) 
			{ 
				b = b1 as FlxSprite; 
				p = b2 as FlxSprite;
			}
			else 
			{ 
				b = b2 as FlxSprite; 
				p = b1 as FlxSprite;
			}
			b.angularVelocity = 0 - p.angularVelocity;
			
		}
		
		private function tileMapKey_layProximityMine(fState:FlxState, tileX:uint, tileY:uint, tileIndexNum:uint):uint
		{
			_explosionMap.layProximityMine(tileX, tileY, new BMBombPOD(2, 2, 4, 4) );
			return 0;
		}
		
		private function tileMapKey_setExitDoor(fState:FlxState, tileX:uint, tileY:uint, tileIndexNum:uint):uint
		{
			if (GameReg.exitDoor == null)
			{ 
				GameReg.exitDoor = new ExitDoorSprite(); 
				this.add(GameReg.exitDoor);
			}
			GameReg.exitDoor.setTileXY(tileX, tileY);

			return 0;
		}
		
		private function tileMapKey_setLevelStartDoor(fState:FlxState, tileX:uint, tileY:uint, tileIndexNum:uint):uint
		{
			if (GameReg.levelStartDoor == null)
			{ 
				GameReg.levelStartDoor = new LevelStartDoor(); 
				this.add(GameReg.levelStartDoor);
			}
			GameReg.levelStartDoor.setTileXY(tileX, tileY);

			return 0;
		}
		
		
		private function collision_cratesVSmap(objectOrGroup1:FlxBasic, objectOrGroup2:FlxBasic):void
		{
			FlxG.overlap(objectOrGroup1, objectOrGroup2, crateOnWallAction, FlxObject.separate);
		}
		
		public function exitDoorReachedOverlapFunction(o1:FlxObject, o2:FlxObject):void
		{
			winLevel();
		}
		
		override public function update():void
		{
			
			//update explosions:
			_explosionMap.update();
			
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, collisionMap);
			FlxG.collide(_stalker, collisionMap);
			FlxG.overlap(player, GameReg.exitDoor, null, exitDoorReachedOverlapFunction);
			//FlxG.collide(player, GameReg.exitDoor, exitDoorReachedOverlapFunction); //win level when exit door is reached.
			
			//CODE when doing WITH a camera:
			var wp:FlxPoint = FlxG.mouse.getWorldPosition(theCam);
			var sp:FlxPoint = FlxG.mouse.getScreenPosition(theCam);
			highlightBox.x = Math.floor(wp.x / TILE_WIDTH) * TILE_WIDTH;
			highlightBox.y = Math.floor(wp.y / TILE_HEIGHT) * TILE_HEIGHT;
			
			if (FlxG.keys.F)
			{
				//query what FUSETYPE you are using.
				trace("collisionMap.fuseType==" + collisionMap.fuseType);
			}
			
			if (FlxG.mouse.pressed())
			{
				// FlxTilemaps can be manually edited at runtime as well.
				// Setting a tile to 0 removes it, and setting it to anything else will place a tile.
				// If auto map is on, the map will automatically update all surrounding tiles.
				
				var tileX:int = wp.x / TILE_WIDTH;
				var tileY:int = wp.y / TILE_HEIGHT;
				if (FlxG.keys.SHIFT)
				{
					_explosionMap.layProximityMine(tileX, tileY, new BMBombPOD(1, 1, 20, 20) );
				}
				else
				{
					collisionMap.setTile(tileX, tileY, _colorTileIndex); //17
				}
			
			}
			
			updatePlayer();
			//_stalker.updateStalker();
			super.update();
		}
		
		
		public override function draw():void
		{
			super.draw();
			//highlightBox.drawDebug();
			highlightBox.drawDebug(theCam);
		}
		

		
		private function setupPlayer():void
		{
			if (player == null)
			{
				//if(false)
				if (GameReg.playerHolder.obj != null)
				{ 
					player = GameReg.playerHolder.obj as PlayerYou; 
					if (player.offset == null) { throw new Error("WTF?"); }
				}
				else
				{
					player = new PlayerYou();	
				}
				
				//reset position of player to wherever it should be at start of this level.
				add(player);
				player.x = GameReg.levelStartDoor.x;
				player.y = GameReg.levelStartDoor.y;
				if (player.offset == null) { throw new Error("WTF?"); } //will throw error on destroyed camera object.
				
				
				//make new camera helper that will follow the player:
				_cameraHelper = new VelocityShiftedCameraFocalPoint(GameReg.playerHolder);
				add(_cameraHelper);
			}
			
			
			
			
		}
		
		//part of lazy initialization. New camera not made until it is needed.
		private function makeNewPlayCamera():FlxCamera_EXT
		{
			//do not re-make camera if it all looks good. Return original object.
			if (GameReg.playCameraHolder.ok) { return GameReg.playCameraHolder.obj;}
			
			var rCam:FlxCamera_EXT = new FlxCamera_EXT(0, 0, FlxG.stage.stageWidth, FlxG.stage.stageHeight);
			rCam.follow(_cameraHelper); //follow camera helper instead of player to make camera movement smoother.
			
			// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
			rCam.setBounds(0,0,collisionMap.width, collisionMap.height);
			rCam.color = 0xFFCCCC; // add a light red tint to the camera to differentiate it from the other
			FlxG.addCamera(rCam);
			return rCam;
		}
		
		private function updatePlayer():void
		{
			//_keyboardAI.update();
			
			if (FlxG.keys.justPressed("B") )
			{
				//t_race("B for Bomb");
				//_explosionMap.layProximityMine(player.x / TILE_WIDTH, player.y / TILE_HEIGHT, new BMBombPOD(4, 4, 4, 4));
				_explosionMap.layBomberManBomb(player.x / TILE_WIDTH, player.y / TILE_HEIGHT, new BMBombPOD(4, 4, 4, 4));
			}
			
			//lay vertical array with no time limit.
			if (FlxG.keys.V)
			{
				_explosionMap.layBomberManBomb(player.x / TILE_WIDTH, player.y / TILE_HEIGHT, new BMBombPOD(0, 0, 4, 4));
			}
			
			//toggle AI between user controlled and AI controlled:
			if (FlxG.keys.justPressed("TWO") )
			{
				//_stalker.get
				if ( _stalker.getIsUserControlled() )
				{
					_stalker.reLinkToComputerAI();
				}
				else
				{
					_stalker.makeUserControlled();
				}
			}
			
			
			//wrap(player);
			clampPlayerPositionAndCheckForWinLosePosition(player);
		}
		
		private function temp_debug():void
		{
			//var cs:ExplosionChunkSprite = new ExplosionChunkSprite(X, Y, null);
		}
		
		private function wrap(obj:FlxObject):void
		{
			//This code wraps the player on the STAGE. We want to wrap the player relative to the size of the world.
			//obj.x = (obj.x + obj.width / 2 + FlxG.width) % FlxG.width - obj.width / 2;
			//obj.y = (obj.y + obj.height / 2) % FlxG.height - obj.height / 2;
			
			//Wrap player relative to the bounds of the world.
			obj.x = (obj.x + obj.width / 2 + collisionMap.width) % collisionMap.width - obj.width / 2;
			obj.y = (obj.y + obj.height / 2) % collisionMap.height - obj.height / 2;
		}
		
		/**
		 * Checks position of player. If player has fallen off bottom edge of screen, you die. (lose condition)
		 *                            If player is off right edge, you win because you have made it to the end of the level.
		 *                            Win condition trumps lose condition.
		 * @param	obj
		 */
		private function clampPlayerPositionAndCheckForWinLosePosition(obj:FlxObject):void
		{
			//Do NOT clamp the maximum on the X axis, because running off that side of the screen is our win condition.
			//Clamp the boundaries that do not involve winning or losing:
			if (obj.x < 0) { obj.x = 0; }
			if (obj.y < 0) { obj.y = 0; }
			
			//winning or losing condition checks:
			if (obj.x > collisionMap.width)
			{   //have made it to the end of level, win the level.
				winLevel();
			}
			else
			{   //fallen off the bottom of the screen, lose the level.
				if (obj.y > collisionMap.height) { loseLevel(); }
			}
		}
		
		private function winLevel():void
		{
			trace("level won!");
			if (_levelWonOrLost == true) { return; } //gaurd against jumping 4 levels at once because winLevel was called multiple times.
			_levelWonOrLost = true;
			GameReg.incrimentLevelNumber(); //incriment to next level.
			FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } );
		}
		
		public function loseLevel():void
		{
			trace("level lost");
			if (_levelWonOrLost == true) { return; } //gaurd against calling multiple times during same session.
			_levelWonOrLost = true;	
			FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } );
		}
		
		public function resetState():void
		{
			_levelWonOrLost = false;
			
			//re-activate camera:
			/* Camera is hard to prevent being disposed. Will NOT be re-activating camera. Camera is now lazily initialized. */
			
			
			//reInitialze/reset explosion map:
			//Must do this BEFORE setting the bombs on the tile-map, as this will DELETE any bombs on the map.
			_explosionMap.reInitialize(); //reInit will force explosion map to make sure everything is in order. Specifically the camera it is using.
			
			//re-activate tilemap
			collisionMap.exists = true;
			collisionMap.setDirty(true); //force redraw of entire tile-map.
			initTileMap(true); //depends on initExplosionMap. TRUE will use special data that requires initExplosionMap.
			
			
			
			//re-activate player:
			player.exists = true;
			player.x = GameReg.levelStartDoor.x;
			player.y = GameReg.levelStartDoor.y;
			_cameraHelper.resetPosition(); //snaps it to it's target.
			add(player);
			
			//lastly, re-activate the state itself:
			this.exists = true;
		}
		
		public function initForceGetters():void
		{
			//set forceGetter for getting playCamera.
			GameReg.playCameraHolder.setForceGetFunction( makeNewPlayCamera );
		}
		
		
	}//class
}//package


