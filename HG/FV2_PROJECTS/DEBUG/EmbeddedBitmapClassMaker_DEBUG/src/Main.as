package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import JM_EXT.org.as3commons.embedd.embeddedBitmapClassMaker.EmbeddedBitmapClassMaker;
	import JM_EXT.org.as3commons.embedd.embeddedSoundClassMaker.EmbeddedSoundClassMaker; //why this not found????
	
	import JM_EXT.org.as3commons.embedd.embeddedSoundClassMaker.SoundAssetWrapper; //this can be found...
	
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
			var ebcm:EmbeddedBitmapClassMaker = new EmbeddedBitmapClassMaker();
			var bm:BitmapData = new BitmapData(5, 5, true, 0xFF00FF00);
			ebcm.makeClass("SMILE_BM", bm);
			
			trace("done?");
		}
		
	}
	
}