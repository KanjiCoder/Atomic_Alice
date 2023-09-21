package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.miniGames.spiralGraph.SpiralGraphVectorGame;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var _miniGame:SpiralGraphVectorGame;
		
		private var _bm:BitmapData = new BitmapData(30, 30, true, 0xFF00FF00);
		private var _bmVis:Bitmap;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//_bmVis = new Bitmap(_bm);
			//this.addChild(_bmVis);
			
			_miniGame = new SpiralGraphVectorGame(300, 300);
			this.addChild( _miniGame );
		}
		
	}//class
}//package