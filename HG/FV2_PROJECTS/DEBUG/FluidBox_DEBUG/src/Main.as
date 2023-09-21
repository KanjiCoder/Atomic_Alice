package 
{
	
	
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.UI.components.fluidBox.FluidBoxUI;
	import JM_LIB.UI.components.fluidBox.FluidBoxMasterCage;
	import JM_LIB.UI.components.fluidBox.HackSizeSprite;
	
	/**
	 * ...
	 * @author 
	 */
	//[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	public class Main extends Sprite 
	{
		
		public var f1:FluidBoxUI;
		public var fLEFT:FluidBoxUI;
		public var fRIGHT:FluidBoxUI;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			doTest();
		}
		
		private function doTest():void
		{
			FluidBoxMasterCage.make(this.stage);
			
			/*
			var debugSprite:Sprite = new Sprite();
			debugSprite.graphics.beginFill(0xFF0000, 0.5);
			debugSprite.graphics.drawCircle(0, 0, 40);
			debugSprite.graphics.endFill();
			this.stage.addChild(debugSprite);
			debugSprite.addEventListener(Event.RESIZE, onDebugResize);
			*/
			
			/*
			var hackSprite:HackSizeSprite = new HackSizeSprite();
			hackSprite.setSize(100, 100);
			this.stage.addChild(hackSprite);
			*/
			
			
			f1 = new FluidBoxUI(FluidBoxMasterCage.getCage(), 640, 480);
			f1.setDebugColor(0x2200FF00);
			f1.setProportionLock(true);
			//f1.clingToLeftEdge(false);
			
			//this works!
			//f1.clingToLeftEdge(false);
			//f1.clingToTopEdge(false);
			
			//this works!
			f1.centerHorizontallyOnXAxis(false);
			f1.centerVerticallyOnYAxis(false);
			
			//f1.centerVerticallyOnYAxis(false);
			//f1.clingToLeftEdge(false);
			
			//f1.centerHorizontallyOnXAxis(false);
			//f1.clingToTopEdge(false);
			
			fLEFT = new FluidBoxUI(f1, 480, 480);
			fLEFT.clingToLeftEdge(false);
			fLEFT.centerVerticallyOnYAxis(false);
			fLEFT.setDebugColor(0xFF008800);
			
			fRIGHT = new FluidBoxUI(f1, 160, 480);
			fRIGHT.clingToRightEdge(true);
			fRIGHT.centerVerticallyOnYAxis(false);
			fRIGHT.setDebugColor(0xFFFF0000);
			
			f1.updateUI();
			fLEFT.updateUI();
			fRIGHT.updateUI();
			
		}
		
		private function onDebugResize(evt:Event):void
		{
			trace("hi");
		}
		
	}//class
}//package