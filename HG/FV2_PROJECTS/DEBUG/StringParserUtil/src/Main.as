package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.StringParserUtil;
	
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
			
			var word:String = "__AS3__.vec::Vector.<JM_LIB.toolSystems.levelEditor.leMap.components.decalMapCore.helpers::DecalMetaDatumLE>";
			//var word:String = "a<hel>";
			var res:String = StringParserUtil.getSubStringBetweenTokens(word, "<", ">", false);
			trace("res==" + res);
		}
		
	}
	
}