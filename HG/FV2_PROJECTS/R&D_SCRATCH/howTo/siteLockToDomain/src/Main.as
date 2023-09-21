package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
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
			var url:String = stage.loaderInfo.url;
			//var url:String = "http://www.newgrounds.com/portal/view/497440";
			
			var urlStart:int = url.indexOf("://") + 3;
			var urlEnd:int = url.indexOf("/",urlStart);
			var domain:String = url.substring(urlStart, urlEnd);
			var lastDot:int = domain.lastIndexOf(".")-1;
			var domEnd:int = domain.lastIndexOf(".",lastDot)+1;
			var finalDomain:String = domain.substring(domEnd,domain.length);

			trace(finalDomain);
			
			var tf:TextField = new TextField();
			var txt:String = "";
			txt += "url == " + url + "\n";
			txt +="domain==" + finalDomain + "\n";
			tf.text = txt;
			tf.width = tf.textWidth + 10;
			tf.height = tf.textHeight + 10;
			this.addChild(tf);
			
			trace(url);
		}
		
	}
	
}