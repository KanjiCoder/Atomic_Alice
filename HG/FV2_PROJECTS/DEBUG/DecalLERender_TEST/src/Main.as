package 
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.toolSystems.levelEditor.leMap.ui.helpers.metaControllerUI.MDRBoxTransform;
	import JM_LIB.toolSystems.levelEditor.leMap.ui.helpers.metaControllerUI.MetaDataRegionBoxUI;
	import JM_LIB.toolSystems.levelEditor.leMap.ui.helpers.decalEditWiget.DecalMetaDatumEditorWidget;
	import JM_LIB.toolSystems.levelEditor.leMap.components.decalMapCore.helpers.DecalMetaDatumLE;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		public var _bufferBM:BitmapData;
		public var _bufferVS:Bitmap;
		
		
		public var _decal:DecalMetaDatumLE = new DecalMetaDatumLE();
		public var _editor:DecalMetaDatumEditorWidget;
		public var _boxUI:MetaDataRegionBoxUI;
		
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
			//set initial decal info:
			_decal.text = "MakeGamesHappen";
			_decal.size = 50;
			
			var widInTiles:int = 30;
			var higInTiles:int = 30;
			var tileWid:int = 16;
			var tileHig:int = 16;
			var bufferWid:int = widInTiles * tileWid;
			var bufferHig:int = higInTiles * tileHig;
			
			_bufferBM = new BitmapData(bufferWid, bufferHig, true, 0x00);
			_bufferVS = new Bitmap( _bufferBM);
			this.addChild(_bufferVS );
			
			_editor = new DecalMetaDatumEditorWidget(100, bufferHig);
			_editor.x = bufferWid;
			_editor.y = 0;
			_editor.setDataInFocus(_decal);
			this.addChild(_editor);
			
			_boxUI = new MetaDataRegionBoxUI();
			_boxUI.autoRenderOFF();
			_boxUI.setMapDims(widInTiles, higInTiles);
			_boxUI.setTileWid(tileWid);
			_boxUI.setTileHig(tileHig);
			_boxUI.setTileX(1);
			_boxUI.setTileY(1);
			_boxUI.setWidInTiles(4);
			_boxUI.setHigInTiles(4);
			_boxUI.autoRenderON();
			
			_boxUI.setUserInteractTransformFinalizeNotifyFunction(endTrans, "endTrans");
			_editor.setCallbackFunction(editCallback, "editCallback");
			
			//_boxUI.
			this.addChild(_boxUI);
			
		}//doStuff
		
		private function editCallback(dec:DecalMetaDatumLE):void
		{
			//regardless, update the box ui:
			var dims:MDRBoxTransform = _boxUI.setDimsNoCallbacks(dec.tX, dec.tY, dec.wid, dec.hig);
			
			//dims may have been capped by UI when set:
			dec.tX = dims.tileXY.ix;
			dec.tY = dims.tileXY.iy;
			dec.wid = dims.dimInTiles.ix;
			dec.hig = dims.dimInTiles.iy;
			
			//redraw editor since data may have changed:
			_editor.refresh();
			
			if (true != DecalMetaDatumLE.validateSize(dec)) { return;}
			DecalMetaDatumLE.renderGlobal(dec, 16, 16, _bufferBM);
		}
		
		private function endTrans(box:MetaDataRegionBoxUI):void
		{
			var dec:DecalMetaDatumLE = _editor.getDataInFocus();
			dec.tX  = box.tileX;
			dec.tY  = box.tileY;
			dec.wid = box.widInTiles;
			dec.hig = box.higInTiles;
			
			_editor.refresh();
			
			DecalMetaDatumLE.renderGlobal(dec, 16, 16, _bufferBM);
			
			
		}//endTrans
		
	}//class
}//package