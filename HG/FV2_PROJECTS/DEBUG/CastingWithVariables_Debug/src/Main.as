package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_EXT.org.flixel.extendedFlixelClasses.tilemap.FlxTilemap_EXT;
	import org.flixel.FlxTilemap;
	
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
			
			var a:int = (1 as int);
			var b:Number = (1 as Number);
			
			var typeInt:Class = int;
			var typeNumber:Class = Number;
			
			//This won't work:
			//var c:int = (1 as typeInt);
			//var d:int = (1 as typeNumber);
			
			var c:int = typeInt( 1 );
			var d:Number = typeNumber( 1 );
			
			//Example using my extended flixel tilemap type:
			var typeMap:Class = FlxTilemap_EXT;
			var obj:Object = new FlxTilemap_EXT();
			var map:FlxTilemap_EXT = typeMap( obj );
			
			trace("hello");
			//throw new Error("WTF");
		}
		
	}
	
}