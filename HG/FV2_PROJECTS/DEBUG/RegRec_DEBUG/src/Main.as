package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Vector3D;
	import JM_LIB.graphics.bitmapParser.regionRecExtractor.BitmapParser_RegRec;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.graphics.bitmapParser.regionRecExtractor.RegRec;
	
	/**
	 * A project for debugging my RegRec parsing code.
	 * @author JMim
	 */
	
	 //TODO: Analysis of 5X11 makes it look like my .isTaken variable is NOT being set somewhere.
	 
	 
	public class Main extends Sprite 
	{
		/** Used to do quick check of all the PNG classes that have previously passed test. Just to make sure
		 *  that nothing got broken during re-factoring. */
		private static var shouldBeOkayPNG:Vector.<Class>;
		
		[Embed(source = '11X11.png')]private static var PNG11X11 :Class;//GOOD! Ambigious non-double bracket problem.
		[Embed(source = '6X6.png')]private static var PNG6X6 :Class; //GOOD!
		[Embed(source = '5X11.png')]private static var PNG5X11 :Class;//GOOD! Ambigous nesting problem. SIMPLIFIED.
		[Embed(source = '10X10.png')]private static var PNG10X10 :Class;//GOOD!
		[Embed(source = '13X13.png')]private static var PNG13X13 :Class;//GOOD! Ambigous nesting problem.
		[Embed(source = '15X15.png')]private static var PNG15X15 :Class; //GOOD!
		[Embed(source = '4X4.png')]private static var PNG4X4 :Class; //GOOD!
		[Embed(source = '5X5.png')]private static var PNG5X5 :Class; //GOOD!
		[Embed(source = '4X8.png')]private static var PNG4X8 :Class; //GOOD!
		[Embed(source = '8X4.png')]private static var PNG8X4 :Class; //GOOD!
		[Embed(source = '20X20.png')]private static var PNG20X20 :Class; //GOOD!
		[Embed(source = '16X16.png')]private static var PNG16X16 :Class; //GOOD!
		
		[Embed(source = '4X4Trouble.png')]private static var PNG4X4Trouble :Class;//GOOD! Perma-Ambigious Case.
		[Embed(source = '7X7.png')]private static var PNG7X7 :Class;//GOOD! Perma-Ambigious Case.
		
		[Embed(source = '9X9.png')]private static var PNG9X9 :Class;//GOOD!
		[Embed(source = '12X12.png')]private static var PNG12X12 :Class;//GOOD! [*]
		
		[Embed(source = '18X18.png')]private static var PNG18X18:Class; //GOOD! Entanglement Case
		[Embed(source = '9X9Trouble.png')]private static var PNG9X9Trouble:Class;//GOOD! Simplified entanglement case.
		
		[Embed(source = '30X30.png')]private static var PNG30X30:Class; //GOOD![*]the final test hopefully.
		[Embed(source = '30X30ALT.png')]private static var PNG30X30ALT:Class; //GOOD![*]the final test hopefully.
		
		[Embed(source = '14X14.png')]private static var PNG14X14:Class; //safety test final.
		
		{//static init
			shouldBeOkayPNG = new Vector.<Class>(0);
			shouldBeOkayPNG.push( PNG11X11);
			shouldBeOkayPNG.push( PNG6X6);
			shouldBeOkayPNG.push( PNG5X11);
			shouldBeOkayPNG.push( PNG10X10);
			shouldBeOkayPNG.push( PNG13X13);
			shouldBeOkayPNG.push( PNG15X15);
			shouldBeOkayPNG.push( PNG4X4);
			shouldBeOkayPNG.push( PNG5X5);
			shouldBeOkayPNG.push( PNG4X8);
			shouldBeOkayPNG.push( PNG8X4);
			shouldBeOkayPNG.push( PNG20X20);
			shouldBeOkayPNG.push( PNG16X16);
			shouldBeOkayPNG.push( PNG4X4Trouble );
			shouldBeOkayPNG.push(PNG7X7);
			shouldBeOkayPNG.push(PNG9X9);
			shouldBeOkayPNG.push(PNG12X12);
		}//static init
		
		
		
		
		
		
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//doDoubleCheckOnGoodPNG();
			
			var meow:Object = new PNG14X14(); //Perma Ambigous case.
			var bmDat:BitmapData = meow.bitmapData;
			
			//Debug bitmap:
			
			var debugBM:BitmapData = new BitmapData(bmDat.width, bmDat.height);
			var debugVS:Bitmap = new Bitmap(debugBM);
			debugVS.scaleX = 8;
			debugVS.scaleY = 8;
			this.addChild(debugVS);
			//BitmapParser_RegRec.debugBM = debugBM;
			
		
			var rrv:Vector.<RegRec>;
			rrv = BitmapParser_RegRec.getRegionRectangles( bmDat );
			
			trace("meow");
		}
		
		/** Quick error check on all PNG classes that have already passed the test previously. */
		private function doDoubleCheckOnGoodPNG():void
		{
			for (var i:int = 0; i < Main.shouldBeOkayPNG.length; i++)
			{
				var pngClass:Class = Main.shouldBeOkayPNG[ i ];
				var bmDat:BitmapData = new pngClass().bitmapData; 
				var outRegRecs:Vector.<RegRec>;
				outRegRecs = BitmapParser_RegRec.getRegionRectangles( bmDat );
			}
		}
		
	}
	
}