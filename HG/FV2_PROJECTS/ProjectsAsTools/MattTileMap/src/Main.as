package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.toolSystems.autoTilePainter.ATPCore;
	import JM_LIB.toolSystems.autoTilePainter.AutoTilePainter;
	import JM_LIB.toolSystems.autoTilePainter.constants.ZoomConstantsATP;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		//[Embed(source = 'AutoGigerTileSet.PNG')]private static var AUTO_TILE_STRIP:Class;
		[Embed(source = 'rough_geometal.png')]private static var AUTO_TILE_STRIP:Class;
		[Embed(source = 'Pack01.PNG')]private static var PACK_01:Class;
		
		/** The main tool class we are making an instance of and interacting with. **/
		private var _painter:AutoTilePainter;
		
		// A background sprite put behind the entire application so that we do not get roll-out
		//private var _bgSprite:Sprite;
		
		/** Core functions-&-variables of AutoTilePainter **/
		private var _c:ATPCore;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var inStage:Stage = this.stage;
			if (inStage == null) { throw new Error("Stage reference is null"); }
			
			
			
			_painter = new AutoTilePainter(this);
			_c       = _painter.core;
			_c.setAutoTileStrip(new AUTO_TILE_STRIP().bitmapData);
			_c.setStripZoom(ZoomConstantsATP.ZOOM_4X);
	
			//this.addChild(_painter);
			
		}
		
	}//class
}//package