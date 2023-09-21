package 
{
	
	//Conclusion:
	//Fill rect does NOT blend alphas.
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.onTheWings.utils.KeyCodeUtil;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		public var bmDat:BitmapData = new BitmapData(200,200, true, 0xFFFF0000);
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			var bmVis:Bitmap     = new Bitmap(bmDat);
			this.addChild(bmVis);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			this.stage.addEventListener(MouseEvent.CLICK, onClickHandler);
			//this.stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(e:Event):void
		{
			trace("enter frame");
		}
		
		private function onClickHandler(mev:MouseEvent):void
		{
			trace("click");
		}
		
		private function onKeyDownHandler(ke:KeyboardEvent):void
		{
			trace("KEYDOWN");
			if (ke.keyCode == KeyCodeUtil.keyCodeOf("R"))
			{
				trace("fill RED");
				bmDat.fillRect(bmDat.rect, 0x88FF0000);
			}
			
			if (ke.keyCode == KeyCodeUtil.keyCodeOf("B"))
			{
				trace("fill BLUE");
				bmDat.fillRect(bmDat.rect, 0x880000FF);
			}
		}
		
	}
	
}