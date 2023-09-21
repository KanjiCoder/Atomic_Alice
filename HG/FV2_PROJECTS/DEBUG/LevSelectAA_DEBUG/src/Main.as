package 
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.UI.pngBasedUIS.levelSelectMenu.LevSelectAA;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		private var _levSel:LevSelectAA;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_levSel = LevSelectAA.getSelf();
			this.addChild(_levSel);
		}
		
	}//class
}//package