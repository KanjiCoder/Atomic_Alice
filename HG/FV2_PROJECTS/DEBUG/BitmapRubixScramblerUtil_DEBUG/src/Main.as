package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.encoding.encrypt.BitmapRubixScramblerUtil;
	import JM_EXT.com.adobe.utils.BitmapOpenerUtil;
	import JM_LIB.utils.encoding.encrypt.spiral.BitmapSpiralScramblerUtil;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		private var _bmOpener:BitmapOpenerUtil;
		
		private var _bmOriginal:BitmapData;
		private var _bmEncoded:BitmapData;
		private var _bmDecoded:BitmapData;
		
		private var _bmOriginal_DISP:Bitmap;
		private var _bmEncoded_DISP:Bitmap;
		private var _bmDecoded_DISP:Bitmap;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function doIt():void
		{
			_bmOpener = new BitmapOpenerUtil();
			_bmOpener.openUsingDialogEZ(scramBam, "scramBam");
		}
		
		public function scramBam(inBm:BitmapData):void
		{
			
			var scram:BitmapSpiralScramblerUtil;
			scram = new BitmapSpiralScramblerUtil();
			_bmOriginal = inBm;
			_bmEncoded  = scram.encode( _bmOriginal,"MEOWMIX" );
			_bmDecoded  = scram.decode( _bmEncoded ,"MEOWMIX"  );
			
			
			/*
			var scram:BitmapSpiralScramblerUtil;
			scram = new BitmapSpiralScramblerUtil();
			_bmOriginal = inBm;
			_bmEncoded  = scram.uniformShift(_bmOriginal, 1);
			_bmDecoded  = scram.uniformShift( _bmEncoded , -1);
			*/
			
			/*
			_bmOriginal = inBm;
			_bmEncoded  = BitmapRubixScramblerUtil.encode( _bmOriginal,"MEOWMIX" );
			_bmDecoded  = BitmapRubixScramblerUtil.decode( _bmEncoded ,"MEOWMIX"  );
			*/
			
			//display everything:
			_bmOriginal_DISP = new Bitmap(_bmOriginal);
			_bmEncoded_DISP  = new Bitmap(_bmEncoded);
			_bmDecoded_DISP  = new Bitmap(_bmDecoded);
			
			/*
			var arr:Array = [_bmOriginal_DISP, _bmEncoded_DISP, _bmDecoded_DISP];
			for (var i:int = 0; i < arr.length; i++)
			{
				var cur:Bitmap = arr[i];
				cur.scaleX = 8;
				cur.scaleY = 8;
			}
			*/
			
			
			//Add them to display:
			this.addChild(_bmOriginal_DISP);
			this.addChild(_bmEncoded_DISP );
			this.addChild(_bmDecoded_DISP );
			
			_bmEncoded_DISP.x = _bmOriginal_DISP.width;
			_bmDecoded_DISP.x = _bmEncoded_DISP.x + _bmEncoded_DISP.width;
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			doIt();
		}
		
	}//class
}//package