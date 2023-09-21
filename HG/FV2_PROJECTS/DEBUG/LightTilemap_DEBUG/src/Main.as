package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import JM_LIB.graphics.lighting.lightTilemap.LightTilemap;
	import JM_LIB.graphics.lighting.lightTilemap.LightTile;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		private var _lm           :LightTilemap;
		private var _bmVis        :Bitmap;
		private var _bmDat        :BitmapData;
		private var _tileWidth    :int = 16;
		private var _tileHeight   :int = 16;
		private var _widthInTiles :int = 44;
		private var _heightInTiles:int = 44;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_lm = new LightTilemap(_tileWidth, _tileHeight, _widthInTiles, _heightInTiles);
			
			//_bmDat = _lm.getBlockBitmap();
			_bmDat = _lm.getBlurrBitmap();
			
			
			
			_bmVis = new Bitmap( _bmDat );
			this.stage.addEventListener(MouseEvent.CLICK, onClickCanvas);
			
			this.stage.addChild(_bmVis);
		}
		
		public function makeError():void
		{
			_lm.makeLight(1, 1,    0, 1, 0, 0, false);
			_lm.mapIntegrityCheck();
			_lm.makeLight(2, 1,    0, 0, 0, 0, false);
			_lm.mapIntegrityCheck();
			_lm.render();
			
		}
		
		public function onClickCanvas(mev:MouseEvent):void
		{
			
			//makeError();
			//return;
			
			if (_lm.maxIntensityColor == 0xFFFF0000)
			{
				_lm.maxIntensityColor = 0xFF00FF00;
			}else
			if (_lm.maxIntensityColor == 0xFF00FF00)
			{
				_lm.maxIntensityColor = 0xFF0000FF;
			}else
			if (_lm.maxIntensityColor == 0xFF0000FF)
			{
				_lm.maxIntensityColor = 0xFF880000;
			}else
			
			if (_lm.maxIntensityColor == 0xFF880000)
			{
				_lm.maxIntensityColor = 0xFF008800;
			}else
			if (_lm.maxIntensityColor == 0xFF008800)
			{
				_lm.maxIntensityColor = 0xFF000088;
			}else
			if (_lm.maxIntensityColor == 0xFF000088)
			{
				_lm.maxIntensityColor = 0xFFFF0000;
			}else
			{
				_lm.maxIntensityColor == 0xFFFF0000;
			}
			
			
			
			//Calculate TileX, TileY based on mouse position:
			var tileX:int = mev.localX / _tileWidth;
			var tileY:int = mev.localY / _tileHeight;
			
			if (tileX > _widthInTiles || tileY > _heightInTiles)
			{
				//_lm.mapIntegrityCheck();
				//_lm.render();
				//trace("total LightTile(s) made: " + LightTile.totalMade );
				_lm.clear();
				return;
			}
			
			//Set a light there:
			//_lm.makeLight(tileX, tileY, 4, 4, 6, 6, false);
			_lm.makeLight(tileX, tileY, 7, 7, 7, 7, true);
			//_lm.makeLight(tileX, tileY, 1, 1, 1, 1, false);
			
			_lm.render();
			trace("total LightTile(s) made: " + LightTile.totalMade );
			
			_lm.mapIntegrityCheck();
		}
		
		
		
	}
	
}