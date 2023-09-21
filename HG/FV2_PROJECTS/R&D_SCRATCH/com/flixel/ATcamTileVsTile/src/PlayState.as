package
{
	
	//NOTE: Looks like colliding two tile maps together is NOT the answer.
	
	import flash.display.BlendMode;
	import org.flixel.*;
	import org.flixel.system.FlxTile;

	public class PlayState extends FlxState
	{
		
		
		// Tilesets for both worldMap and explosionMaps
		[Embed(source = 'map1_tiles.png')]private static var Tiles1:Class;
		[Embed(source = 'map2_tiles.png')]private static var Tiles2:Class;
		
		//The two maps we are going to test for collision.
		[Embed(source = 'map1.txt', mimeType = 'application/octet-stream')]private static var Map1:Class;
		[Embed(source = 'map2.txt', mimeType = 'application/octet-stream')]private static var Map2:Class;
		

		[Embed(source = "spaceman.png")] private static var ImgSpaceman:Class;
		
		private var onGeoMap:Boolean = true;
		
		// Some static constants for the size of the tilemap tiles
		private const TILE_WIDTH:uint = 16;
		private const TILE_HEIGHT:uint = 16;
		
		// The FlxTilemap we're using
		private var mapRef:FlxTilemap; //the worldMap or the explosionMap.
		private var worldMap:FlxTilemap;
		private var explosionMap:FlxTilemap; //map of explosions.
		
		// make camera:
		private var theCam:FlxCamera;
		
		// Box to show the user where they're placing stuff
		private var highlightBox:FlxObject;
		
		// Player modified from "Mode" demo
		private var player:FlxSprite;
		
		// Some interface buttons and text
		private var mapSetBtn:FlxButton;
		private var resetBtn:FlxButton;
		private var quitBtn:FlxButton;
		private var helperTxt:FlxText;
		
		override public function create():void
		{
			FlxG.framerate = 50;
			FlxG.flashFramerate = 50;
			
			// Creates a new tilemap with no arguments
			worldMap = new FlxTilemap();
			explosionMap = new FlxTilemap();
			mapRef   = worldMap;
	
			
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
			worldMap    .loadMap(new Map1(), Tiles1, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			explosionMap.loadMap(new Map2(), Tiles2, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			add(worldMap);
			add(explosionMap);
			
			highlightBox = new FlxObject(0, 0, TILE_WIDTH, TILE_HEIGHT);
			
			setupPlayer();
			setupCamera();
			
			makeHUD();
		}
		
		public function makeHUD():void
		{
			// When switching between modes here, the map is reloaded with it's own data, so the positions of tiles are kept the same
			// Notice that different tilesets are used when the auto mode is switched
			mapSetBtn = new FlxButton(4, FlxG.stage.stageHeight - 24, "GEO MAP", function():void
			{
				trace("mapSetBtn callback");
				onGeoMap = !onGeoMap; //are you on the geometry map, or the explosion map?
				if (onGeoMap)
				{
					mapSetBtn.label.text = "ON GeoMap";
					mapRef = worldMap;
				}
				else
				{
					mapSetBtn.label.text = "ON ExpMap";
					mapRef = explosionMap;
				}
				
			});
			add(mapSetBtn);
			
			resetBtn = new FlxButton(8 + mapSetBtn.width, FlxG.stage.stageHeight - 24, "Reset", function():void
			{
				trace("reset callback");
			});
			add(resetBtn);
			
			quitBtn = new FlxButton(FlxG.stage.stageWidth - resetBtn.width - 4, FlxG.stage.stageHeight - 24, "Quit",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } ); } );
			add(quitBtn);
			
			helperTxt = new FlxText(12 + mapSetBtn.width*2, FlxG.stage.stageHeight - 30, 150, "Click to place tiles\nShift-Click to remove tiles\nArrow keys to move");
			add(helperTxt);
			
			//set scroll factors of HUD elements to ZERO so they remain static on the screen as the camera moves.
			mapSetBtn.scrollFactor.x = mapSetBtn.scrollFactor.y = 0;
			resetBtn  .scrollFactor.x = resetBtn  .scrollFactor.y = 0;
			quitBtn   .scrollFactor.x = quitBtn   .scrollFactor.y = 0;
			helperTxt .scrollFactor.x = helperTxt .scrollFactor.y = 0;
		}
		
		//handles collision between worldMap and explosionMap
		private function whenWorldsCollide(t1:FlxBasic, t2:FlxBasic):void
		{
			//var tb1:FlxTileblock = t1 as FlxTileblock;
			var tb1:FlxTile      = t1 as FlxTile;
			var tb2:FlxTile      = t2 as FlxTile;
			
			//trace("colliding");
			
			//make them both erase each other.
			//tb = FlxTile type:
			//tb1.tilemap.setTileByIndex(tb1.mapIndex, 0);
			//tb2.tilemap.setTileByIndex(tb2.mapIndex, 0);	
		}
		
		override public function update():void
		{
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, worldMap);
			
			FlxG.overlap(explosionMap, worldMap, null, whenWorldsCollide);
			
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
				mapRef.setTile(wp.x / TILE_WIDTH, wp.y / TILE_HEIGHT, FlxG.keys.SHIFT?0:1);
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
			player.drag.x = 640;
			player.acceleration.y = 420;
			player.maxVelocity.x = 200;
			player.maxVelocity.y = 200;
			
			//animations
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [1, 2, 3, 0], 12);
			player.addAnimation("jump", [4]);
			
			add(player);
		}
		
		private function setupCamera():void
		{
			trace("worldMap.width ==" + worldMap.width);
			//theCam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			theCam = new FlxCamera(0, 0, FlxG.stage.stageWidth, FlxG.stage.stageHeight);
			
			theCam.follow(player);
			// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
			theCam.setBounds(0,0,worldMap.width, worldMap.height);
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
				player.velocity.y = -200;
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
			obj.x = (obj.x + obj.width / 2 + worldMap.width) % worldMap.width - obj.width / 2;
			obj.y = (obj.y + obj.height / 2) % worldMap.height - obj.height / 2;
		}
	}
}
