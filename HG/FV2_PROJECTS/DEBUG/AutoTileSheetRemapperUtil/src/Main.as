package 
{
	import JM_LIB.utils.AutoTileSheetRemapperUtil;
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
			
			/*
			var L8  :int = 8 ; //BIN 1000  //Only connection to the left.
			var R2  :int = 2 ; //BIN 0010  //Only connection to the right.
			var LR10:int = 10; //BIN 1010  //BOTH Connected.
			var nr:int;
			for (var n:int = 0; n < 16; n++)
			{
				nr  = ((n & L8) >> 3)*2   +   ((n & R2) >> 1)
				
		
				trace("n==" + n + " remap==" + nr );
			
			}
			*/
			
			for (var i:int = 0; i < 240; i++)
			{
				trace("i==" + i + " remapped == " + AutoTileSheetRemapperUtil.toPlatformTileSheetIndex( i ) );
			}
			
			
		}
		
	}
	
}