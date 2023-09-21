package  
{
	/// preloader always at 100%? help here:
	///  http://www.flashdevelop.org/community/viewtopic.php?f=13&t=3365
	/*
	2) Make the Preloader your project main class (right-click > Always Compile).

	3) Now to compile your original main class:
	- open the project properties,
	- Compiler Options tab > Addtional Compiler Options
	- add: -frame main com.foo.Main

	So now you have a multiframe SWF, the Preloader can show a splash screen and a loading bar, and your original main class will be compiled in frame 2 of the SWF.

	PS: obviously, replace 'com.foo.Main' by your original main class qualified name.
	*/
	
	
	import JM_LIB.preLoaders.atomicAlice.AtomicAlicePreLoader;
	
	//YES: This is causing the other game code to be imported.
	//Should put all pre-loader code it it's own library that does NOT reference any other libraries.
	//By taking these out, does the preloader work better?
	//import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.analyticsRegistries.AnaReg;
	//import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.analyticsRegistries.AnaRegEvents;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import flash.utils.getTimer;
	
	import flash.display.MovieClip;
	//import JM_LIB.miniGames.spiralGraph.SpiralGraphGameWithUI;
	//import JM_LIB.miniGames.autoMirror.AutoMirrorGameWithUI;
	/**
	 * ...
	 * @author 
	 */
	public class Preloader extends MovieClip
	{
		/** Keeps track of how many times the progress event fired. **/
		private var _progressTimes:int = 0;
		
		
		//private var _debugTotal:TextField = new TextField();
		//private var _debugLoaded:TextField = new TextField();
		//private var _debugPer:TextField = new TextField();
		//private var _debugProgTimes:TextField = new TextField();
		
		//[Embed(source = 'AutoTileStrip.png')]private static var AUTO_TILE_STRIP:Class;
		
		/** Seeing if putting back minigame somehow puts UI back... **/
		//private var _miniGame:AutoMirrorGameWithUI;
		
		/** The core loader class that will be attached to this preloader. **/
		private var _preLoaderCore:AtomicAlicePreLoader;
		
		/** Does the pre-loader core have the authority to start the game? **/
		private var _hasAuthorityToStart:Boolean = false;
		
		public function Preloader() 
		{
			
			
			//AnaReg.init(this); //initilize analytics in the pre-loader. We want to know if people are bailing out at the pre-loader.
			//AnaReg.trackEvent(AnaRegEvents.PRELOADER_START);
			
			//_miniGame = new AutoMirrorGameWithUI(640, 480, this.stage, new AUTO_TILE_STRIP().bitmapData, false);
			//this.addChild(_miniGame);
			//_miniGame.clearCanvas(); //so "Click&DRAG!!!" does not interfear with loading percent message.
			
			_preLoaderCore = new AtomicAlicePreLoader(640, 480);
			
			//TODO: DO what you can do to skip the preloader stuff when in debug mode:
			CONFIG::debug
			{
				trace("do nothing");
				//_preLoaderCore.demoModeOFF();
				//_preLoaderCore.skipTheWarningScreen();
			}
			
			this.addChild(_preLoaderCore);
			
			if (stage) {
				
				//Commented this out. Now pre-loader centers correctly.
				//And game still centers correctly as well.
				//stage.scaleMode = StageScaleMode.NO_SCALE;
				//stage.align = StageAlign.TOP_LEFT;
			}//stage?
			
			//commenting these two out in an attempt to figure out what
			//is wrong with preloader progress bar.
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			
			//this.addEventListener(Event.ENTER_FRAME, fakeProgressEvent);
			
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			
			//DEBUGGIN:
			/*
			_debugTotal.textColor = 0xFFFFFF;
			_debugLoaded.textColor = 0x00FF00;
			_debugPer.textColor = 0x00FFFF;
			_debugProgTimes.textColor = 0xFFFFFF;
			this.addChild(_debugTotal);
			this.addChild(_debugLoaded);
			this.addChild(_debugPer);
			this.addChild(_debugProgTimes);
			_debugLoaded.y = _debugTotal.y + _debugTotal.height;
			_debugPer.y = _debugLoaded.y + _debugLoaded.height;
			_debugProgTimes.y = _debugPer.y + _debugPer.height;
			*/
		
		}//rawer!!
		

		
		private function ioError(e:IOErrorEvent):void 
		{
			var msg:TextField = new TextField();
			msg.textColor = 0xFF0000;
			msg.text = "ioError";
			this.addChild(msg);
			//trace(e.text);
		}
		
		private function fakeProgressEvent(evt:Event):void
		{
			var bLoaded:int = _progressTimes;
			var bTotal :int = 9000;
			if (bLoaded > bTotal) { bLoaded = bTotal;}
			var pe:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS, false, false, bLoaded, bTotal);
			progress(pe);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			_progressTimes++;
			
			//DEBUG:
			//_debugTotal.text = e.bytesTotal.toString();
			//_debugLoaded.text = e.bytesLoaded.toString();
			//_debugProgTimes.text = _progressTimes.toString();
			
			var percentLoaded:Number = (e.bytesLoaded / e.bytesTotal);
			//_debugPer.text = percentLoaded.toString();
		
			_preLoaderCore.setPercentLoaded( percentLoaded );
		}//progress
		
		/** not sure what this is all about. Better read up on preloaders a bit. **/
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop(); //<<Function is stopping this object because preloader extends from movieclip.
				loadingFinished();
			}
		}//check frame.
		
		private function loadingFinished():void 
		{
			//return; //DEBUG To see last frame of pre-loader.
			trace("Preloader_old finished!");
			
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			//this object would like to startup the game now.
			//but the _preLoaderCore will have the final say on that.
			startup();
		}//loadingFinished
		
	
		/** Startup gives the preloader core the AUTHORITY to start the game. But does not necessarily load the game
		 *  until the preloader core decides to do it.  The PreLoader core will REMOVE ITSELF when it decides to launch
		 *  the game. **/
		private function startup():void 
		{
			_hasAuthorityToStart = true;
			_preLoaderCore.giveAliceTheLaunchCodes( launchTheGame , "Preloader.launchTheGame");
			
		}//startup
		
		private function launchTheGame():void
		{
			if (false == _hasAuthorityToStart)
			{
				//throw new Error("Does not have authority to start!");
				var _msgTXT:TextField = new TextField();
				_msgTXT.textColor = 0xFF0000;
				_msgTXT.text = "No authority error";
				this.addChild(_msgTXT);
				return;
			}
			
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
			
			//track the end of the preloader.
			//AnaReg.trackEvent(AnaRegEvents.PRELOADER_END);
		}//launch game.
		
		
	}//class
}//package