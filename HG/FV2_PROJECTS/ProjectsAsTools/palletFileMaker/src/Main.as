package 
{
	import JM_EXT.org.flixel.utils.pngLevelMapUtils.PNGColorMapNoAlpha;
	import flash.display.Sprite;
	import flash.events.Event;
	
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
			PNGColorMapNoAlpha.getPalletFile(false, true);
		}
		
	}//class
}//package