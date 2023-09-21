package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import XML;
	import XMLList;
	
	import flash.utils.ByteArray;
	
	import JM_LIB.utils.strings.StringSaverUtil;
	
	import JM_LIB.utils.siteSpecific.com.newGrounds.NGTesterListUtil;
	
	/**
	 * ...
	 * XML displayer UI?? Can you download?
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		//embed the tester list:
		 [Embed(source="NGTesterListHTML_2014.08.07.txt",mimeType="application/octet-stream")] public var TEXT:Class;
			
		
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
			doStuffToo();
		}
		
		private function doStuffToo():void
		{
			//var list:String = NGTesterListUtil.podContentToList( TEXT, false);
			NGTesterListUtil.savePodContentToListUsingDialogBox(TEXT, false);
			var hay:String = "meow";
		}
		
		private function doStuff():void
		{
			//create a text field to test out the display of this stuff:
			var tf:TextField = new TextField();
			this.addChild(tf);
			
			
			var textAsByteArray:ByteArray = new TEXT();
			var textAsString:String = textAsByteArray.toString();
			var textAsXML:XML = new XML(textAsString);
			var x:XML = textAsXML;
			
			var len:int = x.length();
			
			var at:String = x.div.text();
			var bt:String = x.ul.text();
			var a:XMLList = x.div;
			var b:XMLList = x.ul;
			var c:Object = x.ul[0];
			var d:Object = x.ul.li;
			
			var testerCore:XMLList = x.ul.li;
			len = testerCore.length();
			
			//create the different chunks needed to stitch together a hyperlink:
			var link_01:String = '<a href="';
			var link_02:String = '">';
			var link_03:String = '</a>';
			
			var curElem:Object;
			var urlElem:Object;
			var imgElem:Object;
			var altElem:Object;
			var testerID:Object;
			var testerURL:Object;
			var urlAttr:Object;
			var testerHyperLink:String;
			var testerList:String = ""; //the tester list stripped of all XML and such.
			for (var i:int = 0; i < len; i ++)
			{
				//get the core of the list from newgrounds:
				curElem = testerCore[i];
				
				//get the URL:
				urlElem = curElem.a;
				urlAttr = urlElem.@href;
				testerURL = urlAttr.toString();
				
				//get the name of the tester:
				imgElem = curElem.a.img;
				altElem = imgElem.@alt;
				testerID = altElem.toString();
				
				testerHyperLink = link_01 + testerURL + link_02 + testerID + link_03;
				
				testerList += (testerHyperLink + "\n" );
				//testerList += (testerID + "\n" );
				var meow:String = "";
			}
			
			//turn all of the testers into hyperlinks:
			//<a href="url">Link text</a> 
			
			//StringSaverUtil.saveText(testerList, "testerList");
			tf.htmlText = testerList;
			
		    var debug:Boolean = true;
			trace("hello");
			//trace("s==" + s);
		
		}
		
	}//class
}//package