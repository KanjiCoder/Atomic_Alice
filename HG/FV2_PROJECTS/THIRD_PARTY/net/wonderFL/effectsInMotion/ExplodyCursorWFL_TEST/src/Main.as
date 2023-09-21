package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.wonderFL.effects.effectsInMotion.explodyCursor.ExplodyCursorWFL;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		private var _vis:Bitmap;
		private var wonder:ExplodyCursorWFL;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			makeDebugSprite();
			
			wonder = new ExplodyCursorWFL();
			this.addChild(wonder);
			
			var w4:int = stage.stageWidth / 4;
			var h4:int = stage.stageHeight / 4;
			
			var r0:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			var r1:Rectangle = new Rectangle(0, 0, stage.stageWidth / 4, stage.stageWidth / 4);
			var r2:Rectangle = new Rectangle(w4*3, h4*3, w4, h4);
			var flowRecs:Vector.<Rectangle> = new Vector.<Rectangle>(0);
			flowRecs.push(r0);
			flowRecs.push(r1);
			flowRecs.push(r2);
			wonder.init(flowRecs, 200);
			
			
			//wonder.alpha = 0; //the .apha does NOT affect the opaque background!
			
			//wonder.setWidthAndHeight(300, 300);
			this.addEventListener(Event.ENTER_FRAME, wonder.updateUsingEvent);
			
		}
		
		private function makeDebugSprite():void
		{
			var bm:BitmapData = new BitmapData(200, 200, true, 0x880000FF);
			_vis = new Bitmap( bm );
			this.addChild( _vis );
		}
		
	}//class
}//package