package 
{
	//MetaData for the size of teh SWF file.
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	import JM_EXT.org.flixel.extendedFlixelClasses.FlxGame_EXT;
	import JM_GAME_LIBS.flixelBasedGames.floorSmasher.registries.BasicReg;
	import JM_GAME_LIBS.flixelBasedGames.BasicGameInitRegistry;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_GAME_LIBS.flixelBasedGames.floorSmasher.states.IntroMenuState;
	
	/**
	 * Design:
		 * 1 Level. The level is filled with scaffolding.
		 * 2 Tile maps.
		 *       1. The map with scaffolding.
		 *       2. The map that is moving downward and can collide with you.
		 * 1 PNG MAP:
			 * Use 2 bit per all channels color. RGB3 color.
			 * 00, 01, 10, 11. RGB and BLACK.
			 * Could use to be : Obstacles, Powerups, and Bashable Bricks.
			 * Or some other combination. But right now... Just use BLACK AND RED to define your maps.
			 * Black = nothing. Red = tile to avoid.
		 * Character always starts in the middle of the game.
		 * 
		 * MAP: Using 480x480 game. And 16x16 tiles, your main tilemap should be 30x30.
		 *      Your crasher/mov map should be 30 wide and whatever tall.
		 * 
	 * @author JMim
	 */
	public class Main extends Sprite 
	{
		
		private var fGame:FlxGame_EXT;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point
			fGame = new FlxGame_EXT(BasicReg.GAME_WID, BasicReg.GAME_HIG, IntroMenuState, 1, BasicReg.FPS, BasicReg.FPS);
			BasicGameInitRegistry.initBasics(fGame, BasicReg.FPS, BasicReg.SPEED_MULTIPLIER);
			this.addChild(fGame);
			
			
		}
		
	}//class
}//package