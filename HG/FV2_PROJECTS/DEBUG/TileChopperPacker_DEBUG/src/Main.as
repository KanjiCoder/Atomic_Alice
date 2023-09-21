package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import JM_LIB.plainOldData.TileRect;
	import JM_LIB.plainOldData.TileRectPair;
	import JM_LIB.utils.math.geom.TileChopperPacker;
	import flash.display.Sprite;
	import flash.events.Event;

	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends Sprite 
	{
		private var srcFunc_gottenPixel:uint;
		
		
		
		//The current pack you are testing:
		private var _curPackNumber:int = ( -1);
		private var _dstBM:Bitmap;
		private var _srcBM:Bitmap;
		
		private var _resultsBM:BitmapData = new BitmapData(300, 300, true, 0xFF00FF00);
		private var _resultsVS:Bitmap = new Bitmap( _resultsBM );
		
		private var _packs:Vector.<TestPack> = new Vector.<TestPack>(0);
		
		[Embed(source = "100x100.png")]   public static var PNG100x100 : Class;
		[Embed(source = "100x30.png" )]   public static var PNG100x30  : Class;
		[Embed(source = "30x100.png" )]   public static var PNG30x100  : Class;
		[Embed(source = "30x30.png"  )]   public static var PNG30x30   : Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var BM100x100:BitmapData = (new PNG100x100()).bitmapData;
			var BM100x30 :BitmapData = (new PNG100x30()).bitmapData;
			var BM30x100 :BitmapData = (new PNG30x100()).bitmapData;
			var BM30x30  :BitmapData = (new PNG30x30()).bitmapData;
			

			var p:Function = _packs.push;
			
			//I expect 1 for all of these:
			p( TestPack.make(BM100x100, BM100x100, 1) );
			p( TestPack.make(BM100x100, BM100x30 , 1) );
			p( TestPack.make(BM100x100, BM30x100 , 1) );
			p( TestPack.make(BM100x100, BM30x30  , 1) );
			
			p( TestPack.make(BM100x30, BM100x100, 1) );
			p( TestPack.make(BM100x30, BM100x30 , 1) );
			p( TestPack.make(BM100x30, BM30x100 , 4) );
			p( TestPack.make(BM100x30, BM30x30  , 1) );
			
			p( TestPack.make(BM30x100, BM100x100, 1) );
			p( TestPack.make(BM30x100, BM100x30 , 4) );
			p( TestPack.make(BM30x100, BM30x100 , 1) );
			p( TestPack.make(BM30x100, BM30x30  , 1) );
			
			p( TestPack.make(BM30x30, BM100x100, 1) );
			p( TestPack.make(BM30x30, BM100x30 , 1) );
			p( TestPack.make(BM30x30, BM30x100 , 1) );
			p( TestPack.make(BM30x30, BM30x30  , 1) );
			
			/*
			for (var i:int = 0; i < packs.length; i++)
			{
				doTestUsingTestPack( packs[i] );
				trace("success for " + i.toString() );
			}
			*/
			
			trace("hellow workdsds");
			//var fakeButton:Bitmap = new Bitmap( new BitmapData(100, 100, true, 0xFFFF0000) );
			//this.addChild(fakeButton);
			
			_dstBM = new Bitmap();
			_srcBM = new Bitmap();
			this.addChild(_resultsVS);
			this.addChild(_dstBM);
			this.addChild(_srcBM);
			
			this.stage.addEventListener(MouseEvent.CLICK, doNextTest);
			
		}//init
		
		private function doNextTest(evt:Event):void
		{
			_curPackNumber++;
			if (_curPackNumber >= _packs.length) { _curPackNumber = 0; }
			
			doTestUsingTestPack( _packs[ _curPackNumber ] );
		}
		
		private function doTestUsingTestPack(inTestPack:TestPack):void
		{
			doTest(inTestPack.srcBM, inTestPack.dstBM, inTestPack.numExpected);
		}
		
		private function doTest(srcBM:BitmapData, dstBM:BitmapData, numberOfPairsThatShouldBeMade:int):void
		{
			_srcBM.bitmapData = srcBM;
			_dstBM.bitmapData = dstBM;
			_dstBM.x = _srcBM.width;
			_resultsVS.x = (_srcBM.width + _dstBM.width);
			
			var sets:Vector.<TileRectPair>;
			var sRec:TileRect = TileRect.makeFromBitmap(srcBM);
			var dRec:TileRect = TileRect.makeFromBitmap(dstBM);
			sets = TileChopperPacker.makeSlicePacks(sRec, dRec);
			if (sets.length != numberOfPairsThatShouldBeMade) { throw new Error("execution went against my expectations. Change expectations, or change code."); }
			
			_resultsVS.bitmapData.fillRect(_resultsVS.bitmapData.rect, 0xFF00FFFF);
			TileChopperPacker.operateUsingSlicePacks(sets, srcFunc, dstFunc);
			
			
		}//doTest
		
		private function srcFunc(inTileX:int, inTileY:int):void
		{
			srcFunc_gottenPixel = _srcBM.bitmapData.getPixel32(inTileX, inTileY);
		}
		
		private function dstFunc(inTileX:int, inTileY:int):void
		{
			_resultsVS.bitmapData.setPixel32(inTileX, inTileY, srcFunc_gottenPixel);
		}
		
	}//class
}//package

import flash.display.BitmapData;

internal class TestPack
{
	public var srcBM:flash.display.BitmapData;
	public var dstBM:flash.display.BitmapData;
	public var numExpected:int = 0;
	
	public static function make(inSRC:BitmapData, inDST:BitmapData, inExpected:int):TestPack
	{
		var out:TestPack = new TestPack();
		out.srcBM = inSRC;
		out.dstBM = inDST;
		out.numExpected = inExpected;
		return out;
	}//make
	
}//testPack