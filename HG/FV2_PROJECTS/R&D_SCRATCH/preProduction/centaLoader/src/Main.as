package 
{
	import de.polygonal.math.PM_PRNG;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import JM_LIB.graphics.filters.pixelPerPixel.animated.SquareBlurAnimFilterSurface;
	import JM_LIB.graphics.BitmapFillPatternUtil;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.components.tileMap.TileMapAMG_BASIC;
	import flash.display.Bitmap;
	import JM_LIB.plainOldData.IntPoint;
	import JM_LIB.plainOldData.PointPair;
	import JM_LIB.plainOldData.TileRect;
	import JM_LIB.UI.components.sprite.SetSizeSprite;
	import JM_LIB.UI.tileMap.interactSurf.TileMapInteractionsSurface;
	import JM_LIB.gameObjects.tileCenta.TileCenta;
	import JM_LIB.gameObjects.tileCenta.manager.TileCentaManager;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.filters.GlowFilter;
	import JM_LIB.UI.components.monoBlitterTextLine.MonoBlitterTextLine;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		//PERIOD, EXCLAIM, QUESTION.
		[Embed(source = 'fSixteen/PERCENT_16X16.png')]private static var PERCENT_16X16:Class;
		[Embed(source = 'fSixteen/GT_16X16.png')]private static var GT_16X16:Class;
		//[Embed(source = 'fSixteen/PERIOD_16X16.png')]private static var PERIOD_16X16:Class;
		//[Embed(source = 'fSixteen/EXCLAIM_16X16.png')]private static var EXCLAIM_16X16:Class;
		//[Embed(source = 'fSixteen/QUESTION_16X16.png')]private static var QUESTION_16X16:Class;
		
		[Embed(source = 'fSixteen/N_0_16X16.png')]private static var N_0_16X16:Class;
		[Embed(source = 'fSixteen/N_1_16X16.png')]private static var N_1_16X16:Class;
		[Embed(source = 'fSixteen/N_2_16X16.png')]private static var N_2_16X16:Class;
		[Embed(source = 'fSixteen/N_3_16X16.png')]private static var N_3_16X16:Class;
		[Embed(source = 'fSixteen/N_4_16X16.png')]private static var N_4_16X16:Class;
		[Embed(source = 'fSixteen/N_5_16X16.png')]private static var N_5_16X16:Class;
		[Embed(source = 'fSixteen/N_6_16X16.png')]private static var N_6_16X16:Class;
		[Embed(source = 'fSixteen/N_7_16X16.png')]private static var N_7_16X16:Class;
		[Embed(source = 'fSixteen/N_8_16X16.png')]private static var N_8_16X16:Class;
		[Embed(source = 'fSixteen/N_9_16X16.png')]private static var N_9_16X16:Class;
		
		[Embed(source = 'fSixteen/A_16X16.png')]private static var A_16X16:Class;
		//[Embed(source = 'fSixteen/B_16X16.png')]private static var B_16X16:Class;
		//[Embed(source = 'fSixteen/C_16X16.png')]private static var C_16X16:Class;
		[Embed(source = 'fSixteen/D_16X16.png')]private static var D_16X16:Class;
		[Embed(source = 'fSixteen/E_16X16.png')]private static var E_16X16:Class;
		//[Embed(source = 'fSixteen/F_16X16.png')]private static var F_16X16:Class;
		[Embed(source = 'fSixteen/G_16X16.png')]private static var G_16X16:Class;
		//[Embed(source = 'fSixteen/H_16X16.png')]private static var H_16X16:Class;
		[Embed(source = 'fSixteen/I_16X16.png')]private static var I_16X16:Class;
		//[Embed(source = 'fSixteen/J_16X16.png')]private static var J_16X16:Class;
		//[Embed(source = 'fSixteen/K_16X16.png')]private static var K_16X16:Class;
		[Embed(source = 'fSixteen/L_16X16.png')]private static var L_16X16:Class;
		//[Embed(source = 'fSixteen/M_16X16.png')]private static var M_16X16:Class;
		[Embed(source = 'fSixteen/N_16X16.png')]private static var N_16X16:Class;
		[Embed(source = 'fSixteen/O_16X16.png')]private static var O_16X16:Class;
		//[Embed(source = 'fSixteen/P_16X16.png')]private static var P_16X16:Class;
		//[Embed(source = 'fSixteen/Q_16X16.png')]private static var Q_16X16:Class;
		[Embed(source = 'fSixteen/R_16X16.png')]private static var R_16X16:Class;
		//[Embed(source = 'fSixteen/S_16X16.png')]private static var S_16X16:Class;
		//[Embed(source = 'fSixteen/T_16X16.png')]private static var T_16X16:Class;
		//[Embed(source = 'fSixteen/U_16X16.png')]private static var U_16X16:Class;
		//[Embed(source = 'fSixteen/V_16X16.png')]private static var V_16X16:Class;
		//[Embed(source = 'fSixteen/W_16X16.png')]private static var W_16X16:Class;
		//[Embed(source = 'fSixteen/X_16X16.png')]private static var X_16X16:Class;
		[Embed(source = 'fSixteen/Y_16X16.png')]private static var Y_16X16:Class;
		//[Embed(source = 'fSixteen/Z_16X16.png')]private static var Z_16X16:Class;
		
		
		//[Embed(source = 'rough_geometal.png')]private static var AUTO_TILE_STRIP:Class;
		[Embed(source = 'rough_geometal_BW.png')]private static var AUTO_TILE_STRIP:Class;
		
		[Embed(source = 'tile_ui.png')]private static var TILE_LAYOUT:Class;
		[Embed(source = 'ALICE_TEST_BG.png')]private static var ALICE_TEST_BG:Class;
		//[Embed(source = 'ALICE_TEST_BG02.png')]private static var ALICE_TEST_BG02:Class;
		
		//allows us to get simple bitmap text in game:
		private var _loadingCenterScreenText:MonoBlitterTextLine;
		private var _loadingCenterScreenText_DISP:Bitmap;//<<Bitmap. NOT BitmapData.
		
		private var _percentLoadedText:MonoBlitterTextLine;
		private var _percentLoadedText_DISP:Bitmap;
		
		///// LOADER BAR--//--LOADER BAR--//--LOADER BAR--//--LOADER BAR--//--LOADER BAR--//--LOADER BAR--//--LOADER BAR
		//Filter for the LOADING PROGRESS BAR:
		private var _loadBarFilter:SquareBlurAnimFilterSurface;
		
		/** The sample region used to fill the current percent loaded in the loader bar. **/
		private var _curLoaderBarSampleRegion:PointPair;
		
		/** The sample region used to fill the loader percent bar to 100% **/
		private var _maxLoaderBarSampleRegion:PointPair;
		
		/** The min% region that is used so we can calculate _curLoaderBarSampleRegion by
		 *  scaling between _minLoaderBarSampleRegion and _maxLoaderBarSampleRegion **/
		private var _minLoaderBarSampleRegion:PointPair;
		///// LOADER BAR--//--LOADER BAR--//--LOADER BAR--//--LOADER BAR--//--LOADER BAR--//--LOADER BAR--//--LOADER BAR
		
		//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//
		private var _isFlashing:Boolean = false;
		/** Keeps track of how long you have been flashing or NOT flashing for. **/
		private var _flashStateCounter:int = 0;
		
		private var _maxDurationOfFlash_ON:int = 5; //flash can't be too long.
		private var _minDurationOfFlash_ON:int = 1; //flash can be one frame.
		private var _curDurationOfFlash_ON:int=(_maxDurationOfFlash_ON + _minDurationOfFlash_ON)/2; //<<Falls between min and max.
		
		private var _maxDurationOfFlash_OFF:int = 90; //max duration of NO/OFF FLASH can be whatever.
		private var _minDurationOfFlash_OFF:int = 15;  //min duration of NO/OFF FLASH should not be too frequent.
		private var _curDurationOfFlash_OFF:int = (_maxDurationOfFlash_OFF + _minDurationOfFlash_OFF) / 2; //<<Falls between min and max.
		//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//--FLASHING--//
		
		private var _rGen:PM_PRNG = new PM_PRNG();
		
		/** every time we update, we incriment this. A hackish way to create a timeline for plugging in effects at different times. **/
		private var _updateTime:int = 0;
		
		//used to make the map transition from dark to full light. For dramatic effect:
		private var _timeToWaitBeforeKnotchingUpColor:int = 0;
		private var _mapBrightness:Number = 0;
		private var _cTrans:ColorTransform = new ColorTransform();
		
		/** A layer of perlin noise or some type of noise to give nice believable texture
		 *  to the background of the atomic alice loader. **/
		private var _gritBuffer:BitmapData;
		private var _gritLayer :Bitmap;
		
		/** Gradual snapping blows out the image a bit. But fills in those edges we need to fill in.
		 *  So, use it temporarily for a short burst. **/
		private var _gradualSnapTimer:int = 0;
		
		//private var _glowFilter:GlowFilter = new GlowFilter();
		private var _largGlowFilter:GlowFilter = new GlowFilter(0x0088FF, 0.1);
		
		//these subtle lines are good for once we are at 100% brightness for the tilemap.
		//private var _thinGlowFilter:GlowFilter = new GlowFilter(0x8800FF, 0.01);
		private var _thinGlowFilter:GlowFilter = new GlowFilter(0x00, 0.01);
		
		private var _aliceBG_01:BitmapData;
		//private var _aliceBG_02:BitmapData;
		
		//public var _tileMapAndInteractionsSurfaceContainer:SetSizeSprite;
		
		private var _interactSurf:TileMapInteractionsSurface;
		
		/** For displaying progress of loading using weird filter effects. **/
		private var _progBuffer:BitmapData;
		private var _progDisp:Bitmap;
		
		private var _filter:SquareBlurAnimFilterSurface;
		
		//private var _gradientOverlay:BitmapData;
		//private var _gradientOverlay_DISP:Bitmap;
		
		
		private var _mainTileMapBuffer:BitmapData;
		private var _basicMap:TileMapAMG_BASIC;
		
		/** The source graphics that the UI and tile-centas are made of. **/
		private var _autoSrc:BitmapData;
		private var _autoSrcUnTampered:BitmapData;
		
		//private var _autoSrc100:BitmapData;
		//private var _autoAlpha:BitmapData;
		private var ZZ:Point = new Point(0, 0);
		
		/** The BW bitmap that specifies the layout of our tile-based ui for the mini-game**/
		private var _tileLayout:BitmapData;
		
		private var _mgr:TileCentaManager;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function setLoaderPercent(inPercentLoaded:Number):void
		{
			_curLoaderBarSampleRegion = PointPair.weightedAverage(_minLoaderBarSampleRegion, _maxLoaderBarSampleRegion, inPercentLoaded, _curLoaderBarSampleRegion);
			_loadBarFilter.setSamplingBoundsUsingPointPair(_curLoaderBarSampleRegion);
			
			
			var perAsInt:int = int(inPercentLoaded * 100);
			if (perAsInt > 99) { perAsInt = 99;} //<<Cap at 99 because display cannot go to 100.
			var perAsString:String = perAsInt.toString();
			var missingZeros:int = 2 - perAsString.length;
			var percentMessage:String = "";
			
			if (missingZeros > 0)
			{
				for (var i:int = 0; i < missingZeros; i++)
				{
					percentMessage += "0";
				}
			}//missing zeros?
			
			
			percentMessage += (perAsString + "%");
			_percentLoadedText.renderTextLine(percentMessage);
			
			if (inPercentLoaded >= 1)
			{
				setReadyMessage();
			}
			
			
		}//set loader percent.
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var pixWid:int = 640;
			var pixHig:int = 480;
			
			var squareWid:int = Math.min(pixWid, pixHig);
			var squareHig:int = Math.min(pixWid, pixHig);
			
			var recWid:int = pixWid - squareWid;
			var recHig:int = pixHig; //the rectangle stands beside the box. Hence same size.
			
			initMonoBlitterTextObjects();
			this.addChild(_loadingCenterScreenText_DISP);
			_loadingCenterScreenText_DISP.scaleX = 2;
			_loadingCenterScreenText_DISP.scaleY = 2;
			_loadingCenterScreenText_DISP.x = 0 - (_loadingCenterScreenText_DISP.width / 2) + (squareWid / 2);
			_loadingCenterScreenText_DISP.y = 0 - (_loadingCenterScreenText_DISP.height / 2) + (squareHig / 2);
			
			this.addChild(_percentLoadedText_DISP);
			_percentLoadedText_DISP.scaleX = 2;
			_percentLoadedText_DISP.scaleY = 2;
			_percentLoadedText_DISP.x = squareWid - (_percentLoadedText_DISP.width / 2) + (recWid / 2);
			_percentLoadedText_DISP.y = 0 - (_percentLoadedText_DISP.height / 2) + (recHig / 2);
			_percentLoadedText_DISP.alpha = 0.5;
			
			_rGen.seed = 1;
			
			
			
			_curLoaderBarSampleRegion
			
			_gritBuffer = new BitmapData(pixHig, pixHig, true, 0x00);
			//_gritBuffer.perlinNoise(pixHig, pixWid, 8, 1, true, true, 7);
			_gritBuffer.noise(1, 1, 255, 7, true);
			_gritLayer = new Bitmap( _gritBuffer);
			
			//Create container that holds the tilemap buffer and the interactions surface:
			//_tileMapAndInteractionsSurfaceContainer = new SetSizeSprite();
			//_tileMapAndInteractionsSurfaceContainer.setSize(pixWid, pixHig);
			
			
			//Create tilemap and it's buffer:
			_tileLayout = new TILE_LAYOUT().bitmapData;
			_autoSrc = new AUTO_TILE_STRIP().bitmapData;
			_autoSrcUnTampered = new AUTO_TILE_STRIP().bitmapData;
			
			//A bitmap we fill with different alpha values.
			//_alphaStrip = new BitmapData(_autoSrc100.width, _autoSrc100.height, true, 0x00000000);
			
			_mainTileMapBuffer = new BitmapData(pixWid, pixHig, true, 0xFFFF0000);
			_basicMap = TileMapAMG_BASIC.makeUsingBufferAutoTileSRC(_mainTileMapBuffer, _autoSrc);
			_basicMap.data.loadFromBitmapBW(_tileLayout);
			
			var tileWid:int = _basicMap.data.getTileWid();
			var tileHig:int = _basicMap.data.getTileHig();
			
			
			_interactSurf = new TileMapInteractionsSurface();// (_mainTileMapBuffer, inWidInTiles, inHigInTiles);
			_interactSurf.regBufferToTrack(_mainTileMapBuffer);
			_interactSurf.regSizeOfATile(tileWid, tileHig);
			
			//Assemble objects and attach to display:
		
			this.addChild( _interactSurf );
			_interactSurf.regSizeOfATile(tileWid, tileHig);
			
			_mgr = new TileCentaManager();
			_mgr.init(getMapBounds, _basicMap.ctrl.getTile, setTile, killTile, getIsTileDead, getIsOccupied,
			          true, 1);
			
			
			
			
			
			_basicMap.ctrl.autoTileAll();
			
			
			
			/*
			_progBuffer = new BitmapData(160, 480, true, 0xFF0088FF);
			_progDisp = new Bitmap( _progBuffer);
			_progDisp.x = 480;
			_progDisp.y = 0;
			*/
			
			//Make the entire buffer for progress display the size of the game/ui area.
			//why? Use awesome effects to animate the loader. Also, your gun is going to be able to destroy the UI
			//if you point it at the UI.
			//_progBuffer = new BitmapData(640, 480, true, 0xFF112244);
			_progBuffer = new BitmapData(640, 480, true, 0x00);
			_progDisp = new Bitmap(_progBuffer);
		    _progDisp.x = _progDisp.y = 0;
			
			_filter = new SquareBlurAnimFilterSurface();
			_aliceBG_01 = new ALICE_TEST_BG().bitmapData;
			//_aliceBG_02 = new ALICE_TEST_BG02().bitmapData;
			_filter.init(_aliceBG_01, _progBuffer);
			
			_filter.percentMaxCol = 0.1;
			_filter.percentMaxHig = 0.1;
			_filter.percentMaxWid = 0.1;
			//_filter.useGradualSnapping = true;
			
			_filter.plotStyle = SquareBlurAnimFilterSurface.PLOT_RANDOM;
			//_filter.drawingAlpha = 0.1;
			_filter.drawingAlpha = 0.05;
			//_filter.drawingAlpha = 0.01; //takes very long. But very subtle and creepy if they stick around long enough.
			_filter.useBlur = true;
			_filter.setSamplingBounds(0, 0, 29, 29); //stay out of the progress bar area.
			
			//make the filter used for the loading bar:
			_loadBarFilter = new SquareBlurAnimFilterSurface();
			_loadBarFilter.init(_aliceBG_01, _progBuffer);
			_loadBarFilter.percentMaxCol = 0.1;
			_loadBarFilter.percentMaxHig = 0.1;
			_loadBarFilter.percentMaxWid = 0.1;
			_loadBarFilter.plotStyle = SquareBlurAnimFilterSurface.PLOT_SCANLINE;
			_loadBarFilter.scanForward = false;
			_loadBarFilter.scanlineStepX = 1;
			_loadBarFilter.scanLineStepY = 1;
			_loadBarFilter.drawingAlpha = 0.05;
			_loadBarFilter.useBlur = false; //This blur might not be being applied to the correct output region.
			_loadBarFilter.useGradualSnapping = true;
			_loadBarFilter.doChannelFlipping = false;
			_loadBarFilter.widChannel = SquareBlurAnimFilterSurface.CHANNEL_INDEX_GREEN;
			_loadBarFilter.higChannel = SquareBlurAnimFilterSurface.CHANNEL_INDEX_GREEN;
			_loadBarFilter.colChannel = SquareBlurAnimFilterSurface.CHANNEL_INDEX_GREEN;
			_loadBarFilter.setSamplingBounds(30, 0, 39, 29); //the 160x480 proportioned loading bar strip region.
			
			_curLoaderBarSampleRegion = new PointPair();
			_maxLoaderBarSampleRegion = new PointPair();
			_minLoaderBarSampleRegion = new PointPair();
			//set MAX bar:
			_maxLoaderBarSampleRegion.x0 = 30;
			_maxLoaderBarSampleRegion.y0 = 0;
			_maxLoaderBarSampleRegion.x1 = 39;//max of 40 wid.
			_maxLoaderBarSampleRegion.y1 = 29;//max of 30 hig.
			//set MIN bar:
			_minLoaderBarSampleRegion.x0 = _maxLoaderBarSampleRegion.x0; //<<This is same as MAX-BAR REF because WIDTH of loader bar is not changing. Only Height.
			_minLoaderBarSampleRegion.y0 = _maxLoaderBarSampleRegion.y1; //TOP-SCREEN ref is same as MAX-BAR's bottom-screen ref because it is representing shrunk down size.
			_minLoaderBarSampleRegion.x1 = _maxLoaderBarSampleRegion.x1; //BOTTOM SCREEN ref is same as MAX BAR because loaderbar is anchored at bottom of screen.
			_minLoaderBarSampleRegion.y1 = _maxLoaderBarSampleRegion.y1; //BOTTOM SCREEN ref is same as MAX BAR because loaderbar is anchored at bottom of screen.
			
			
			this.addChild(_progDisp);
			this.addChild(_gritLayer);
			this.setChildIndex(_progDisp, 0);
			this.setChildIndex(_gritLayer, 1);
			this.setChildIndex(_loadingCenterScreenText_DISP, this.numChildren - 1); //bring to front.
			this.setChildIndex(_percentLoadedText_DISP, this.numChildren - 1); //bring to front.
			
			_gritLayer.blendMode = BlendMode.MULTIPLY;
			_gritLayer.alpha = 0.5;
			
			//_gradientOverlay = new BitmapData(pixWid, pixHig, true, 0x00);
			//BitmapFillPatternUtil.makeRectangularGradient(_gradientOverlay, 0x00, 0xFFFF0000, true);
			//BitmapFillPatternUtil.makeSimpleSquareGradient(_gradientOverlay, 0x00, 0xFFFF0000, true);
			//_gradientOverlay_DISP = new Bitmap(_gradientOverlay);
			//_gradientOverlay_DISP.blendMode = BlendMode.ADD;
			//this.addChild(_gradientOverlay_DISP);
			//interactionsSurface.blendMode = BlendMode.HARDLIGHT;
			
			//cannot spawn centawals till the filter is set up:
			/////////////////////////////////////////////////////////////////////
			var tc:TileCenta = _mgr.spawnTileRectStyle(3, 3, 4, 4, "M", false);
			tc.enterBoaConstrictorMode();
			tc = _mgr.spawnTileRectStyle(10, 10, 4, 4, "M", false);
			tc.enterBoaConstrictorMode();
			tc = _mgr.spawnTileRectStyle(10, 2, 4, 4, "M", false);
			tc.enterBoaConstrictorMode();
			tc = _mgr.spawnTileRectStyle(20, 2, 4, 4, "M", false);
			tc.enterBoaConstrictorMode();
			tc = _mgr.spawnTileRectStyle(20, 20, 4, 4, "M", false);
			tc.enterBoaConstrictorMode();
			
			tc = _mgr.spawnTileRectStyle(25, 25, 4, 4, "M", false);
			tc.enterBoaConstrictorMode();
			tc = _mgr.spawnTileRectStyle(25, 20, 4, 4, "M", false);
			tc.enterBoaConstrictorMode();
			tc = _mgr.spawnTileRectStyle(20, 25, 4, 4, "M", false);
			tc.enterBoaConstrictorMode();
			/////////////////////////////////////////////////////////////////////
			
			//_interactSurf.alpha = 0;
			
			//AT VERY END!!!
			setLoaderPercent(0);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}//init
		
		/** Sets the brightness of the tilemap by tampering with the values. **/
		private function setTileMapBrightness0255(inBrightnessPercent:Number, inAlphaPercent:Number):void
		{
			_cTrans.alphaMultiplier = inAlphaPercent;
			
			_cTrans.redMultiplier = inBrightnessPercent;
			_cTrans.greenMultiplier = inBrightnessPercent;
			_cTrans.blueMultiplier = inBrightnessPercent;
			
			_autoSrc.fillRect(_autoSrc.rect, 0x00);
			_autoSrc.draw(_autoSrcUnTampered, null, _cTrans);
			_basicMap.view.forceRedraw();
		}
		
		private function onEnterFrame(evt:Event):void
		{
			_updateTime++;
			
			var pulseCycleFrames:int = 64;
			var halfCycle:int = pulseCycleFrames / 2;
			var pulsePer:Number = (_updateTime % pulseCycleFrames) / halfCycle;
			if (pulsePer > 1) 
			{ 
				pulsePer = 1 - (pulsePer - 1);
			}
			
			
			
			
			
			_loadingCenterScreenText_DISP.alpha = pulsePer;
			_percentLoadedText_DISP.alpha = (pulsePer + 1) * 0.5; //offset to range of 1-2, then divide by 2 to get 0.5 to 1.
			
			//fake the progress for now:
			var FPS:int = 30;
			var fakePercentLoaded:Number = _updateTime / (FPS * 60); //60 seconds to full.
			if (fakePercentLoaded > 1) { fakePercentLoaded = 1; }
			setLoaderPercent(fakePercentLoaded);
			
			
			_mgr.update();
			_loadBarFilter.update();
			
			
			//flash effect update:
			_flashStateCounter++;
			if (_isFlashing)
			{
				if(_flashStateCounter > _curDurationOfFlash_ON)
				{
					_curDurationOfFlash_OFF = _rGen.nextIntRange(_minDurationOfFlash_OFF, _maxDurationOfFlash_OFF);
					_isFlashing = false;
					_flashStateCounter = 0;
				}
				_gritLayer.blendMode = BlendMode.ADD;
			}
			else
			{
				if (_flashStateCounter > _curDurationOfFlash_OFF)
				{
					_curDurationOfFlash_ON = _rGen.nextIntRange(_minDurationOfFlash_ON, _maxDurationOfFlash_ON);
					_isFlashing = true;
					_flashStateCounter = 0;
				}
				_gritLayer.blendMode = BlendMode.MULTIPLY;
			}//flash control.
			
			
			//only edit noise if you can actually see the buffer:
			if (_gritLayer.alpha > 0)
			{
				_gritBuffer.noise(_updateTime, 0, 255, 7, true);			
			}//grit layer.alpha visible?
			
			
			
			if (_interactSurf.alpha < 1)
			{
				_interactSurf.alpha += 0.004;
			}
			
			
			if (_mapBrightness < 1)
			{
				_filter.useGradualSnapping = false;
				_mainTileMapBuffer.applyFilter(_mainTileMapBuffer, _mainTileMapBuffer.rect, ZZ, _largGlowFilter);
				
				_timeToWaitBeforeKnotchingUpColor--;
				if (_timeToWaitBeforeKnotchingUpColor <= 0)
				{
					_mapBrightness += 0.01;
					_timeToWaitBeforeKnotchingUpColor = 10;
					setTileMapBrightness0255(_mapBrightness,1);
				}
			}
			else
			{
				_gradualSnapTimer++;
				_filter.useGradualSnapping = (_gradualSnapTimer < 200 );
				
				_mainTileMapBuffer.applyFilter(_mainTileMapBuffer, _mainTileMapBuffer.rect, ZZ, _thinGlowFilter);
				
				_filter.update();
				
				if (false == _filter.useGradualSnapping)
				{
					if (_gritLayer.alpha > 0)
					{
						_gritLayer.alpha -= 0.002;
					}
				}
				
			}
			
			
			_basicMap.view.draw();
			//_basicMap.view.forceRedraw();
		}
		
		private function getIsOccupied(inTileX:int, inTileY:int):Boolean
		{
			var tileValue:int = _basicMap.ctrl.getTile(inTileX, inTileY);
			return (0 != tileValue);
		}
		
		private function getIsTileDead(inTileX:int, inTileY:int):Boolean
		{
			var tileValue:int = _basicMap.ctrl.getTile(inTileX, inTileY);
			return (0 == tileValue);
		}//getIsTileDead
		
		private function killTile(inTileX:int, inTileY:int):void
		{
			_basicMap.ctrl.setTile(inTileX, inTileY, 0);
		}//killTile
		
		private function setTile(inTileX:int, inTileY:int, inTileValue:int):void
		{
			_basicMap.ctrl.setTile(inTileX, inTileY, inTileValue);
			_filter.doDraw(inTileX, inTileY);
		}
		
		private function getMapBounds():PointPair
		{
			var out:PointPair = new PointPair();
			out.x0 = 1;
			out.y0 = 1;
			out.x1 = 28;
			out.y1 = 28;
			return out;
		}//getMapBounds
		
		private function initMonoBlitterTextObjects():void
		{
			var _loadingMessage:String = "LOADING";
			var numCharSlots:int = _loadingMessage.length;
			_loadingCenterScreenText = new MonoBlitterTextLine();
			_loadingCenterScreenText_DISP = new Bitmap();
			var c:Array = new Array();
			
			c.push(["%", new PERCENT_16X16().bitmapData]);
			c.push([">", new GT_16X16().bitmapData]);
			//c.push(["!", new EXCLAIM_16X16().bitmapData]);
			//c.push([".", new PERIOD_16X16().bitmapData]);
			//c.push(["?", new QUESTION_16X16().bitmapData]);
			
			c.push( ["0", new N_0_16X16().bitmapData ] );
			c.push( ["1", new N_1_16X16().bitmapData ] );
			c.push( ["2", new N_2_16X16().bitmapData ] );
			c.push( ["3", new N_3_16X16().bitmapData ] );
			c.push( ["4", new N_4_16X16().bitmapData ] );
			c.push( ["5", new N_5_16X16().bitmapData ] );
			c.push( ["6", new N_6_16X16().bitmapData ] );
			c.push( ["7", new N_7_16X16().bitmapData ] );
			c.push( ["8", new N_8_16X16().bitmapData ] );
			c.push( ["9", new N_9_16X16().bitmapData ] );
			
			c.push( ["A", new A_16X16().bitmapData ] );
			//c.push( ["B", new B_16X16().bitmapData ] );
			//c.push( ["C", new C_16X16().bitmapData ] );
			c.push( ["D", new D_16X16().bitmapData ] );
			c.push( ["E", new E_16X16().bitmapData ] );
			//c.push( ["F", new F_16X16().bitmapData ] );
			c.push( ["G", new G_16X16().bitmapData ] );
			//c.push( ["H", new H_16X16().bitmapData ] );
			c.push( ["I", new I_16X16().bitmapData ] );
			//c.push( ["J", new J_16X16().bitmapData ] );
			//c.push( ["K", new K_16X16().bitmapData ] );
			c.push( ["L", new L_16X16().bitmapData ] );
			//c.push( ["M", new M_16X16().bitmapData ] );
			c.push( ["N", new N_16X16().bitmapData ] );
			c.push( ["O", new O_16X16().bitmapData ] );
			//c.push( ["P", new P_16X16().bitmapData ] );
			//c.push( ["Q", new Q_16X16().bitmapData ] );
			c.push( ["R", new R_16X16().bitmapData ] );
			//c.push( ["S", new S_16X16().bitmapData ] );
			//c.push( ["T", new T_16X16().bitmapData ] );
			//c.push( ["U", new U_16X16().bitmapData ] );
			//c.push( ["V", new V_16X16().bitmapData ] );
			//c.push( ["W", new W_16X16().bitmapData ] );
			//c.push( ["X", new X_16X16().bitmapData ] );
			c.push( ["Y", new Y_16X16().bitmapData ] );
			//c.push( ["Z", new Z_16X16().bitmapData ] );
			
			
			_loadingCenterScreenText.initUsingCharBitmapPairs(c, numCharSlots);
			
			_loadingCenterScreenText.renderTextLine(_loadingMessage);
			_loadingCenterScreenText_DISP.bitmapData = _loadingCenterScreenText.getBuffer();
			
			
			_percentLoadedText = new MonoBlitterTextLine();
			_percentLoadedText.initUsingCharBitmapPairs(c, 3); //example: "99%". No 100%.
			_percentLoadedText.renderTextLine("00%");
			_percentLoadedText_DISP = new Bitmap();
			_percentLoadedText_DISP.bitmapData = _percentLoadedText.getBuffer();
			_percentLoadedText_DISP.blendMode = BlendMode.MULTIPLY;
			
			
		}//initMonoBlitterTextObjects
		
		private function setReadyMessage():void
		{
			//NOTE: Message should have same length as "LOADING";
			                                       //READY>>
			                                       //LOADING
			_loadingCenterScreenText.renderTextLine("READY>>");
		}
		
	}//class
}//package