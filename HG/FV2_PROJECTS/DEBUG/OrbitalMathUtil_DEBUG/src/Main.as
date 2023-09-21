package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.chemistry.ElementEntry;
	import JM_LIB.utils.math.chemistry.OrbitalMathUtil;
	import JM_LIB.utils.chemistry.ElementNameUtil;
	
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
			
			var ccc:Vector.<int>;
			ccc = OrbitalMathUtil.getOrbitalElectronCounts(88);
			trace("hi");
			
			var dex:int = 293;
			var nm:ElementEntry = ElementNameUtil.getElementEntryByIndex(dex);
			trace("hi");
		}
		
	}//class
}//package