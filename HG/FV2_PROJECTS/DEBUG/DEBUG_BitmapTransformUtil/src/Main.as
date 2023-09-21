package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import JM_LIB.graphics.utils.BitmapTransformUtil;
	import JM_LIB.constants.TransFiveConstants;
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends Sprite 
	{
		
		private var _frameCounter:int = 0;
		private var _currentBitmapSet:Vector.<BitmapData>;
		private var _curBMIndex:int = 0;
		
		[Embed(source = 'SS00.png')]private static var SS00 :Class; // sprite sheet test.
		//[Embed(source = 'CD00.png')]private static var CD00 :Class; // collsion data test.
		[Embed(source = 'COLLISION.png')]private static var CD00 :Class; // collsion data test. #(2)
		
		public var bmVis:Bitmap;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
		
			//collisionSheetTest();
			//_currentBitmapSet = spriteSheetTest();
			_currentBitmapSet = collisionSheetTest();
			
			bmVis = new Bitmap(_currentBitmapSet[0]);
			bmVis.scaleX = 8;
			bmVis.scaleY = 8;
			this.addChild(bmVis);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			
		}//init
		
		private function onEnterFrame(evt:Event):void
		{
			_frameCounter++;
			
			if (_frameCounter > 30)
			{
				_frameCounter = 0;
				_curBMIndex++;
				if (_curBMIndex >= _currentBitmapSet.length) { _curBMIndex = 0;}
				bmVis.bitmapData = _currentBitmapSet[ _curBMIndex ];
			}
		}
		
		private function collisionSheetTest():Vector.<BitmapData>
		{
			var bmDat:BitmapData = (new CD00).bitmapData;
			//Test all transforms:
			//All transforms of ENTIRE BITMAP are working.
			var outBMVec:Vector.<BitmapData> = new Vector.<BitmapData>(0);
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfCollisionDataBitmap(bmDat, TransFiveConstants.NO_TRANSFORM) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfCollisionDataBitmap(bmDat, TransFiveConstants.ROTATE_NEG_90) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfCollisionDataBitmap(bmDat,TransFiveConstants.ROTATE_POS_90) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfCollisionDataBitmap(bmDat,TransFiveConstants.VERTICAL_FLIP) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfCollisionDataBitmap(bmDat,TransFiveConstants.HORIZONTAL_FLIP) );
			
			return outBMVec;
		}
		
		private function spriteSheetTest():Vector.<BitmapData>
		{
			var bmDat:BitmapData = (new SS00).bitmapData;
			
			//All transforms of ENTIRE BITMAP are working.
			var outBMVec:Vector.<BitmapData> = new Vector.<BitmapData>(0);
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfSpriteSheet(bmDat,2,3, TransFiveConstants.NO_TRANSFORM) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfSpriteSheet(bmDat,2,3, TransFiveConstants.ROTATE_NEG_90) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfSpriteSheet(bmDat,2,3, TransFiveConstants.ROTATE_POS_90) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfSpriteSheet(bmDat,2,3, TransFiveConstants.VERTICAL_FLIP) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopyOfSpriteSheet(bmDat,2,3, TransFiveConstants.HORIZONTAL_FLIP) );
			
			return outBMVec;
		}//spriteSheetTest
		
		
		private function bitmapTransformTest():Vector.<BitmapData>
		{
			var bmDat:BitmapData = (new SS00).bitmapData;
			
			//All transforms of ENTIRE BITMAP are working.
			var outBMVec:Vector.<BitmapData> = new Vector.<BitmapData>(0);
			outBMVec.push( BitmapTransformUtil.makeTransformedCopy(bmDat, TransFiveConstants.NO_TRANSFORM) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopy(bmDat, TransFiveConstants.ROTATE_NEG_90) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopy(bmDat, TransFiveConstants.ROTATE_POS_90) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopy(bmDat, TransFiveConstants.VERTICAL_FLIP) );
			outBMVec.push( BitmapTransformUtil.makeTransformedCopy(bmDat, TransFiveConstants.HORIZONTAL_FLIP) );
			
			return outBMVec;
		}//spriteSheetTest
		
	}//class
}//package