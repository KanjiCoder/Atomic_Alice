package
{
	import JM_EXT.org.flixel.gameObjects.emulatableSprite.EmulatableSprite;
	import JM_EXT.org.flixel.plainOldData.BMBombPOD;
	import JM_EXT.org.flixel.plainOldData.KeyMapPOD;
	import JM_EXT.org.flixel.plainOldData.TileSheetPOD;
	import JM_EXT.org.flixel.systems.explosionMap.ExplosionChunkSprite;
	import JM_EXT.org.flixel.systems.explosionMapWithBombs.ExplosionMapWithBombs;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import JM_EXT.org.flixel.gameObjects.explosiveSprite.ExplosiveSprite;
	import org.flixel.*;
	import JM_LIB.utils.frameRateUtil.FrameRateUtil;
	import JM_EXT.org.flixel.gameObjects.PathTrolley;
	import JM_EXT.org.flixel.gameObjects.SmartGravityBoundStalker;
	import JM_GAME_LIBS.flixelBasedGames.BasicGameInitRegistry;
	import org.flixel.system.input.Input;
	import JM_EXT.org.flixel.AI.KeyboardAI.SuperDumbKeyboardAI;
	
	import JM_EXT.org.flixel.utils.RandomUtil_Flx;
	import org.flixel.FlxG;

	public class PlayState extends FlxState
	{
		private var _stalker:SmartGravityBoundStalker;
		private var UPF_When_UPS_200:Number; // = BasicGameInitRegistry.getUnitsPerFrame(200);
		//private var _trolley:PathTrolley;
		
		private var _keyboardAI:SuperDumbKeyboardAI;
		
		private var _colorChangeButtonPressTimes:int = 1;
		private var _colorTileIndex:int = 33;
		
		/** @param _explosionMap used to control explosions in game */
		private var _explosionMap:ExplosionMapWithBombs;
		
		//TODO
		//Make all speeds relative to the frame rate.
		//That way, changing framerate willl not change relative appearance of motion.
		//public const FPS:int = 30; //game frames per second.
		//public const SPEED_MULTIPLIER:Number = 30;
		private var getUPF:Function = FrameRateUtil.getUnitsPerFrame;
		
		//private var UPF_When_UPS_200:Number; //200 units per second.
		
		//////////////  COLLISION CRATES CODE:  //////////////////////////
		//We'll reuse this when we make a bunch of crates
		private var crate:ExplosiveSprite;
		[Embed(source = 'assets/crate.png')] private var cratePNG:Class;
		//We'll make 100 per group crates to smash about
		private var numCrates:int = 0;
		//these are the groups that will hold all of our crates
		private var crateStormGroup:FlxGroup;
		//-----------   COLLISION CRATES CODE:  -------------------------- 
		
		
		
		// Tileset that works with AUTO mode (best for thin walls)
		[Embed(source = 'auto_tiles.png')]private static var auto_tiles:Class;
		
		
		//Tileset that is used for the bomberman style explosions:
		[Embed(source = 'bomberManExplosionTiles.png')]private static var explosionTiles :Class;
		
		//Tileset used as our bombs:
		[Embed(source = 'bombTiles.png')]private static var bombTiles :Class;
		
		
		
		[Embed(source = 'map_4x_auto.txt' , mimeType = 'application/octet-stream')]private static var default_auto :Class;
		
		

		[Embed(source = "spaceman.png")] private static var ImgSpaceman:Class;
		[Embed(source = "spacemanStrip.png")] private static var ImgSpacemanLarge:Class;
		[Embed(source = "spacemanHeadStrip.png")] private static var ImgSpacemanHead:Class; //figure out if collision looks at ZERO alpha or not.
		
		// Some static constants for the size of the tilemap tiles
		private const TILE_WIDTH:uint = 16;
		private const TILE_HEIGHT:uint = 16;
		
		// The FlxTilemap we're using
		private var collisionMap:FlxTilemap;
		
		// make camera:
		private var theCam:FlxCamera;
		
		// Box to show the user where they're placing stuff
		private var highlightBox:FlxObject;
		
		// Player modified from "Mode" demo
		private var player:EmulatableSprite;
		private const CHAR_COUNT:int = 3; //3 character sprite sets.
		private var charUsed:int = 1;
		
		// Some interface buttons and text
		private var autoAltBtn:FlxButton;
		private var resetBtn:FlxButton;
		private var playerSwapBtn:FlxButton;
		private var quitBtn:FlxButton;
		private var helperTxt:FlxText;
		
		override public function create():void
		{
			
			
			//FlxG.framerate = FPS;
			//FlxG.flashFramerate = FPS;
			//BasicGameInitRegistry.initBasics(800,600,FPS, SPEED_MULTIPLIER);
			
			//FrameRateUtil.fps = FPS;
			//FrameRateUtil.speedMultiplier = SPEED_MULTIPLIER;
			//getUPF = FrameRateUtil.getUnitsPerFrame;
			
			initSpeedConstants();
			
			// Creates a new tilemap with no arguments
			collisionMap = new FlxTilemap();
			
	
			
			/*
			 * FlxTilemaps are created using strings of comma seperated values (csv)
			 * This string ends up looking something like this:
			 *
			 * 0,0,0,0,0,0,0,0,0,0,
			 * 0,0,0,0,0,0,0,0,0,0,
			 * 0,0,0,0,0,0,1,1,1,0,
			 * 0,0,1,1,1,0,0,0,0,0,
			 * ...
			 *
			 * Each '0' stands for an empty tile, and each '1' stands for
			 * a solid tile
			 *
			 * When using the auto map generation, the '1's are converted into the corresponding frame
			 * in the tileset.
			 */
			
			// Initializes the map using the generated string, the tile images, and the tile size
			collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			add(collisionMap);
			//FlxG.worldBounds = new FlxRect(0, 0, FlxG.width, FlxG.height);
			
			highlightBox = new FlxObject(0, 0, TILE_WIDTH, TILE_HEIGHT);
			
			setupPlayer();
			setupCamera();
			initCrates();
			makeHUD();
			initExplosionMap();
			initStalker();
			
			//Make it so player can trip proximity mines.
			_explosionMap.registerCollisionSprite(player);
			_explosionMap.setCameraForCollisionDetection(theCam);
			//_explosionMap.registerCollisionSprite(_stalker);
			
		}//create
		
		/*
		private function initTrolley():void
		{
			//_trolley = new PathTrolley(collisionMap, theCam);
			//add(_trolley);
			
			var tX:int = collisionMap.widthInTiles;
			var tY:int = collisionMap.heightInTiles;
			var p0:FlxPoint;
			var p1:FlxPoint;
			var pathMade:Boolean = false;
			do {
				//random start point is in one quadrant of map.
				//random end point is in kitty-corner quadrant of map.
				p0 = RandomUtil_Flx.getRandomPointInRectangle(0, 0, tX / 2, tY / 2);
				p1 = RandomUtil_Flx.getRandomPointInRectangle(tX / 2, tY / 2, tX, tY);
				pathMade = _trolley.makePath(p0.x, p0.y, p1.x, p1.y);
			}while (!pathMade);
			_trolley.start();
			
		}
		*/
		
		private function initStalker():void
		{
			_stalker = new SmartGravityBoundStalker(30, 30,collisionMap,this,theCam);
			_stalker.loadGraphic(ImgSpacemanLarge, true, true, 32, 32);
			_stalker.setTarget(player);
			_stalker.start();
			//_stalker.debuggerCamera = theCam;
			
			//animations
			_stalker.addAnimation("idle", [0]);
			_stalker.addAnimation("run", [1, 2, 3, 0], 12);
			_stalker.addAnimation("jump", [4]);
			
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
		
		private function initCrates():void
		{
						//Now lets get some crates to smash around, normally I would use an emitter for this
			//kind of scene, but for this demo I wanted to use regular sprites 
			//(See ParticlesDemo for an example of an emitter with colliding particles)
			//We'll need a group to place everything in - this helps a lot with collisions
			crateStormGroup = new FlxGroup();
			var i:int;
			for (i = 0; i < numCrates; i++) {
				crate = new ExplosiveSprite((FlxG.random() * 200) + 100, 20);
				crate.loadRotatedGraphic(cratePNG, 16, 0); //This loads in a graphic, and 'bakes' some rotations in so we don't waste resources computing real rotations later
				crate.angularVelocity = 150; // FlxG.random() * 50 - 150; //Make it spin a tad
				crate.acceleration.y = 300; //Gravity
				crate.acceleration.x = -50; //Some wind for good measure
				crate.maxVelocity.y = 500; //Don't fall at 235986mph
				crate.maxVelocity.x = 200; //"      fly  "  "
				crate.elasticity = 0.25; // FlxG.random(); //Let's make them all bounce a little bit differently
				crate.scale.x = 2;
				crate.scale.y = 2;
				crateStormGroup.add(crate);
			}
			add(crateStormGroup);
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
			// When switching between modes here, the map is reloaded with it's own data, so the positions of tiles are kept the same
			// Notice that different tilesets are used when the auto mode is switched
			autoAltBtn = new FlxButton(4, FlxG.stage.stageHeight - 24, "_ALL", function():void
			{
				trace("autoAltBtn callback");
				
				switch(collisionMap.fuseType)
				{
					case FlxTilemap.FUSETYPE_ALL:
						collisionMap.fuseType = FlxTilemap.FUSETYPE_NONE;
						autoAltBtn.label.text = "_NONE";
						break;
					case FlxTilemap.FUSETYPE_NONE:
						collisionMap.fuseType = FlxTilemap.FUSETYPE_OVERLAP;
						autoAltBtn.label.text = "_OVERLAP";
						break;
					case FlxTilemap.FUSETYPE_OVERLAP:
						collisionMap.fuseType = FlxTilemap.FUSETYPE_ALL;
						autoAltBtn.label.text = "_ALL";
						break;
						
				}
				
				var mapString:String = FlxTilemap.arrayToCSV(collisionMap.getData(false), collisionMap.widthInTiles);
				collisionMap.loadMap(mapString, auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
				collisionMap.draw();
				collisionMap.postUpdate();
				collisionMap.preUpdate();
				
			});
			add(autoAltBtn);
		
			resetBtn = new FlxButton(8 + autoAltBtn.width, FlxG.stage.stageHeight - 24, "BrickLayCLR", function():void
			{
				
				_colorChangeButtonPressTimes++;
				if (_colorChangeButtonPressTimes > 4) { _colorChangeButtonPressTimes = 0; }
			
				switch(_colorChangeButtonPressTimes)
				{
					case 0:
						resetBtn.color = 0x808080;
						_colorTileIndex = 0;
						break;
					case 1:
						resetBtn.color = 0x80FF80;
						_colorTileIndex = 1;
						break;
					//YES: I do realize we have a vertical 1-2-3 in my formulas which doesn't seem to match the case 2-3-4 below.
					case 2:
						resetBtn.color = 0xFF0000;
						_colorTileIndex = 1 * 16 + 1; //gets 16+1, first colored tile of sub-tile set #2.
						break;
					case 3:
						resetBtn.color = 0x00FF00;
						_colorTileIndex = 2 * 16 + 1;
						break;
					case 4:
						resetBtn.color = 0x00FFFF;
						_colorTileIndex = 3 * 16 + 1;
						break;
				}
	
			});
			add(resetBtn);
			resetBtn.color = 0x00FF00;
			resetBtn.visible = true;
			
			playerSwapBtn = new FlxButton(resetBtn.x + resetBtn.width, FlxG.stage.stageHeight - 24, "psSwap", function():void
			{
				trace("swap sprite button pressed");
				
				charUsed += 1; if (charUsed > CHAR_COUNT) { charUsed = 1;}
				switch(charUsed)
				{
				case 1:
					setupPlayer();
					break;
					
				case 2:
					player.loadGraphic(ImgSpacemanLarge, true, true, 32, 32);
					break;
				
				case 3:
					player.loadGraphic(ImgSpacemanHead, true, true, 32, 32);
					break;
				
				default:
					throw new Error("meow234234324");
				}
			
			});
			add(playerSwapBtn);
			playerSwapBtn.visible = false;
			
			quitBtn = new FlxButton(FlxG.stage.stageWidth - resetBtn.width - 4, FlxG.stage.stageHeight - 24, "Quit",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } ); } );
			add(quitBtn);
			
			var helpStr:String = "";
			helpStr += "Click to place tiles. SHIFT+Click to remove tiles." + "\n";
			helpStr += "SPACEBAR to make explosion"  + "\n";
			helpStr += "Arrows to move"  + "\n";
			helperTxt = new FlxText(12 + autoAltBtn.width*2, FlxG.stage.stageHeight - 30, 150, helpStr);
			add(helperTxt);
			
			//set scroll factors of HUD elements to ZERO so they remain static on the screen as the camera moves.
			autoAltBtn   .scrollFactor.x = autoAltBtn   .scrollFactor.y = 0;
			resetBtn     .scrollFactor.x = resetBtn     .scrollFactor.y = 0;
			quitBtn      .scrollFactor.x = quitBtn      .scrollFactor.y = 0;
			playerSwapBtn.scrollFactor.x = playerSwapBtn.scrollFactor.y = 0;
			//helperTxt    .scrollFactor.x = helperTxt    .scrollFactor.y = 0;
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
		
		
		private function collision_cratesVSmap(objectOrGroup1:FlxBasic, objectOrGroup2:FlxBasic):void
		{
			FlxG.overlap(objectOrGroup1, objectOrGroup2, crateOnWallAction, FlxObject.separate);
		}
		
		/* duplicate
		public override function update():void
		{
			//FlxG
			super.update();
			updateStalker();
		}
		*/
		
		override public function update():void
		{

			
			//update explosions:
			_explosionMap.update();
			
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, collisionMap);
			FlxG.collide(_stalker, collisionMap);
			
			//player collision with the crates:
			//use "FlxG.overlap" to use your own collision logic.
			FlxG.overlap(crateStormGroup, player, null, playerOnCrateAction);
			
			//Collide Sprites with world:
			collision_cratesVSmap(crateStormGroup, collisionMap);
			//FlxG.collide(crateStormGroup, collisionMap, crateOnWallAction);
		
			
			//CODE when doing WITH a camera:
			var wp:FlxPoint = FlxG.mouse.getWorldPosition(theCam);
			var sp:FlxPoint = FlxG.mouse.getScreenPosition(theCam);
			//highlightBox.x = player.x;
			//highlightBox.y = player.y;
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
					//_explosionMap.createExplosion(tileX, tileY);
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
			//	new EmulatableSprite(
				player = new EmulatableSprite(64, 220);
				player.setHumanPlayerKeyPreset(1); //make with player 2 controls.
				player.setControlInputHandler_Actions(bombLayingControlHandler);
				
				_keyboardAI = new SuperDumbKeyboardAI(player.getKeyMap(), this )
				//player.linkToComputerAI( _keyboardAI  );
				add(player);
			}
			
			player.loadGraphic(ImgSpaceman, true, true, 16, 16);
			//player.loadGraphic(ImgSpacemanLarge, true, true, 32, 32);
			
			//animations
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [1, 2, 3, 0], 12);
			player.addAnimation("jump", [4]);
			
			
		}
		
		private function setupCamera():void
		{
			trace("collisionMap.width ==" + collisionMap.width);
			//theCam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			theCam = new FlxCamera(0, 0, FlxG.stage.stageWidth, FlxG.stage.stageHeight);
			
			theCam.follow(player);
			// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
			theCam.setBounds(0,0,collisionMap.width, collisionMap.height);
			theCam.color = 0xFFCCCC; // add a light red tint to the camera to differentiate it from the other
			FlxG.addCamera(theCam);
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
			
			
			wrap(player);
		}
		
		private function bombLayingControlHandler(keyInputObject:Input, keyMap:KeyMapPOD):void
		{
			//BOMB LAYING:
			if (keyInputObject.justPressed(keyMap.action01) || keyInputObject.justPressed(keyMap.action02) )
			{   //create explosion on current tile of character.
				var gx:int = player.x / TILE_WIDTH;
				var gy:int = player.y / TILE_HEIGHT;
				if (keyInputObject.justPressed(keyMap.action01))
				{
					//trace("space!");
					
					_explosionMap.createExplosion(gx, gy,3,3,3,0);
					
					//debug: Confirm we are placing explosion in correct place:
					//collisionMap.setTile(gx, gy, FlxG.keys.SHIFT?0:2);
				}
				if (keyInputObject.justPressed(keyMap.action02))
				{
					_explosionMap.createExplosion(gx, gy, 0, 0, 0, 5);
				}
			}
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
	}
}

