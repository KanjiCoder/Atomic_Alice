package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.miniGames.fireBallCannon.FireBallCannonGame;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		[Embed(source = 'AutoGigerTileSet.PNG')]private static var AUTO_TILE_STRIP:Class;
		[Embed(source = 'Pack01.PNG')]private static var PACK_01:Class;
		[Embed(source = 'CannonBarrel.PNG')]private static var BARREL:Class;
		
		private var _game:FireBallCannonGame;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_game = new FireBallCannonGame();
			_game.init(this.stage, new BARREL().bitmapData, new AUTO_TILE_STRIP().bitmapData, new PACK_01().bitmapData);
			//_game.turnDebugDrawON();
			
			
			trace('hi');
		}
		
	}//class
}//package