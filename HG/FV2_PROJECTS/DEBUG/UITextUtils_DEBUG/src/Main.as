package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import JM_LIB.UI.components.sprite.SetSizeSprite;
	import JM_LIB.UI.textUtils.UITextUtils;
	
	/**
	 * ...
	 * @author JMIM
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
			
			
			var tf:TextField = new TextField();
			tf.text = "Kryptonium101";
			tf.width = 600;
			tf.height = 30;
			
			var sp:SetSizeSprite = new SetSizeSprite();
			sp.setSize(600, 30);
			sp.graphics.beginFill(0x00FFFF, 0.3);
			sp.graphics.drawRect(0, 0, sp.width, sp.height);
			sp.graphics.endFill();
			this.addChild(sp);
			
			//UITextUtils.setFontSize(tf, 16);
			UITextUtils.autoCenterFillTextField(tf);
			
			this.addChild(tf);
		}
		
	}
	
}