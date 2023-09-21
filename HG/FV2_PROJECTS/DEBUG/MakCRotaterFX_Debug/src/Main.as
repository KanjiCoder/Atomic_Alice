package 
{
	import net.wonderFL.effects.effectsInMotion.makCRotaters.MakCRotaterAnimFX;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		private var _animFX:MakCRotaterAnimFX;
		private var _hasAnimFX:Boolean = false;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_animFX = new MakCRotaterAnimFX();
			_hasAnimFX = true;
			this.addChild(_animFX);
			
			this.addEventListener(Event.ENTER_FRAME, autoUpdate);
		}
		
		private function autoUpdate(evt:Event):void
		{
			_animFX.update();
		}
	}//class
}//package