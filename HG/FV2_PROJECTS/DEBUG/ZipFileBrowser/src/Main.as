package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.components.zipLevelBrowser.ZipLevelBrowser;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		public var zlb:ZipLevelBrowser;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			zlb = new ZipLevelBrowser();
			zlb.openDialogToOpenZip(onOpened, "onOpened");
			
		}
		
		private function onOpened():void
		{
			zlb.createSelectionSetsForEachDifficultyMode();
			zlb.renameSelectionSet("levelMap", "");
			
		}
		
	}//class
}//package