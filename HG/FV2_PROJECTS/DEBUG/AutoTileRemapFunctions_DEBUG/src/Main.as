package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_EXT.org.flixel.utils.pngLevelMapUtils.AutoTileRemapFunctions;
	
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
			
			var remapVal:int;
			var remap2:int;
			var r3:int;
			for (var i:int = 0; i <= 256; i++)
			{
				remapVal = AutoTileRemapFunctions.getSetNumber(i);
				remap2   = AutoTileRemapFunctions.getTileValue(remapVal);
				r3       = AutoTileRemapFunctions.getSetNumber(remap2);
				trace("i[" + i + "]---> " + remapVal + "----> " + remap2 + "---->" + r3);
			}
			
		}
		
	}
	
}