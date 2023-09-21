package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		override public function create():void
		{
			var sw:int = FlxG.stage.stageWidth;
			var sh:int = FlxG.stage.stageHeight;
			var t:FlxText;
			t = new FlxText(0,sh/2-20,sw,"Stalker Droid");
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
			
			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();

			if(FlxG.mouse.justPressed())
				FlxG.switchState(new PlayState());
		}
	}
}
