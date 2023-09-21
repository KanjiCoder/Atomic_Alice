package 
{
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import JM_LIB.utils.fileSystem.wildCardFileOpener.WildCardFileOpener;
	
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
			doStuff();
		}
		
		private function doStuff():void
		{
			
			//create a zip file:
			
			var opener:WildCardFileOpener = new WildCardFileOpener();
			opener.set_bmpSourceHandlerFN(handleBM, "handleBM");
			opener.set_txtSourceHandlerFN(handleTX, "handleTX");
			opener.set_zipSourceHandlerFN(handleZP, "handleZP");
			opener.openUsingDialog();
		}
		
		
		private function handleBM(inBM:BitmapData):void
		{
			trace("hi");
		}
		
		private function handleTX(inTX:String):void
		{
			trace("hi");
		}
		
		private function handleZP(inZP:ByteArray):void
		{
			trace("hi");
		}
		
	
		
	}//class
}//package