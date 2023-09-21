package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.preLoaders.atomicAlice.AAPL_Loading;
	import JM_LIB.preLoaders.atomicAlice.AtomicAlicePreLoader;
	
	
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		public var loader:AtomicAlicePreLoader;
		
		//public var debug:AAPL_Loading;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			loader = new AtomicAlicePreLoader(640, 480);
			loader.demoModeON();
			
			this.addChild(loader);
			
			//debug = new AAPL_Loading();
			//this.addChild(debug);
			
		}
		
	}//class
}//package