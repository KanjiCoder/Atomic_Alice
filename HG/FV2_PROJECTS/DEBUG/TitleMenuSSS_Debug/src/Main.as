package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.UI.pngBasedUIS.titleMenu.TitleMenuSSS;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		private var _menu:TitleMenuSSS;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_menu = TitleMenuSSS.self;
			this.addChild(_menu);
		}
		
	}//class
}//package