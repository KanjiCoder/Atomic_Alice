package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_EXT.com.bit101.debugUI.ARGBSlider;
	
	/**
	 * ...
	 * @author 
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
			
			var p:ARGBSlider = new ARGBSlider(stage);
			this.addChild(p);
			p.x = 100;
		}
		
		public function test():void
		{
			
		}	
		
	}//class
}//package