package 
{
	
	//This probject is to test our cling ball that will give better collision physics to our platformer.
	//The reason this code is in the games folder is that it requires a lot of architecture to get it up
	//and running. It could potentially become a game because of this.
	
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author JMIM
	 */
	[Frame(factoryClass="Preloader")]
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
		}

	}//class
}//package