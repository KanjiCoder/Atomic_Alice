package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_EXT.org.flixel.systems.kaboom.explosionMapWithBombs.ExplosionMapSnapBomb;
	import JM_EXT.org.flixel.systems.kaboom.explosionMapWithBombs.ExplosionMapWithBombs;
	
	import flash.sampler.getSize;
	
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
			//var eMap:ExplosionMapWithBombs
			var cSize:int = getSize(ExplosionMapSnapBomb); //2641
			trace("size of class == " + cSize);
		}
		
	}
	
}