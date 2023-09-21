package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.events.ErrorEvent;
	import com.adobe.serialization.json.JSON;
	import XML;
	import flash.xml.XMLParser;
	
	
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
		}
		
		public function doStuff():void
		{
			 var apiCallBase:String = "http://www.jmim.com/atomic_alice/highscores.asmx";
			 
			var queryString:String = "";
		   queryString += "op=GoodBye";
		  
		   var url_and_api_call:String = apiCallBase + "?" + queryString;
		   
		   //WSDL:
		  // url_and_api_call = "http://www.jmim.com/atomic_alice/highscores.asmx?WSDL";
		  //url_and_api_call = "http://www.jmim.com/atomic_alice/highscores.asmx/HelloWorld";
		  url_and_api_call = "http://www.jmim.com/atomic_alice/highscores.asmx/getScores?levNum=12&difMode=E";
		   
		   //sound cloud test. 
		  // url_and_api_call = "http://api.soundcloud.com/tracks/13158665.json?client_id=ab8373dd1f1d95800d65014b641cdaef";

		   
		   //forget about URL variables and r.data. Just put the whole url and query string in the request.
		 // var v:URLVariables = new URLVariables(queryString);

		  
		 // var r:URLRequest = new URLRequest(url_and_api_call);
		 
		  var r:URLRequest = new URLRequest(url_and_api_call);
		   r.method = URLRequestMethod.POST;
		 // r.data = v;
		   
			var loader:URLLoader = new URLLoader(null);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(ErrorEvent.ERROR, onError);
			loader.load(r);
		}
		
		public function onComplete(evt:Event):void
		{
			/*
			trace("hi");
			var obj:Object = JSON.decode(evt.target.data);
			trace("obj ==" + obj);
			*/
			
			var myXML:XML = new XML(evt.target.data);
			//var json:String = "{" + myXML[0] + "}";
			var json:String = myXML[0];
			var obj:Object = JSON.decode(json);
			
			trace("hi");
			
		}
		
		public function onError(evt:Event):void
		{
			trace("hi");
		}
		
	}//class
}//package