package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.bitPacking.pngPacking.glyph.GlyphPack;
	import JM_LIB.bitPacking.pngPacking.glyph.GlyphPackerPNG;
	import JM_LIB.preLoaders.atomicAlice.AAPL_ASSETS_SOURCE;
	import JM_EXT.com.adobe.utils.BitmapSaverUtil;
	import JM_LIB.utils.strings.StringSaverUtil;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		private var _bmSaver:BitmapSaverUtil;
		private var _txtSave:StringSaverUtil;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			justDoIt();
		}
		
		private function justDoIt():void
		{
			_bmSaver = new BitmapSaverUtil();
			var charBMPairs:Array = AAPL_ASSETS_SOURCE.getCharBitmapPairs();
			var pack:GlyphPack = GlyphPackerPNG.packFontGlyphs( charBMPairs );
			
			_bmSaver.useWatermark = false;
			_bmSaver.openDialogForBitmapSave( pack.pack);
			
			//_txtSave = new StringSaverUtil();
			
		}//justDoIt
		
	}//class
}//package