package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.display.BlendMode;
	
	/**
	 * Notes from research:
		 * In order for your ligthing code to work here... You must have NO ALPHA in your lights.
		 * PLASMA: Addative. Has a background of BLACK.       (No change will happen with BLACK background)
		 * LIGHT : Multiplicative. Has a background of WHITE. (No change will happen with white background)
		 * 
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
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
		
		public function doTest():void
		{
			var baseBitmap:BitmapData = new BitmapData(10, 10, true, 0xFF008800);
			var bmVis:Bitmap = new Bitmap( baseBitmap );
			bmVis.scaleX = 10;
			bmVis.scaleY = 10;
			
			var c:ColorTransform = new ColorTransform();
			
			var l1:BitmapData = new BitmapData(10, 10, true, 0xFF008800);
			for (var i:int = 0; i < 1; i++)
			{
			baseBitmap.draw(l1, new Matrix(), null, BlendMode.ADD, null, false);
			baseBitmap.draw(l1, new Matrix(), null , BlendMode.SUBTRACT, null, false);
			}
			
			this.addChild( bmVis );
		}
		
	}
	
}