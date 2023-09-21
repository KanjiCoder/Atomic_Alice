package 
{
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import GameSpecificRegistries.Bomber01.FontReg;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.UI.buttons.bitmapButton.BitmapButton;
	import JM_EXT.com.adobe.utils.BitmapOpenerUtil;
	import JM_LIB.graphics.filters.pixelPerPixel.animated.SquareBlurAnimFilterSurface;
	import JM_LIB.UI.textUtils.UITextUtils;
	
	/**
	 * Trying out a filter that looks a the RGB of an image and maps it to rectangles whos width and height are related to the RGB value of the pixel.
	 * R = width percent of the rectangle. 100% == to the boarder of the screen.
	 * G = height percent of the rectangle. 100% == to the boarder of the screen.
	 * 
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		private var _bmButton:BitmapButton;
		private var _bmOpener:BitmapOpenerUtil;
		private var _filter:SquareBlurAnimFilterSurface;
		private var _disp:Bitmap;
		
		
		
		private var _textLabel:BitmapButton;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_bmButton = BitmapButton.make(new BitmapData(30, 30, true, 0xFFFF0000), "", null, onButtonPress);
			this.addChild(_bmButton);
			
			_bmOpener = new BitmapOpenerUtil();
			
			_filter = new SquareBlurAnimFilterSurface();
			_disp = new Bitmap();
			this.addChild(_disp);
			
			
			_filter.percentMaxCol = 1;
			_filter.percentMaxHig = 0.1;
			_filter.percentMaxWid = 0.1;
			_filter.plotStyle = SquareBlurAnimFilterSurface.PLOT_RANDOM;
			_filter.drawingAlpha = 0.5;
			//_filter.drawingAlpha = 0.01; //takes very long. But very subtle and creepy if they stick around long enough.
			_filter.useBlur = true;
			
			
			//doInitHackForDeviantArt();
			
			this.addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		private function update(evt:Event):void
		{
			_filter.update();
		}
		
		private function doInitHackForDeviantArt():void
		{
			_filter.init(new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00) );
			_disp.bitmapData = _filter.getOutputBuffer();
			_bmButton.visible = false;
			
			
			var _tf:TextField = new TextField();
			_tf.selectable = false;
			_tf.text = "Atomic Alice Is Near";
			_tf.width = stage.stageWidth;
			_tf.height = stage.stageHeight;
			_tf.embedFonts = true;
			UITextUtils.setFont(_tf, FontReg.BRUSHFONT.fName);
			UITextUtils.autoCenterFillTextField(_tf);
			_tf.selectable = false;
			this.addChild(_tf);
			
		
			
			
		}
		
		private function onBitmapLoaded(inBM:BitmapData):void
		{
			//_filter.init(inBM); //<<This one will use an output buffer the SAME SIZE as the input image.
			
			var myBuf:BitmapData = new BitmapData(640, 480, true, 0xFF000000);
			_filter.init(inBM, myBuf);
			
			
			_bmButton.x = inBM.width;
			_bmButton.y = inBM.height;
			_disp.bitmapData = _filter.getOutputBuffer();
			
			_filter.update();
		}
		
		private function onButtonPress():void
		{
			_bmOpener.openUsingDialogEZ(onBitmapLoaded, "onBitmapLoaded");
		}
		
	}//class
}//package