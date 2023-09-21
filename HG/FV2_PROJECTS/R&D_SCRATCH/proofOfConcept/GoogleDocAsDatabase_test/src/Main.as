package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.navigateToURL;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * http://adenforshaw.com/tag/google-spreadsheet-flash/
	 *  All you need to do is pass in your LoadVars or URLVariables in post format variables like this:

		sender["entry.0.single"]  = "my string to add to spreadsheet";

		Where the number between entry and single is an incrementing number 
		denoting the control in the form to mirror. So in this example the 
		entry.0.single represents the name text field control in the 
		google spreadsheet form.
		
		
		Negative Review on this method:
			It’s really a one sided way of storing data. 
			There are ways of retrieving the data from a google spreadsheet. 
			You’d have to “screen scrape”, 
			here’s an example: 
				http://matthewsteele.wordpress.com/2007/11/03/screen-scraping-google-spreadsheets-exported-as-html/

        To be honest it sounds like you’d be better off just using an off the shelf 
		comments/message board system plugged into a database and save your time for 
		doing something more interesting, rather than reinventing the wheel.
	 * 
	 * 
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
		}
		
		public function jmim():void
		{
			var url:String = "http://www.jmim.com";
            var request:URLRequest = new URLRequest(url);
		}
		
		public function URLVariablesExample() {
            //var url:String = "http://www.[yourDomain].com/application.jsp";
			var url:String = "http://www.jmim.com";
            var request:URLRequest = new URLRequest(url);
            var variables:URLVariables = new URLVariables();
            variables.exampleSessionId = new Date().getTime();
            variables.exampleUserLabel = "guest";
            request.data = variables;
            navigateToURL(request);
        }
		
	}
	
}