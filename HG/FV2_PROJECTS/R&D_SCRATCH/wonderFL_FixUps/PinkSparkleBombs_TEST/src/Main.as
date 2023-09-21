package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.graphics.fx.menuFX.sparkleBomb.PinkSparkleBombsClickSurface;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		private var _party:PinkSparkleBombsClickSurface;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			beginSparkleParty();
		}
		
		
		private function beginSparkleParty():void
		{
			_party = new PinkSparkleBombsClickSurface();
			this.addChild(_party);
		}
		
	}//class
}//package