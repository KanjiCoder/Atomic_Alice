package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.ByteArray;
	import mx.core.ByteArrayAsset;
	
	import JM_EXT.org.as3commons.embedd.embeddedByteArrayClassMaker.EmbeddedByteArrayClassMaker;
	import JM_EXT.org.as3commons.embedd.embeddedByteArrayClassMaker.ByteArrayAssetWrapper;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'JSON_FILE.json', mimeType='application/octet-stream')]private static const JSON_FILE:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var _jsonLoader:URLLoader = new URLLoader();
			_jsonLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_jsonLoader.addEventListener(Event.COMPLETE, processJson);
			_jsonLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_jsonLoader.load(new URLRequest("../src/JSON_FILE.json"));
			
			
			
		}
		
		private function processJson(evt:Event):void
		{
			var ebacm:EmbeddedByteArrayClassMaker = new EmbeddedByteArrayClassMaker();
			var ba:ByteArray = evt.target.data;
			
			//var baString:String = ba.readUTFBytes( ba.length );
			
			ebacm.makeClass("HAPPY_BITS", ba);
			
		}
		
		private function onError(ioe:IOErrorEvent):void
		{
			throw new Error("FILE NOT FOUND BRO!!! OH NO!!!");
		}
		
	}//class
}//package