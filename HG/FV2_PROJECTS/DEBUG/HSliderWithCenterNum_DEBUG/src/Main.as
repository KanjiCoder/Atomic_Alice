package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.UI.components.sliders.SliderWithCenterNum;
	import com.bit101.components.PushButton;
	import com.bit101.components.NumericStepper;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		private var _slider:SliderWithCenterNum;
		
		private var _step:NumericStepper;
		private var _push:PushButton;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var valMIN:Number = 0;
			var valMAX:Number = 100;
			
			_slider = new SliderWithCenterNum();
			_slider.setRange(valMIN, valMAX, 0, true);
			_slider.setSize(100, 30);
			
			
			this.addChild(_slider);
			
			
			_push = new PushButton(this, 0, 0, "PUSH", onPush);
			_step = new NumericStepper(this, 0, 0, onStep);
			
			_push.y = _slider.y + _slider.height;
			_step.y = _push.y + _push.height;
			
			_step.minimum = valMIN;
			_step.maximum = valMAX;
			
			
		}
		
		private function onPush(evt:Event):void
		{
			_slider.setValue( _step.value );
		}
		
		private function onStep(evt:Event):void
		{
			
		}
		
		
	}//class
}//package