package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.loading.bitmapDataHandler.BitmapDataHandler;
	import JM_LIB.toolSystems.userPNGLoader.UserPNGLoader;
	
	
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends Sprite 
	{
		
		public var _bmVis:Bitmap;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var up:UserPNGLoader = new UserPNGLoader();
			var handler:BitmapDataHandler = new BitmapDataHandler();
			handler.setPushFunction( onLoaded );
			up.bmHandler = handler;
			
			up.canSelectMultipleFiles = false;
			up.promptUser();
			
			
		}
		
		private function onLoaded(bm:BitmapData):void
		{
			_bmVis = new Bitmap( bm );
			this.addChild( _bmVis );
		}
		
	}
	
}