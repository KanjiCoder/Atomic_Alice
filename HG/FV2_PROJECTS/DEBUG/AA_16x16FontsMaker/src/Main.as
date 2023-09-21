package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import GameSpecificRegistries.Bomber01.src.AA_16X16_FONT_PACK_SOURCE;
	import JM_LIB.bitPacking.pngPacking.glyph.GlyphPackerPNG;
	import GameSpecificRegistries.Bomber01.FontReg;
	
	/**
	 * ...
	 * @author JMIM
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
			
			var a:Array = AA_16X16_FONT_PACK_SOURCE.getCharBitmapPairs();
			GlyphPackerPNG.packFontGlyphsAndSaveToComputer( a );
			
			//trace("hi");
			//var arr:Array = FontReg.getCharBitmapPairs();
			trace("hi");
			
		}
		
	}
	
}