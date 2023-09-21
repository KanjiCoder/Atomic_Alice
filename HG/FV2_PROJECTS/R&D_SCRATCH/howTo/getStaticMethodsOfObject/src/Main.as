package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import JM_LIB.toolSystems.levelEditor.leMap.components.decalMapCore.helpers.DecalMetaDatumLE;
	
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
			rawer();
		}
		
		private function rawer():void
		{
			var obj:Object = new DecalMetaDatumLE();
			var str:String = getQualifiedClassName( obj );
			
			var defOBJ:Object = getDefinitionByName(str);
			var def:Class  = getDefinitionByName(str) as Class;
			
			if (def["toJSONText"] != null)
			{
				trace("call it!");
			}
			
			//var b:Boolean = DecalMetaDatumLE.hasOwnProperty("toJSONText");
			//var f:Function = DecalMetaDatumLE.prototype.hasOwnProperty;
			//var b:Boolean = f("toJSONText");
			
			//trace("b==" + b);
		}
		
	}//class
}//package