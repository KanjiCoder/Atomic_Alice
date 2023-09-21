package 
{
	import com.dasflash.soundcloud.as3api.demos.SoundCloudAPITest_Fla;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		private var _test:SoundCloudAPITest_Fla;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_test = new SoundCloudAPITest_Fla();
			this.addChild(_test);
		}
		
	}
	
}