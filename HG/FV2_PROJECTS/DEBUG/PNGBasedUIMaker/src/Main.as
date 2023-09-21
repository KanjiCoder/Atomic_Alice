package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import JM_LIB.collections.integerMap.IntegerMap;
	import JM_LIB.collections.integerMap.IntegerMapParser;
	import JM_LIB.UI.abstract.uiGroupRec.UIGroupRec;
	import JM_LIB.UI.abstract.uiParseData;
	import JM_LIB.UI.abstract.uiRectangle.UIRec;
	
	import JM_LIB.utils.abstract.RGB_AZ09;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'PNGUI_00.PNG')]private static var UI_00 :Class;
		[Embed(source = 'PNGUI_01.PNG')]private static var UI_01 :Class;
		[Embed(source = 'PNGUI_02.PNG')]private static var UI_02 :Class;
		[Embed(source = 'PNGUI_03.PNG')]private static var UI_03 :Class;
		[Embed(source = 'PNGUI_04.PNG')]private static var UI_04 :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//testRGBChart();
			testAgain();
		}
		
		public function testRGBChart():void
		{
			var chart:String = RGB_AZ09.makeShortNameChart(["PEEP", "LEFT",  "MAIN", "CLOS", "RAWR", "TOPP", "BOTM","RGHT"]);
		}
		
		public function testAgain():void
		{
			//load raw data into integer map:
			var imap:IntegerMap = new IntegerMap();
			imap.useRRGGBB = true;
			imap.loadFromPNG( UI_04 );
			
			var groups:Vector.<UIGroupRec>;
			var uiBounds:Rectangle = new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			var iParser:IntegerMapParser = new IntegerMapParser();
			iParser.throwErrorOnNonDivisibleUIOverlay = false;
			groups = iParser.parseIntoUIGroups(uiBounds, imap);
			
			//Debug to see results:
			var bmDat:BitmapData = iParser.debugDrawGroups(uiBounds, groups);
			var bmVis:Bitmap = new Bitmap( bmDat );
			this.addChild( bmVis );
		}
		
		public function testIntegerMap():void
		{
			var imap:IntegerMap = new IntegerMap();
			imap.useRRGGBB = true;
			imap.loadFromPNG( UI_04 );
			
			trace("imap==" + imap);
			trace("mow");
			
			var iParser:IntegerMapParser = new IntegerMapParser();
			iParser.throwErrorOnNonDivisibleUIOverlay = false;
			iParser.loadIntegerMap( imap );
			var uiBounds:Rectangle = new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			
			//Get the UI rectangles:
			var uiPData:uiParseData;
			iParser.keepOriginalIntegersWhenParsing = true;
			uiPData = iParser.parseIntoUIRectangles( uiBounds );
			
			var bmDat:BitmapData = iParser.debugPaintBlockedOutUI( uiBounds, uiPData.uiRecs );
			var bmVis:Bitmap = new Bitmap( bmDat );
			this.addChild( bmVis );
			
			//Run test code to make sure we coded this correctly!
			RGB_AZ09.debugTestConversion();
			
			trace("newo");
			var i:int = 0;
			
			trace("NOOOOO!");
			
		}
		
	}
	
}