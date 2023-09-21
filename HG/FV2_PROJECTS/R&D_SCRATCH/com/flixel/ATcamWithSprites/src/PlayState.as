package
{
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import JM_EXT.org.flixel.systems.explosionMap.ExplosionMap;
	import org.flixel.*;
	import JM_LIB.utils.frameRateUtil.FrameRateUtil;

	public class PlayState extends FlxState
	{
		
		
		
		//TODO
		//Make all speeds relative to the frame rate.
		//That way, changing framerate willl not change relative appearance of motion.
		public const FPS:int = 25; //game frames per second.
		public const SPEED_MULTIPLIER:Number = 30;
		private var getUPF:Function = FrameRateUtil.getUnitsPerFrame;
		
		private var UPS_200:Number; //200 units per second.
		
		//////////////  COLLISION CRATES CODE:  //////////////////////////
		//We'll reuse this when we make a bunch of crates
		private var crate:FlxSprite;
		[Embed(source = 'assets/crate.png')] private var cratePNG:Class;
		//We'll make 100 per group crates to smash about
		private var numCrates:int = 200;
		//these are the groups that will hold all of our crates
		private var crateStormGroup:FlxGroup;
		//-----------   COLLISION CRATES CODE:  -------------------------- 
		
		// Tileset that works with AUTO mode (best for thin walls)
		[Embed(source = 'auto_tiles.png')]private static var auto_tiles:Class;
		
		// Tileset that works with ALT mode (best for thicker walls)
		[Embed(source = 'alt_tiles.png')]private static var alt_tiles:Class;
		
		// Tileset that works with OFF mode (do what you want mode)
		[Embed(source = 'empty_tiles.png')]private static var empty_tiles:Class;
		
		[Embed(source = 'map_4x_auto.txt' , mimeType = 'application/octet-stream')]private static var default_auto :Class;
		[Embed(source = 'map_4x_alt.txt'  , mimeType = 'application/octet-stream')]private static var default_alt  :Class;
		[Embed(source = 'map_4x_empty.txt', mimeType = 'application/octet-stream')]private static var default_empty:Class;
		

		[Embed(source="spaceman.png")] private static var ImgSpaceman:Class;
		
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
		private var player:FlxSprite;
		
		// Some interface buttons and text
		private var autoAltBtn:FlxButton;
		private var resetBtn:FlxButton;
		private var quitBtn:FlxButton;
		private var helperTxt:FlxText;
		
		override public function create():void
		{
			FlxG.framerate = FPS;
			FlxG.flashFramerate = FPS;
			FrameRateUtil.fps = FPS;
			FrameRateUtil.speedMultiplier = SPEED_MULTIPLIER;
			getUPF = FrameRateUtil.getUnitsPerFrame;
			
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
			
			highlightBox = new FlxObject(0, 0, TILE_WIDTH, TILE_HEIGHT);
			
			setupPlayer();
			setupCamera();
			initCrates();
			makeHUD();
		}
		
		private function initSpeedConstants():void
		{
			UPS_200 = getUPF(200); //UPS_200 = 200 "units per second".
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
				crate = new FlxSprite((FlxG.random() * 200) + 100, 20);
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
		
		private function makeHUD():void
		{
			// When switching between modes here, the map is reloaded with it's own data, so the positions of tiles are kept the same
			// Notice that different tilesets are used when the auto mode is switched
			autoAltBtn = new FlxButton(4, FlxG.stage.stageHeight - 24, "AUTO", function():void
			{
				trace("autoAltBtn callback");
				trace("collisionMap.auto ==" + collisionMap.auto);
				trace("collisionMap.widthInTiles == " + collisionMap.widthInTiles);
				switch(collisionMap.auto)
				{
					case FlxTilemap.AUTO:
						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles), //collisionMap.widthInTiles
							alt_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.ALT);
						autoAltBtn.label.text = "ALT";
						break;
						
					case FlxTilemap.ALT:
						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles),
							empty_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
						autoAltBtn.label.text = "OFF";
						break;
						
					case FlxTilemap.OFF:
						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles),
							auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
						autoAltBtn.label.text = "AUTO";
						break;
				}
				trace("after:");
				trace("collisionMap.auto ==" + collisionMap.auto);
				trace("collisionMap.widthInTiles == " + collisionMap.widthInTiles);
				trace("--------------------");
				
			});
			add(autoAltBtn);
			
			resetBtn = new FlxButton(8 + autoAltBtn.width, FlxG.stage.stageHeight - 24, "Reset", function():void
			{
				trace("reset button pressed");
				switch(collisionMap.auto)
				{
					case FlxTilemap.AUTO:
						collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
						player.x = 64;
						player.y = 220;
						break;
						
					case FlxTilemap.ALT:
						collisionMap.loadMap(new default_alt(), alt_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.ALT);
						player.x = 64;
						player.y = 128;
						break;
						
					case FlxTilemap.OFF:
						collisionMap.loadMap(new default_empty(), empty_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
						player.x = 64;
						player.y = 64;
						break;
				}
			});
			add(resetBtn);
			
			quitBtn = new FlxButton(FlxG.stage.stageWidth - resetBtn.width - 4, FlxG.stage.stageHeight - 24, "Quit",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } ); } );
			add(quitBtn);
			
			helperTxt = new FlxText(12 + autoAltBtn.width*2, FlxG.stage.stageHeight - 30, 150, "Click to place tiles\nShift-Click to remove tiles\nArrow keys to move");
			add(helperTxt);
			
			//set scroll factors of HUD elements to ZERO so they remain static on the screen as the camera moves.
			autoAltBtn.scrollFactor.x = autoAltBtn.scrollFactor.y = 0;
			resetBtn  .scrollFactor.x = resetBtn  .scrollFactor.y = 0;
			quitBtn   .scrollFactor.x = quitBtn   .scrollFactor.y = 0;
			helperTxt .scrollFactor.x = helperTxt .scrollFactor.y = 0;
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
			
			//b.velocity.x = 0 - b.velocity.x;
			//b.velocity.y = 0 - b.velocity.y;
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
		
		override public function update():void
		{
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, collisionMap);
			
			//player collision with the crates:
			//use "FlxG.overlap" to use your own collision logic.
			FlxG.overlap(crateStormGroup, player, null, playerOnCrateAction);
			
			//Collide Sprites with world:
			FlxG.collide(crateStormGroup, collisionMap, crateOnWallAction);
			//FlxG.collide(crateStormGroup, crateStormGroup); //make crates collide with themselves.
			
			//CODE when doing WITH a camera:
			var wp:FlxPoint = FlxG.mouse.getWorldPosition(theCam);
			var sp:FlxPoint = FlxG.mouse.getScreenPosition(theCam);
			//highlightBox.x = player.x;
			//highlightBox.y = player.y;
			highlightBox.x = Math.floor(wp.x / TILE_WIDTH) * TILE_WIDTH;
			highlightBox.y = Math.floor(wp.y / TILE_HEIGHT) * TILE_HEIGHT;
			
			if (FlxG.mouse.pressed())
			{
				// FlxTilemaps can be manually edited at runtime as well.
				// Setting a tile to 0 removes it, and setting it to anything else will place a tile.
				// If auto map is on, the map will automatically update all surrounding tiles.
				collisionMap.setTile(wp.x / TILE_WIDTH, wp.y / TILE_HEIGHT, FlxG.keys.SHIFT?0:1);
			}
			
			updatePlayer();
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
			player = new FlxSprite(64, 220);
			player.loadGraphic(ImgSpaceman, true, true, 16);
			
			//bounding box tweaks.
			//If you subtract 1 pixel from the entire perimeter of a 16x16 box, you get a 14x14 box.
			//bounding box tweak to help collision with level. Offset of 1 to re-center pivot after altering bounding box.
			player.width = 14;
			player.height = 14;
			player.offset.x = 1;
			player.offset.y = 1;
			
			//basic player physics
			player.drag.x         = getUPF( 640 );
			player.acceleration.y = getUPF( 420 );
			player.maxVelocity .x = getUPF( 200 );
			player.maxVelocity .y = getUPF( 200 );
			
			//animations
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [1, 2, 3, 0], 12);
			player.addAnimation("jump", [4]);
			
			add(player);
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
			wrap(player);
			
			//MOVEMENT
			player.acceleration.x = 0;
			if(FlxG.keys.LEFT)
			{
				player.facing = FlxObject.LEFT;
				player.acceleration.x -= player.drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				player.facing = FlxObject.RIGHT;
				player.acceleration.x += player.drag.x;
			}
			if(FlxG.keys.justPressed("UP") && player.velocity.y == 0)
			{
				player.y -= 1;
				player.velocity.y = -UPS_200;
			}
			
			//ANIMATION
			if(player.velocity.y != 0)
			{
				player.play("jump");
			}
			else if(player.velocity.x == 0)
			{
				player.play("idle");
			}
			else
			{
				player.play("run");
			}
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
