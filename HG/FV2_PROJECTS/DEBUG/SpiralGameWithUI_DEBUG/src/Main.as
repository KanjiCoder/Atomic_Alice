package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.miniGames.spiralGraph.SpiralGraphGameWithUI;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var _miniGame:SpiralGraphGameWithUI;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_miniGame = new SpiralGraphGameWithUI(640, 480, this.stage);
			this.addChild(_miniGame);
		}
		
	}//class
}//package