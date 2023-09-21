package
{
	import JM_GAME_LIBS.flixelBasedGames.BasicGameInitRegistry;
	import org.flixel.*;
	[SWF(width="400", height="300", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		//TODO: Enforce game's width in tiles being divisible by 8.
		
		public const GAME_WORLD_WIDTH :int = 800;
		public const GAME_WORLD_HEIGHT:int = 600; 

		public const FPS:int = 30; //game frames per second.
		public const SPEED_MULTIPLIER:Number = 30;
		
		public function Main()
		{   
			super(400, 300, MenuState, 1, FPS, FPS);
			BasicGameInitRegistry.initBasics(this,GAME_WORLD_WIDTH, GAME_WORLD_HEIGHT, FPS, SPEED_MULTIPLIER);
			
		}
	}
}
