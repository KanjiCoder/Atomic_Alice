package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.wonderFL.effects.effectsInMotion.bitFire.BitFire;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		private var _fx:BitFire;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_fx =  new BitFire();
			this.addChild(_fx);
			
		}
		
	}//class
}//package