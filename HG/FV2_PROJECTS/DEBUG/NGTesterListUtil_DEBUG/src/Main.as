package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.siteSpecific.com.newGrounds.NGTesterListUtil;
	import JM_LIB.utils.StringParserUtil;
	import JM_LIB.utils.strings.StringSaverUtil;
	import JM_LIB.utils.vec.VectorUtil;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		[Embed(source = "AuthorLinks.txt", mimeType = 'application/octet-stream')] public static var AUTHOR_LINKS:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//var list:String = NGTesterListUtil.podContentToList( AUTHOR_LINKS, false );
			//trace("HI");
			
			var txt:String = NGTesterListUtil.classToText(AUTHOR_LINKS);
			var t1:String = 'alt="';
			var t2:String = '"></a>';
			var r:Vector.<String>;
			r = StringParserUtil.collectSubStringsBetweenTokens(txt, t1, t2, false);
			
			//var out:String;
			//out = NGTesterListUtil.podContentToList(AUTHOR_LINKS, false);
			//trace("hi");
			
			var list:String = VectorUtil.stringVecToListString(r);
			StringSaverUtil.saveText(list, "testerList");
		}
		
	}
	
}