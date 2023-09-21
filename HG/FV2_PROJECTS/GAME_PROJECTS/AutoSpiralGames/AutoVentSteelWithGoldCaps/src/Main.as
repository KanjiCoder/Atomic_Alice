package 
{
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.miniGames.autoMirror.AutoMirrorGameWithUI;
	
	
	
	/**
	 * BAUXITE STRIP GAME
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'GoldCapVentBeams.PNG')]private static var AUTO_TILE_STRIP:Class;
		
		private var _miniGame:AutoMirrorGameWithUI;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var autoTileStripBitmap:BitmapData = new AUTO_TILE_STRIP().bitmapData;
			_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, autoTileStripBitmap);
			//_miniGame.setLogoText("BAUXITE TEST");
			this.addChild(_miniGame);
			
		}
		
	}//class
}//package