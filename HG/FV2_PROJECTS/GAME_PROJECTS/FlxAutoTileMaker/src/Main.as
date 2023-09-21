package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.toolSystems.flxAutoTileMaker.controller.VisualInterface;
	import JM_LIB.toolSystems.flxAutoTileMaker.model.AutoTileBufferMap;
	
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
			var atbm:AutoTileBufferMap = new AutoTileBufferMap(20, 20, 16, 16, 16);
			var view:VisualInterface   = new VisualInterface( atbm );
			this.addChild( view );
			
			
		}
		
	}
	
}