package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.toolSystems.levelEditor.leMap.ui.helpers.decalEditWiget.DecalMetaDatumEditorWidget;
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
			doStuff();
		}
		
		private function doStuff():void
		{
			var ed:DecalMetaDatumEditorWidget = new DecalMetaDatumEditorWidget(200,100);
			this.addChild(ed);
			
			this.x = 50;
			this.y = 50;
			
			var data:DecalMetaDatumLE = DecalMetaDatumLE.makeUsingDims(4, 4, 30, 30);
			ed.setDataInFocus(data);
		}
		
	}//class
}//package