package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	//network stuff:
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	
	import flash.net.URLVariables;
	
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
			
			crawlerTest03();
		}
		
		private function crawlerTest02():void
		{
			var request:URLRequest = new URLRequest("http://www.facebook.com");
			request.method = URLRequestMethod.GET;
		}
		
		private function crawlerTest03():void
		{
			//http://stackoverflow.com/questions/12774611/urlrequest-urlloader-auto-converting-post-request-to-get
			var urlRequest:URLRequest = new URLRequest("http://www.pof.com");
			var variables:URLVariables = new URLVariables();
			variables.andsomequerystring = true;

			urlRequest.data = variables;
			urlRequest.method = 'POST';
			var urlLoader:URLLoader = new URLLoader(urlRequest);
			urlLoader.addEventListener(Event.COMPLETE,  function(event:Event):void{
				trace('sweet');
			});
		}
		
		private function crawlerTest():void
		{
			// http://stackoverflow.com/questions/8420993/post-values-to-a-url-using-flash
			var request:URLRequest = new URLRequest("http://www.facebook.com");
			request.method = URLRequestMethod.POST;
			//request.requestHeaders
			request.data = "emal=someemail@email.com&score=79597";

			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, callWasMade);
			loader.addEventListener(IOErrorEvent.IO_ERROR, callFailedIOError);
			loader.load(request);
		}
		

		private function callWasMade(evt:Event):void{
		  //Optionally check server response
		  var data:Object = evt.target.data;
		  trace(data);
		}
		private function callFailedIOError(evt:IOErrorEvent):void {
		   //Holy crap I can't reach my server!
		}
		
	}
	
}