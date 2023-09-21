package 
{
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import JM_LIB.graphics.particles.parented.ParParSystem;
	import JM_LIB.graphics.particles.parented.ParParUpdater;
	import JM_LIB.miniGames.autoMirror.AutoMirrorGameWithUI;
	import JM_LIB.miniGames.autoMirror.components.tileMapAMG.TileMapAMG_TOOL;
	import JM_LIB.graphics.particles.parented.debug.ParParDebug;
	
	//import JM_LIB.geom.tileMap.polyTileClinger.helpers.updater.PTClingerUpdater;
	//import JM_LIB.geom.tileMap.polyTileClinger.PolyTileClinger;
	
	import JM_LIB.graphics.particles.parented.ParParSystemFactory;
	import JM_LIB.graphics.particles.parented.factories.ParParFactory;
	import JM_LIB.graphics.particles.parented.factories.oneFX.nestedDragonEgg.NestedDragonEggFactory;
	import JM_LIB.graphics.particles.parented.factories.oneFX.spiralDissolveCannon.SpiralDissolveCannonFactory;
	
	/**
	 * AUTO-GIGER STRIP GAME
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = 'AutoGigerTileSet.PNG')]private static var AUTO_TILE_STRIP:Class;
		[Embed(source = 'Pack01.PNG')]private static var PACK_01:Class;
		//[Embed(source = 'Pack02.PNG')]private static var PACK_02:Class;
		//[Embed(source = 'Pack03.PNG')]private static var PACK_03:Class;
		
		private var _miniGame:AutoMirrorGameWithUI;
		private var _tool:TileMapAMG_TOOL;
		
		/** The object that updates the position of PolyTileClinger objects. **/
		private var _pUpdater:ParParUpdater;
		//private var _sys:ParParSystem = ParParSystemFactory.makeOneParticleSystem(300, 300, 1, 1, 0, 0);
		//private var _sys:ParParSystem = ParParSystemFactory.makeChildlessParticleSystemExplosion(300, 300, 20, 5);
		//private var _sys:ParParSystem = ParParSystemFactory.makeParticleSystemWithOneParticleThatHasOneChild(300, 300, 10, 10, 30);
		//private var _sys:ParParSystem = ParParSystemFactory.makeOneChildParticleSystemExplosion(300, 300, 20, 15);
		//private var _sys:ParParSystem = ParParSystemFactory.makeParticleSystemWithOneMultiNestedParticle(300, 300);
		//private var _sys:ParParSystem = ParParFactory.toSystem( ParParFactory.makeDragonCircleEgg(300, 300, 30, 150, 30, 4));  //XXXXX
		//private var _sys:ParParSystem = ParParFactory.toSystem(ParParFactory.makeBubbleWrappedCircleEgg(1, 300, 300, 30, 150, 30, 1));
		///private var _sys:ParParSystem   = ParParFactory.toSystem( NestedDragonEggFactory.make() );
		//private var _sys:ParParSystem = ParParFactory.toSystem( ParParFactory.makeDragonCircleEgg(300, 300, 30, 0, 60, 14));  //XXXXX
		private var _sys:ParParSystem = ParParFactory.toSystem( SpiralDissolveCannonFactory.make() );
		
		/** The buffer we draw the clingers to. **/
		private var _buffer:BitmapData;
		/** The visible bitmap that we use so we can see the buffer. **/
		private var _buffer_VIS:Bitmap;
		
		private var _filter:BlurFilter = new BlurFilter(7, 7, 1);
		
		private var _cm:Array;
		private var _cMatrix:ColorMatrixFilter;
		
		private var zz:Point = new Point(0, 0);
		
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var autoTileStripBitmap:BitmapData = new AUTO_TILE_STRIP().bitmapData;
			_miniGame = new AutoMirrorGameWithUI(800, 640, this.stage, autoTileStripBitmap);
			//_miniGame.setLogoText("BAUXITE TEST");
			this.addChild(_miniGame);
			
			_tool = _miniGame.getTool();
			_tool.pushTileMapPack( new PACK_01().bitmapData, "PACK_01" );
			_tool.setSlideShowModeOnOff(true);
			
			_pUpdater = new ParParUpdater();
			_pUpdater.init(16, 16, 40, 40, _tool.getTile, "_tool.getTile");
			//_pUpdater.setAutoTileSet(1, PTClingerUpdater.AUTO_ANGLES); //Set autotile set #1 to be AUTO_ANGLES.
			
			//Use this function to get testing right away:
			//_pUpdater.addNewClingerOnEveryTile();
			
			//_pUpdater.addNewClingerOnEveryTile_usingSudoRandomSpeedArray([ -0.06, 0.06]);
			
			_buffer = new BitmapData(16 * 40, 16 * 40, true, 0x00);
			_buffer_VIS = new Bitmap( _buffer );
			this.addChild(_buffer_VIS);
			
			this.addEventListener(Event.ENTER_FRAME, updateLoop);
			
			_pUpdater.turnDebugDrawOn(_buffer);
			
			var r:Number = 0.98;
			var g:Number = 0.8;
			var b:Number = 0.4;//0.7;//0.9;
			var a:Number = 0.96;
			_cm = new Array();
			_cm=_cm.concat([r,0,0,0,0]);// red
            _cm=_cm.concat([0,g,0.3,0,0]);// green
            _cm=_cm.concat([0,0,b,0,0]);// blue
            _cm = _cm.concat([0, 0, 0, a, 0]);// alpha
			_cMatrix = new ColorMatrixFilter( _cm);
			
		}
		
		private function updateLoop(evt:Event):void
		{
			var num:int;
			var cautionNum:int = 61;
			
			ParParDebug.checkSystemIntegrity( _sys );
			if (ParParDebug._integrityCheckNumber == cautionNum)
			{
				trace("breakpoint");
				//put this here as one extra check to see if it was the data integrity check that was
				//causing the crash.
				//ParParDebug.checkSystemIntegrity( _sys );
			}
			
			_buffer.applyFilter(_buffer, _buffer.rect, zz, _filter);
			_buffer.applyFilter(_buffer, _buffer.rect, zz, _cMatrix);
			//_buffer.fillRect(_buffer.rect, 0x01);
			
			_pUpdater.update(_sys);
			
			
			ParParDebug.checkSystemIntegrity( _sys );
			if (ParParDebug._integrityCheckNumber == cautionNum)
			{
				trace("breakpoint");
			
			}
			
			
			
	
			
		}
		
	}//class
}//package