package
{
	import org.flixel.*;
	[SWF(width="400", height="300", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public const GAME_WORLD_WIDTH:int = 800;
		public const GAME_WORLD_HEIGHT:int = 600; 
		
		public function Main()
		{
			super(GAME_WORLD_WIDTH, GAME_WORLD_HEIGHT, MenuState, 1, 20, 20);
		}
	}
}
