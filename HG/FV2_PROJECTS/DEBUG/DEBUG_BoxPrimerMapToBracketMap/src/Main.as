package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.worldMapTools.mapDecoderEncoder.BoxPrimerMapToBracketMapUtil;
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends Sprite 
	{
		[Embed(source = '/worldMaps/MainWorldMap.png')]private static var MAP :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var bm:BitmapData = (new MAP()).bitmapData;
			BoxPrimerMapToBracketMapUtil.convert( bm );
			
			var bmVis:Bitmap = new Bitmap( bm );
			bmVis.scaleX = 4;
			bmVis.scaleY = 4;
			this.addChild( bmVis );
		}
		
	}
	
}