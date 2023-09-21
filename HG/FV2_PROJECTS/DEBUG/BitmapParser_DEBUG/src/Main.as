package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.graphics.bitmapParser.BitmapParser;
	import flash.display.BitmapData;
	import JM_EXT.org.flixel.utils.pngLevelMapUtils.PNGColorMapNoAlpha;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.config.TileStateConfig;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'TESTBM.png')]private static var TESTBM :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			var newBm:BitmapData = new TESTBM().bitmapData;
			var bmVis:Bitmap = new Bitmap(newBm);
			this.addChild(bmVis);
			//BitmapParser.debugIsValidPointHere(newBm);
			
			var bParse:BitmapParser = new BitmapParser();
			bParse.loadBitmap( newBm );
			bParse.getSpriteRectangles(TileStateConfig.spriteRecTopLeftColor, TileStateConfig.spriteRecBottomRightColor, TileStateConfig.emptySpaceColor);
			
			//bParse.getSpriteRectangles(0xFFFF0000, 0xFF0000FF, 0x00);
			
			
			/*
			var bm2:BitmapData = new BitmapData(40, 40, true, 0x00);
			var bv2:Bitmap = new Bitmap(bm2);
			bv2.y = 200;
			this.addChild(bv2);
			var color:uint;
			var colorIndex:int = 0;
			
			var colorString:String;
			var backToColor:uint;
			
			//Step1: Lay down some colors.
			for (var x:int = 0; x < bm2.width ; x++) {
			for (var y:int = 0; y < bm2.height; y++) {
				colorIndex++;
				if (colorIndex > PNGColorMapNoAlpha.MAX_COLOR_INDEX) { colorIndex = 0; }
				color = PNGColorMapNoAlpha.index15_to_bits32( colorIndex );
				bm2.setPixel32( x, y, color);
				trace("setting: " + color.toString(2) );
				
				colorString = PNGColorMapNoAlpha.color_to_stringSymbol( color );
				backToColor = PNGColorMapNoAlpha.stringSymbol_to_color( colorString);
				
				if (color != backToColor)
				{
					throw new Error("Bad conversion");
				}
				
			}}
			var bm3:BitmapData = new BitmapData(bm2.width, bm2.height, true, 0x00);
			*/
			
		}
		
	}
	
}