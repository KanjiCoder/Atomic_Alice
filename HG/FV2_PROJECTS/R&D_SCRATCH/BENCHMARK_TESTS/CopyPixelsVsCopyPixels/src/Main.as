package 
{
	
	//Common knowledge is SetPixel32 is slower that CopyPixels.
	//What I want to know however is... What is the equivalency ratio?
	//Meaning:
	//Does using setPixel32 100 times take the same amount of time as CopyPixels for a (100x100) (10,000 pixel area)? Or something like that?
	//If you are going to use particles that use the "setPixel32" command... We need to know.
	//Compare setting pixel32 to usingCopyPixels on ONE pixel and see the speed difference.
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
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
			
			/*
			for (var i:int = 1; i < 100; i++)
			{
				pixelTest(i);
			}
			*/
			
			pixelTest(640, 480);
			
		}
		
		public function pixelTest(inRecWidth:int, inRecHeight:int):void
		{
			
			
			var t1:Number;
			var t2:Number;
			var tt:Number;
			var counter:int;
			var counterMax:int = 765;
			
			var theBm:BitmapData = new BitmapData(inRecWidth, inRecHeight, true, 0x00);
			var copyFromBm:BitmapData = new BitmapData(inRecWidth, inRecHeight, true, 0x00);
			var ZZ:Point = new Point(0, 0);
		
			var rec16:Rectangle = new Rectangle(0, 0, 16, 16);
			var recAll:Rectangle = new Rectangle(0, 0, inRecWidth, inRecHeight);
			
			var setPixelCount:int = 0;
			var setPixelTimes:int = ( (inRecWidth/16) * (inRecHeight/16));
			
			t1 = getTimer();
			counter = 0;
			do
			{
				counter++;
				if (counter > counterMax) { break; }
				
				setPixelCount = 0;
				do {
					setPixelCount++;
					if (setPixelCount > setPixelTimes) { break;}
					theBm.copyPixels(copyFromBm, rec16, ZZ, null, null, true);
				}while (true);
				
				
				
			}while (true);
			t2 = getTimer();
			tt = t2 - t1;
			trace("setPixel32 time:: tt==" + tt);

			t1 = getTimer();
			counter = 0;
			do
			{
			counter++;
				if (counter > counterMax) { break;}
				
				theBm.copyPixels(copyFromBm, recAll, ZZ, null, null, true);
				
			}while (true);
			t2 = getTimer();
			tt = t2 - t1;
			trace("copyPixels ALL time:: tt==" + tt);
		}
		
	}//class
}//package