package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	
	import flash.utils.describeType;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		//Sound FX assets:
		[Embed(source = 'ClassicExp.mp3')]      public static var EXPLOSION_SFX       :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var x:XML = describeType( EXPLOSION_SFX );
			
			var snd:Sound = new EXPLOSION_SFX();
			snd.play();
			trace("hello world");
		}
		
	}
	
}