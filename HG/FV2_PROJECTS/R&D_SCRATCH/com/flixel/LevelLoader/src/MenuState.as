package
{
	import JM_EXT.org.flixel.extendedFlixelClasses.FlxState_EXT;
	import org.flixel.*;
	import JM_GAME_LIBS.flixelBasedGames.gameRegistries.bombermanZombieEscapeRegistry.GameReg;

	public class MenuState extends FlxState_EXT
	{
		override public function create():void
		{
			if (GameReg.currentLevelNumber == 0)
			{
				showMainIntroScreen();
			}
			else
			{
				if (GameReg.allLevelsWon)
				{
					GameReg.allLevelsWon = false;
					GameReg.currentLevelNumber = 0;
					showWinEntireGameScreen();
				}
				else
				{
					showLevelIntroScreen();
				}
			}
			
			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();

			if (FlxG.mouse.justPressed() || FlxG.keys.any())
			{
				var myPlayState:FlxState;
				if (GameReg.playState != null)
				{
					myPlayState = GameReg.playState;
				}
				else
				{
					myPlayState = new PlayState();
				}
				
				FlxG.switchState(myPlayState);
				//FlxG.switchState(new PlayState());
			}
		}
		
		private function showWinEntireGameScreen():void
		{
			var sw:int = FlxG.stage.stageWidth;
			var sh:int = FlxG.stage.stageHeight;
			var t:FlxText;
			t = new FlxText(0,sh/2-20,sw,"GAME WON!");
			t.size = 32;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(0,sh/2+40,sw,"Reset: Level Zero");
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(sw/2-100,sh-30,200,"press any key");
			t.size = 16;
			t.alignment = "center";
			add(t);
		}
		
		private function showLevelIntroScreen():void
		{
			var sw:int = FlxG.stage.stageWidth;
			var sh:int = FlxG.stage.stageHeight;
			var t:FlxText;
			t = new FlxText(0,sh/2-20,sw,"Next Level:");
			t.size = 32;
			t.alignment = "center";
			add(t);
			
			var levelString:String = "L" + GameReg.currentLevelNumber.toString();
			t = new FlxText(0,sh/2+40,sw,levelString);
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(sw/2-100,sh-30,200,"press any key");
			t.size = 16;
			t.alignment = "center";
			add(t);
		}
		
		private function showMainIntroScreen():void
		{
			var sw:int = FlxG.stage.stageWidth;
			var sh:int = FlxG.stage.stageHeight;
			var t:FlxText;
			t = new FlxText(0,sh/2-20,sw,"BZE: Level Load");
			t.size = 32;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(0,sh/2+40,sw,"JMadison@DigiPen.edu");
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(sw/2-100,sh-30,200,"click to test");
			t.size = 16;
			t.alignment = "center";
			add(t);
		}
		
	}
}
