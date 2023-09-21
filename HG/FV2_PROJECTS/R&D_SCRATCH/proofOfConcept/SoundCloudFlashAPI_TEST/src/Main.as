package 
{//package
	import com.adobe.webapis.URLLoaderBase;
	import com.dasflash.soundcloud.as3api.SoundcloudDelegate;
	import flash.display.Sprite;
	import flash.events.Event;
    import com.dasflash.soundcloud.as3api.SoundcloudClient;
	import com.dasflash.soundcloud.as3api.events.SoundcloudEvent;
	import com.dasflash.soundcloud.as3api.events.SoundcloudFaultEvent; //when bad stuff happens. Most likely: No internet connectivity.
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.IOErrorEvent;
	import flash.events.ErrorEvent;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		
		/** Once authenticated, need this for all sub-sequent sound cloud calls **/
		private var _accessTokenGetter:SoundcloudDelegate;
		
		private var _requestTokenGetter:SoundcloudDelegate;
		
		private var _scClient:SoundcloudClient;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//doStuff();
			oAuthTest();
		}
		
		private function oAuthTest():void
		{
			//TAKEN FROM: https://developers.soundcloud.com/docs/api/reference#connect
			///////////////////////////////////////////////////////////////////////////
			//"https://api.soundcloud.com/oauth2/token" \\
           //-F 'client_id=YOUR_CLIENT_ID' \\
           //-F 'client_secret=YOUR_CLIENT_SECRET' \\
           //-F 'grant_type=authorization_code' \\
           //-F 'redirect_uri=http://yourapp.com/soundcloud/oauth-callback' \\
           //-F 'code=0000000EYAA1CRGodSoKJ9WsdhqVQr3g
		   //////////////////////////////////////////////////////////////////////////////
		   
		   var YOUR_CLIENT_ID    :String = "ab8373dd1f1d95800d65014b641cdaef";
		   var YOUR_CLIENT_SECRET:String = "932b3bcfea3313115c0ebdaf983a1cfd";
		   
		   var apiCallBase:String = "https://api.soundcloud.com/oauth2/token";
	
		   var queryString:String = "";
		   queryString += "client_id=" + YOUR_CLIENT_ID + "&";
		   queryString += "client_secret=" + YOUR_CLIENT_SECRET + "&";
		   queryString += "grant_type=authorization_code" + "&";
		   queryString += "redirect_uri=http://atomicalice.com/soundcloud/oauth-callback"; //+ "&";
		   //queryString += "code=0000000EYAA1CRGodSoKJ9WsdhqVQr3g";
		   
		   var debugInBrowser:String = apiCallBase + queryString;
		   
		   var v:URLVariables = new URLVariables(queryString);

		   //var d:String = "client_id=YOUR_CLIENT_IDclient_secret=YOUR_CLIENT_SECRET
		   var r:URLRequest = new URLRequest(apiCallBase);
		   r.method = URLRequestMethod.POST;
		   r.data = v;
		   
			var loader:URLLoader = new URLLoader(null);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(ErrorEvent.ERROR, onError);
			loader.load(r);
		   
		   //r.data = d;
		   
		}
		
		private function onComplete(evt:Event):void
		{
			trace("e");
		}
		
		private function onError(evt:Event):void
		{
			trace("e");
		}
		
		private function doStuff():void
		{
			/** Aka: Client ID on Soundcloud https://soundcloud.com/you/apps/atomicalice-1/edit **/
			var consumerKey:String = "ab8373dd1f1d95800d65014b641cdaef";
			
			/** Aka:Client Secret on Soundcloud https://soundcloud.com/you/apps/atomicalice-1/edit **/
			var consumerSecret:String = "932b3bcfea3313115c0ebdaf983a1cfd";
			
			
			_scClient = new SoundcloudClient(consumerKey, consumerSecret);
			_scClient.useSandBox = false;
			
			//_scClient.sendRequest("https://soundcloud.com/connect",
			
			/*
			////////////////////////////////////////////////////////////////////////////////////////////////////
			//QUOTE: https://github.com/dorianroy/Soundcloud-AS3-API/wiki/Quick-Start
			// That’s it. The returned token is stored within the client object so you don’t need to handle it 
			//(of course you could add a listener to the response event. 
			//Have a look at the code of the example client to learn how to do that).
			_requestTokenGetter = _scClient.getRequestToken();
			_requestTokenGetter.addEventListener(Event.COMPLETE, onGetRequestTokenComplete); //SoundcloudEvent.REQUEST_COMPLETE
			_requestTokenGetter.addEventListener(SoundcloudEvent.REQUEST_COMPLETE, onGetRequestTokenComplete);
			_requestTokenGetter.addEventListener(SoundcloudFaultEvent.REQUEST_TOKEN_FAULT, onGetRequestTokenFail);
			////////////////////////////////////////////////////////////////////////////////////////////////////
			*/
			
			
			
			
			
			
			// 6. Authentication Step 3: Get an Access Token
			//Now that you have an authenticated request token, you can trade it for an “Access Token”:
          /// _accessToken =  scClient.getAccessToken(verificationCode);

			

		}//doStuff
		
		private function onGetRequestTokenComplete(evt:Event):void
		{
			//Now the user of your app needs to allow it to access her account 
			//data by granting access on a special SoundCloud page. 
			//Open the page with this command:
			_scClient.authorizeUser();
		}
		
		private function onGetRequestTokenFail(evt:Event):void
		{
			trace("ho no!!");
		}
		
		
		
	}//class
}//package