package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.UI.pngBasedUIS.complianceMenu.ComplianceMenuSSS;
	//import GameSpecificRegistries.Bomber01.FontReg;
	import GameSpecificRegistries.Bomber01.FontReg;
	
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
			
			//var uiBounds:Rectangle = new Rectangle(0, 0, 640, 480);
			//var cMenu:ComplianceMenuSSS = new ComplianceMenuSSS(uiBounds);
			var cMenu:ComplianceMenuSSS = ComplianceMenuSSS.self;
			this.addChild(cMenu);
		}
		
	}
	
}