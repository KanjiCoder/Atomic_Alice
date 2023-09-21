package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import JM_LIB.utils.encoding.encrypt.RubixScramblerUtil;
	import JM_LIB.collections.integerMap.IntegerMap;
	import JM_LIB.utils.VectorUtil;
	
	import JM_LIB.utils.math.generate.RogueMapGenerator;
	
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
			doStuff();
			//doStuffRogueMap();
		}
		
	
		private function doStuff():void
		{
			
			
		
			
			var bm:BitmapData = new BitmapData(10, 10, true, 0xFFFF0000);
			var bmSmaller:BitmapData = new BitmapData(8, 8, true, 0xFF0000FF);
			var p:Point = new Point(1, 1);
			bm.copyPixels(bmSmaller, bmSmaller.rect, p, null, null, false);
			
			
			
			var bmVis:Bitmap = new Bitmap(bm);
			this.addChild(bmVis);
			bmVis.scaleX = 10;
			bmVis.scaleY = 10;
			
			//copy bm for output:
			var outBM:BitmapData = new BitmapData(bm.width, bm.height, true, 0x00);
			var outBMVis:Bitmap = new Bitmap(outBM);
			this.addChild(outBMVis);
			outBMVis.scaleX = bmVis.scaleX;
			outBMVis.scaleY = bmVis.scaleY;
			outBMVis.x = outBMVis.width + 10;
			
			//convert this bitmap data to an array of integers:
			var iMap:IntegerMap = new IntegerMap();
			iMap.useRRGGBB = true;
			iMap.loadFromBitmap(bm);
			var data:Vector.<int> = iMap.getDataAsInts();
			
			
			iMap.dumpDataIntoBitmap(bm);
			
			
			//scramble:
			var rubix:RubixScramblerUtil = new RubixScramblerUtil(bm.width, bm.height);
			//var shifts:Vector.<int> = VectorUtil.arrayToIntVector([0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    0,0,0,0,0,0,0,0,0,0,   0,0,0,0,0,0,0,0,0,0,       0,0,0,0,0,0,0,0,0,0,     4,5]);
			//var shifts:Vector.<int> = VectorUtil.arrayToIntVector([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);
			//var shifts:Vector.<int> = VectorUtil.arrayToIntVector([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
			
			//var shifts:Vector.<int>  = VectorUtil.arrayToIntVector([1, 6, 3, 8, 3, 1, 6, 9, 8, 8, 8, 5, 4, 3, 3, 2, 54, 2, 3, 5]);
			//var address:Vector.<int> = VectorUtil.arrayToIntVector([2, 5, 3, 2, 1, 4, 5, 6, 7, 4, 11,12,34,34,66,2 ,35, 2, 1, 2]);
			
			//var shifts:Vector.<int>  = VectorUtil.arrayToIntVector([1, 16, 3, 8, 33, 1, 6, 19, 8, 8, 8, 25, 4, 3, 93, 2, 54, 2, 3, 5]);
			//var address:Vector.<int> = VectorUtil.arrayToIntVector([2, 5, 3, 2, 21, 94, 15, 36, 7, 14, 11,12,34,34,66,2 ,35, 2, 1, 2]);
			
			//var shifts:Vector.<int>  = VectorUtil.arrayToIntVector([1, 16, 3, 8, 11, 1, 6, 19, 8, 8, 8, 5, 4, 3, 3, 2, 11, 2, 3, 5]);
			//var address:Vector.<int> = VectorUtil.arrayToIntVector([2, 5, 3, 2, 21, 4, 15, 36, 7, 4, 1,12,4,11,6,2 ,35, 2, 1, 2]);
			
			//var encoded:Vector.<int> = rubix.encodeNonUniform( shifts, address, data);
			//var decoded:Vector.<int> = rubix.decodeNonUniform( shifts, address, encoded);
			
			var encoded:Vector.<int> = rubix.encodeUsingStringKey("Pork", data);
			var decoded:Vector.<int> = rubix.decodeUsingStringKey("Pork", encoded);
			
			bm.fillRect(bm.rect, 0xFF00FF00);
			
			//show encoded:
			iMap.loadFromIntVec( encoded, 10, 10);
			iMap.dumpDataIntoBitmap(bm);
			
			//show decoded:
			iMap.loadFromIntVec( decoded, 10, 10);
			iMap.dumpDataIntoBitmap(outBM);
			
		}
		
	}
	
}