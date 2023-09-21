package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.UI.pngBasedUIS.passMenu.PassMenuSSS;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		private var _menu:PassMenuSSS;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var uiBounds:Rectangle = new Rectangle(0, 0, 640, 480);
			_menu = PassMenuSSS.self;
			this.addChild(_menu);
		}
		
	}//class	
}//package