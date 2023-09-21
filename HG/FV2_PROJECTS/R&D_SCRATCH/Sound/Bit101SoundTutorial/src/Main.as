package 
{
	import flash.media.Sound;
	import flash.events.SampleDataEvent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		public var position:int = 0;
		public var n:Number = 0;
		public var sound:Sound = new Sound();
		public var timer:Timer = new Timer(500);
		
 
		public function onSampleData(event:SampleDataEvent):void
		{
			for(var i:int = 0; i < 2048; i++)
			{
				var phase:Number = position / 44100 * Math.PI * 2;
				position ++;
				var sample:Number = Math.sin(phase * 440 * Math.pow(2, n / 12));
				event.data.writeFloat(sample); // left
				event.data.writeFloat(sample); // right
			}
		}
		 
		
		public function onTimer(event:TimerEvent):void
		{
			n++;
		}
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			sound.play();
			
		}
		
	}
	
}