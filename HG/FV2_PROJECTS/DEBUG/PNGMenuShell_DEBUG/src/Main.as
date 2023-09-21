package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Mouse;
	import JM_EXT.org.flixel.extendedFlixelClasses.FlxGame_EXT;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.UI.pngBasedUIS.creditsMenu.CreditsMenu;
	import JM_LIB.UI.menus.pngMenuShell.PNGMenuShell;
	import JM_GAME_LIBS.flixelBasedGames.BasicGameInitRegistry;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//var state:FlxState = new FlxState();
			
			var fGame:FlxGame_EXT = new FlxGame_EXT(this.stage.stageWidth, this.stage.stageHeight, FlxState, 1, 60, 30);
			
			//var cursor:BitmapData = new BitmapData(1, 1, 0x00);
			
			fGame.useSystemCursor = true;
			FlxG.mouse.hide();
			flash.ui.Mouse.show();
			
			BasicGameInitRegistry.initBasics(fGame, 30, 1);
			this.addChild( fGame );
			
			var menu:CreditsMenu = CreditsMenu.self;
			this.addChild(menu);
			
			
			
		}
		
	}
	
}
import flash.display.Bitmap;

internal class TransHack extends Bitmap
{
	public var meow:flash.display.BitmapData = new flash.display.BitmapData(1, 1, true, 0x00);
	
	public function TransHack()
	{
		super( meow );
	}
}