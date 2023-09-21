package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.adobe.serialization.json.JSON;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.config.json.jsonCompatible.lighting.EnvLightPreset;
	import JM_LIB.utils.jsonObjectParsing.JSONSolidifier;
	import JM_LIB.utils.jsonObjectParsing.helpers.JAccessPath;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		[Embed(source = 'BlueEscape.txt', mimeType='application/octet-stream')]
		private static const myJSON:Class;
		
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
		
		private function doTest():void
		{
			var jsonString:String = new myJSON();
			var jsonInstance:Object = JSON.decode( jsonString );
			
			var drawOrder:Object = jsonInstance["DRAWORDER"];
			var layerOrder:Object = drawOrder["LAYERORDER"];
			
			if (layerOrder is Array)
			{
				
				var obj:Object = layerOrder["1"];
				trace("yes it is Bret!");
			}
			
			var pVec:Vector.<String> = JSONSolidifier.getSortedPropVector( jsonInstance );
			
			var accessorStrings:Vector.<String> = JSONSolidifier.getAllAccessorStrings(jsonInstance);
			
			
			var accessors:Vector.<JAccessPath> = JSONSolidifier.getAllAccessorPaths(jsonInstance);
			
			var c:EnvLightPreset = new EnvLightPreset();
			JSONSolidifier.injectConcreteClass(c, jsonInstance);
			
			
			trace("Hi");
		}
		
	}//class
}//package