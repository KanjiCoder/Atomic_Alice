package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
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
			
			var exists:Array =
			[0, 1, 3, 4, 10, 12, 13, 14, 15, 16, 18, 20, 24, 25,
			 33,34,35,36,37,38,39,40,41];
			
			makeLevelEmbeddTags(exists);
			makePushLevelCodeLines(exists);
			
		}
		
		public function makeLevelEmbeddTags(inExists:Array=null):void
		{
			var useExists:Boolean = false;
			if (inExists != null) { useExists = true;}
			
			//		[Embed(source = 'levelMap00.png')]private static var LEV_00 :Class;
			var r0:String = "[Embed(source = 'levelMap";
			var r1:String = ".png')]private static var LEV_";
			var r2:String = ":Class;";
			
			var comment:String = "//";
			
			var outputLine:String;
			var ns:String;
			var maybeComment:String;
			for (var i:int = 0; i <= 50; i++)
			{
				maybeComment = "  ";
				if (useExists)
				{
					if (inExists.indexOf(i) == ( -1))
					{
						maybeComment = comment;
					}
				}
				
				ns = i.toString();
				if (ns.length < 2) { ns = "0" + ns; };
				outputLine = maybeComment + r0 + ns + r1 + ns + r2;
				trace(outputLine);
			}
		}//makeLevelEmbeddTags
		
		public function makePushLevelCodeLines(inExists:Array=null):void
		{
			
			var useExists:Boolean = false;
			if (inExists != null) { useExists = true;}
			
			var comment:String = "//";
			var maybeComment:String;
			
			var D:String = "\"";
			var N:String = "\n";
			//this.pushLevel("LEV_00", LEV_00);
			var r0:String = "this.pushLevel(" + D + "LEV_";
			var r1:String = D + ", LEV_";
			var r2:String = ");" ;// + N;
			
			var outputLine:String;
			var ns:String;
			for (var i:int = 0; i <= 50; i++)
			{
				
				maybeComment = "  ";
				if (useExists)
				{
					if (inExists.indexOf(i) == ( -1))
					{
						maybeComment = comment;
					}
				}
				
				
				ns = i.toString();
				if (ns.length < 2) { ns = "0" + ns; };
				outputLine = maybeComment + r0 + ns + r1 + ns + r2;
				trace(outputLine);
			}
		}//makePushLevelCodeLines
		
	}
	
}