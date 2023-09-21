package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.miniGames.autoMirror.components.tileMapAMG.TileMapAMG_TOOL;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var _autoTool:TileMapAMG_TOOL;
		
		[Embed(source = 'AutoTileStrip.PNG')]private static var AUTO_TILE_STRIP:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_autoTool = new TileMapAMG_TOOL();
			_autoTool.initUsingMapDims(30, 30, 16, 16);
			_autoTool.setAutoTileStrip( new AUTO_TILE_STRIP().bitmapData, 1 );
			
			this.addChild(_autoTool);
		}
		
	}//class
}//package