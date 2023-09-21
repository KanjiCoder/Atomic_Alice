package 
{
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	import adobe.utils.CustomActions;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.miniGames.autoMirror.AutoMirrorGameWithUI;
	import JM_LIB.miniGames.autoMirror.components.tileMapAMG.TileMapAMG_TOOL;
	import JM_LIB.gameObjects.tileCenta.TileCenta;
	import de.polygonal.math.PM_PRNG;
	import JM_LIB.plainOldData.IntPoint;
	import JM_LIB.plainOldData.PointPair;
	
	
	/**
	 * AUTO-GIGER STRIP GAME
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'AutoGigerTileSet.PNG')]private static var AUTO_TILE_STRIP:Class;
		[Embed(source = 'Pack01.PNG')]private static var PACK_01:Class;
		[Embed(source = 'Pack02.PNG')]private static var PACK_02:Class;
		[Embed(source = 'Pack03.PNG')]private static var PACK_03:Class;
		
		private var _miniGame:AutoMirrorGameWithUI;
		private var _tool:TileMapAMG_TOOL;
		
		private var _rGen:PM_PRNG = new PM_PRNG();
		
		private var _tCenta:TileCenta;
		
		private var _centaVec:Vector.<TileCenta> = new Vector.<TileCenta>(0);
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function createTileCentaTest():void
		{
			
			var fakeReturn:Boolean = false;
			
			_tCenta = new TileCenta();
			var p1:Array = [0, 0];
			var p2:Array = [0, 1];
			var p3:Array = [0, 2];
			var p4:Array = [0, 3];
			var p5:Array = [0, 4];
			var p6:Array = [0, 5];
			var p7:Array = [0, 6];
			var p8:Array = [0, 7];
			var p9:Array = [0, 8];
			var pa:Array = [0, 9];
			var pb:Array = [0, 10];
			var pc:Array = [0, 11];
			var pd:Array = [0, 12];
			var pe:Array = [0, 13];
			var pf:Array = [0, 14];
			
			var pg:Array = [0, 15];
			var ph:Array = [0, 16];
			var pi:Array = [0, 17];
			var pj:Array = [0, 18];
			var pk:Array = [0, 19];
			var pl:Array = [0, 20];
			var pm:Array = [0, 21];
			var pn:Array = [0, 22];
			var po:Array = [0, 23];
			var pp:Array = [0, 24];
			
			//var bod:Array = [p1, p2, p3, p4, p5, p6, p7, p8,p9,pa,pb,pc,pd,pe,pf];
			var bod:Array = [p1, p2, p3, p4, p5, p6, p7, p8, p9, pa, pb, pc, pd, pe, pf, pg, ph, pi, pj, pk, pl, pm, pn, po];// , pp];
			var wid:int = _tool.getCoreData().getWidthInTiles() - 1;
			var hig:int = _tool.getCoreData().getHeightInTiles() - 1;
			var bnd:PointPair = PointPair.make(0, 0, wid, hig);
			
			
			//DEBUG: Trying out spiral spawn:
			var rec:PointPair = new PointPair();
			var pX:int = 10;
			var pY:int = 10;
			var wD:int = 6;
			var hT:int = 6;
			rec.x0 = pX;
			rec.y0 = pY;
			rec.x1 = pX + wD - 1;
			rec.y1 = pY + hT - 1;
			_centaVec.push( TileCenta.makeUsingRec(rec,  bnd, _tool.getTile, _tool.setTile, _tool.killTile, 1, true) );
			_centaVec[0].enterThrashMode();
			fakeReturn = true;
			
			if (fakeReturn != true)
			{
				var bodOS:Array = new Array();
				for (var meow:int = 0; meow < bod.length; meow++)
				{
					bodOS[meow] = [0, 0];
				}
				
				var max:int = 15;
				var offsetAmount:IntPoint = new IntPoint();
				for (var i:int = 0; i < max; i++)
				{
					offsetAmount.ix = i * 1;
					offsetAmount.iy = 0;
					for (var os:int = 0; os < bod.length; os++)
					{
						bodOS[os][0] = bod[os][0] + offsetAmount.ix;
						bodOS[os][1] = bod[os][1] + offsetAmount.iy;
					}
					
					_tCenta = new TileCenta();
					_tCenta.init(bodOS, bnd, _tool.getTile, _tool.setTile, _tool.killTile, 1, true);
					//_tCenta.setTargetTile(29, 29, true);
					_tCenta.enterThrashMode();
					_centaVec.push(_tCenta);
				}
			}
			
			
			
		}//createTileCentaTest
		
		private function update(evt:Event):void
		{
			
			
			/*
			for each( _tCenta in _centaVec)
			{
				
				var xDir:int = 0;
				var yDir:int = 0;
				var rnd:int = _rGen.nextIntRange(1, 2);
				switch(rnd)
				{
					case 1:
						xDir = _rGen.nextSignedIntRange( -1, 1);
						break;
					case 2:
						yDir = _rGen.nextSignedIntRange( -1, 1);
						break;
					default:
						throw new Error("This should never happen!");
				}
				
				
				
				_tCenta.move(xDir, yDir);
			}
			*/
			
			for each(_tCenta in _centaVec)
			{
				_tCenta.update();
			}
			
			_tool.forceRedraw();
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var autoTileStripBitmap:BitmapData = new AUTO_TILE_STRIP().bitmapData;
			//_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, autoTileStripBitmap);
			_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, autoTileStripBitmap, false);
			//_miniGame.setLogoText("BAUXITE TEST");
			this.addChild(_miniGame);
			
			_tool = _miniGame.getTool();
			_tool.pushTileMapPack( new PACK_01().bitmapData, "PACK_01" );
			_tool.setSlideShowModeOnOff(false);
			_tool.clearCanvas();
			_tool.useMirroring = false;
			
			createTileCentaTest();
			this.addEventListener(Event.ENTER_FRAME, update);
		}//init
		
	}//class
}//package