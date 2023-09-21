package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.toolSystems.levelEditor.leMap.ui.helpers.metaControllerUI.MDRBoxTransform;
	import JM_LIB.toolSystems.levelEditor.leMap.ui.helpers.metaControllerUI.MetaDataRegionBoxUI;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		public var base:Sprite = new Sprite();
		public var han:MetaDataRegionBoxUI;
		
	
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			this.addChild(base);
			
			han = new MetaDataRegionBoxUI();
			
			/*
			han.autoRenderOFF();
			han.setMapDims(30, 30);
			han.setTileWid(32);
			han.setTileHig(32);
			han.setTileX(0);
			han.setTileY(0);
			han.setWidInTiles(6);
			han.setHigInTiles(3);
			han.autoRenderON();
			*/
			
			
			han.autoRenderOFF();
			han.setMapDims(20, 15);
			han.setTileWid(32);
			han.setTileHig(32);
			han.setTileX(1);
			han.setTileY(1);
			han.setWidInTiles(6);
			han.setHigInTiles(6);
			han.autoRenderON();
			
			var tileX:int = han.tileX;
			var tileY:int = han.tileY;
			trace("hi");
			
			
			
			base.addChild(han);
			
			//han.x = 100;
			
			base.scaleX = 2;
			
			base.x = 50;
			base.y = 50;
			base.graphics.beginFill(0x00FF88, 0.5);
			base.graphics.drawRect(0, 0, 500, 500);
			base.graphics.endFill();
			
			
		}
		
	}
	
}