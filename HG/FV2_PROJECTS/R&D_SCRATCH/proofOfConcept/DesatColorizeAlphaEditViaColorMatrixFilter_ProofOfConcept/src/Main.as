package 
{
	import JM_LIB.graphics.color.ARGBpod;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import JM_LIB.graphics.color.UintRGBandBackConverter;
	import JM_LIB.graphics.filters.compound.tooExpensiveToDoEachFrame.GradientRampWithTransparencyFilter;
	
	import flash.filters.ColorMatrixFilter;
	
	import JM_EXT.com.adobe.utils.BitmapSaverUtil;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		 [Embed (source = "Kitties.jpg")] private static var PNG:Class;
		 [Embed (source = "AutoTiled05.PNG")] private static var AUTO:Class;
		
		private var _saver:BitmapSaverUtil;
		private var zz:Point = new Point(0, 0);
		private var _bm:BitmapData;
		private var _bmVis:Bitmap;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//doIt();
			doItWithClass();
		}
		
		private function doItWithClass():void
		{
			_saver = new BitmapSaverUtil();
			_saver.useWatermark = false;
			
			var f:GradientRampWithTransparencyFilter = new GradientRampWithTransparencyFilter();
			f.setAlpha0255(128);
			f.setDarkRGB(0, 172, 111);
			f.setLightRGB(32, 236, 175);
			f.setDrawDarkBelowLight(false);
			
			var tmpBM:BitmapData = new AUTO().bitmapData;
			_bm = new BitmapData(tmpBM.width, tmpBM.height, true, 0x00);
			_bm.copyPixels(tmpBM, tmpBM.rect, zz, null, null, false);
			
			var fBM:BitmapData;
			fBM = f.makeAlteredBitmapCopy(_bm);
			_saver.openDialogForBitmapSave( fBM );
			
		}
		
		private function doIt():void
		{
			_saver = new BitmapSaverUtil();
			_saver.useWatermark = false;
			
			var tmpBM:BitmapData = new PNG().bitmapData;
			_bm = new BitmapData(tmpBM.width, tmpBM.height, true, 0x00);
			_bm.copyPixels(tmpBM, tmpBM.rect, zz, null, null, false);
			
			_bmVis = new Bitmap(_bm);
			this.addChild(_bmVis);
			
			var matrix:Array = new Array();
           // matrix=matrix.concat([0.5,0.5,0.5,0,0]);// red
           // matrix=matrix.concat([0.5,0.5,0.5,0,0]);// green
           // matrix=matrix.concat([0.5,0.5,0.5,0,0]);// blue
           // matrix = matrix.concat([0, 0, 0, 1, 0]);// alpha
			
		   //Paste a DARK color behind this to get the DARK color of your gradient map:
		   var darkM:Array = new Array();
			darkM=darkM.concat([0.5,0.5,0.5,0,0]);// red
            darkM=darkM.concat([0.5,0.5,0.5,0,0]);// green
            darkM=darkM.concat([0.5,0.5,0.5,0,0]);// blue
            darkM = darkM.concat([0.5, 0.5, 0.5, 0, 0]);// alpha
		   var blackIsTransparent:ColorMatrixFilter = new ColorMatrixFilter(darkM);
		
			
			//Paste a LIGHT color behind this to get the LIGHT color of your gradient map:
			var lghtM:Array = new Array();
			lghtM=lghtM.concat([0.5,0.5,0.5,0,0]);// red
            lghtM=lghtM.concat([0.5,0.5,0.5,0,0]);// green
            lghtM=lghtM.concat([0.5,0.5,0.5,0,0]);// blue
            lghtM = lghtM.concat([ -0.5, -0.5, -0.5, 0, 255]);// alpha
			var whiteIsTransparent:ColorMatrixFilter = new ColorMatrixFilter(lghtM);
			
			//How do you do the above filters, but instead of converted to greyscale, they are converted to mono-chromatic?
			//Well, if the RGB is FLAT color... And the alpha is used to control lightness... We can just put all RGB values to
			//ZERO and then apply the correct offset value to get the RGB we want... Sounds good. Lets try.
			/** Light color used in our gradient map. **/
		    var lc:ARGBpod = new ARGBpod();
			lc.a = 255;
			lc.r = 255;
			lc.g = 255;
			lc.b = 0;
			
			/** Dark color used in our gradient map. **/
			var dc:ARGBpod = new ARGBpod();
			dc.a = 255;
			dc.r = 0;
			dc.g = 50;
			dc.b = 100;
			
			//Makes the white pixels OPAQUE and colorized:
			var darkFC:Array = new Array();
			darkFC=darkFC.concat([0,0,0,0,lc.r]);// red
            darkFC=darkFC.concat([0,0,0,0,lc.g]);// green
            darkFC=darkFC.concat([0,0,0,0,lc.b]);// blue
            darkFC=darkFC.concat([0.5, 0.5, 0.5, 0, 0]);// alpha
		   var whiteIsOpaqueAndColorized:ColorMatrixFilter = new ColorMatrixFilter(darkFC);
		   
		   //Makes the black pixels OPAQUE and colorized.
		   var lightFC:Array = new Array();
			lightFC=lightFC.concat([0,0,0,0,dc.r]);// red
            lightFC=lightFC.concat([0,0,0,0,dc.g]);// green
            lightFC=lightFC.concat([0,0,0,0,dc.b]);// blue
            lightFC=lightFC.concat([ -0.5, -0.5, -0.5, 0, 255]);// alpha
			var blackIsOpaqueAndColorized:ColorMatrixFilter = new ColorMatrixFilter(lightFC);
			
			//make the colorized image:
			var baseColor:uint = 0xFF000000;
			
			/** The base bitmap is the bitmap at the bottom. The math for my gradient map isn't perfect.
			 *  So there is a little bit of transparency leftoever after adding layer_FF and layer_00 together.
			 *  This opaque layer is put under these 2 layers so that we have a completely opaque gradient ramp colorized image when
			 *  we are done. **/
			var base:BitmapData = new BitmapData(tmpBM.width, tmpBM.height, true, baseColor);
			
			/** layer of BRIGHT hues in our gradient mask. **/
			var layer_FF:BitmapData = new BitmapData(tmpBM.width, tmpBM.height, true, 0x00);
			/** layer of DARK hues in our gradient mask. **/
			var layer_00:BitmapData = new BitmapData(tmpBM.width, tmpBM.height, true, 0x00);
			
			//Make the two colorized versions of the original bitmap.
			layer_FF.applyFilter(_bm, base.rect, zz, whiteIsOpaqueAndColorized);
			layer_00.applyFilter(_bm, base.rect, zz, blackIsOpaqueAndColorized);
			
			// past the two layers on top of the base bitmap to create the finalized gradient ramped image.
			base.copyPixels(layer_FF, tmpBM.rect, zz, null, null, true);
			base.copyPixels(layer_00, tmpBM.rect, zz, null, null, true);
			
			// Create the final transparency by merging the alpha of this bitmap with a transparent bitmap:
			var transBase:BitmapData = new BitmapData(tmpBM.width, tmpBM.height, true, 0x88000000);
			transBase.copyPixels(base, tmpBM.rect, zz, transBase, zz, false);
			
			_saver.openDialogForBitmapSave( transBase);
			
			//_bm.applyFilter(_bm, _bm.rect, zz, blackIsOpaqueAndColorized);
			//_saver.openDialogForBitmapSave(_bm);
		}
	}
}