import org.flixel.FlxSprite;
import org.flixel.FlxTilemap;
import org.flixel.FlxPoint;
import org.flixel.FlxPath;
import org.flixel.FlxCamera;
internal class SpriteStalker extends FlxSprite
{
	public var debuggerCamera:FlxCamera;
	
	private var _targetAndMapSet:Boolean = false;
	private var _map:FlxTilemap;
	private var _target:FlxSprite;
	
	//current path stalker is on:
	private var _currentPath:FlxPath; //TODO: May not need this. Looks like sprite object stores the path it is following.
	
	private var _waitAndThink:int = 0;
	private var _waitAndThinkMaxTime:int = 30;
	
	private var _curPathSpeed:Number; //current speed along path. Check for negative to know if you are reversing.
	private var _numTimesStuckBeforeReversing:int = 10; //amount of time to wait if gets stuck in level geometry before reversing path.
	private var _stuckTimes:int = 0; //how long stalker has been stuck.
	
	public function SpriteStalker(X:int, Y:int, inMap:FlxTilemap, inTarget:FlxSprite):void
	{
		super(X, Y);
		setTargetAndMap(inMap, inTarget);
	}
	
	/**
	 * setTarget: Sets the map stalker must wander through, and the target it is chasing.
	 * @param	inMap     The map the sprite belongs to.
	 * @param	inTarget  The sprite the SpriteStalker is chasing.
	 */
	public function setTargetAndMap(inMap:FlxTilemap, inTarget:FlxSprite):void
	{
		if ( inMap == null || inTarget == null) { throw new Error("SpriteStalker:: Null Inputs"); }
		_targetAndMapSet = true;
		_map    = inMap;
		_target = inTarget;
	}
	
