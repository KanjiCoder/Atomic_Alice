package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import JM_EXT.org.as3commons.embedd.embeddedBitmapClassMaker.BitmapAssetWrapper;
	
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
			
			var bm:BitmapData = new BitmapData(33, 77, true, 0xFF00FF00);
			BitmapAssetWrapper.cacheBitmapUsingClassName(bm, "hello");
			var bmaw:BitmapAssetWrapper = new BitmapAssetWrapper();
			
			trace("hello");
		}
		
	}
	
}