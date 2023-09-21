package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.adobe.serialization.json.JSON
	import JM_LIB.utils.toJSON.JSONFileBuilder;
	import com.adobe.serialization.json.JSONEncoder;
	
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
			
			doTest();
		}
		
		public function doTest():void
		{
			var a:int = 5;
			var r:int = 4;
			var g:int = 3;
			var b:int = 2;
			JSONFileBuilder.startNewBuildSession();
			JSONFileBuilder.startObject("objMEOW");
			JSONFileBuilder.addVar(a, "a");
			JSONFileBuilder.addVar(r, "r");
			JSONFileBuilder.addVar(g, "g");
			JSONFileBuilder.addVar(b, "b");
			
			JSONFileBuilder.startObject("obj2");
			JSONFileBuilder.addVar(a, "a");
			JSONFileBuilder.addVar(r, "r");
			JSONFileBuilder.addVar(g, "g");
			JSONFileBuilder.addVar(b, "b");
			
			
			
			var j:String = JSONFileBuilder.buildJSON();
			trace("hi");
			
			var obj:Object = JSON.decode(j);
			
			//var jcode:JSONEncoder = new JSONEncoder(a);
			//var j2:String = jcode.getString();
			
			trace("hihi");
		}
		
	}//class
}//package