	public function start():void
	{
		var startPoint:FlxPoint = new FlxPoint(this.x, this.y);
		var endPoint  :FlxPoint = new FlxPoint(_target.x, _target.y);
		var maybeNewPath:FlxPath;
		maybeNewPath = _map.findPath(startPoint, endPoint);
		
		
		if (maybeNewPath != null)
		{
			_stuckTimes = 0; //stuck for zero times.
			_currentPath = maybeNewPath;
			
			followPathWrapper(_currentPath, 40);
		}
		else
		{
			_stuckTimes++;
			if (_stuckTimes >= _numTimesStuckBeforeReversing)
			{
				//go REVERSE down the path. //TODO: This isn't quite working. Figure out how to REVERSE your path.
				_stuckTimes = 0;
				followPathWrapper(_currentPath, -20);
			}
		}
	}
	
	private function followPathWrapper(thePath:FlxPath, theSpeed:Number):void
	{
		_curPathSpeed = theSpeed;
		this.followPath(thePath, theSpeed);
	}
	
	public override function draw():void
	{
		super.draw();
		if (this.path != null)
		{
			this.path.drawDebug(debuggerCamera);
		}
	}
	

	
	private function updateStalker():void
	{
		//trace("stalker update");
		
		if (this.path == null)
		{
			
		}
		else
		if (this.pathSpeed == 0)
		{
			
		}
		
		if (this.path==null || this.pathSpeed == 0)
		{
			if (_waitAndThink == 0)
			{
				if (this.path != null) 
				{ 
					this.stopFollowingPath(false); 
				}
				this.velocity.x = this.velocity.y = 0;
			}
			
			_waitAndThink++;
			if (_waitAndThink >= _waitAndThinkMaxTime)
			{
				_waitAndThink = 0;
				start();
			}
		};
	}
}


