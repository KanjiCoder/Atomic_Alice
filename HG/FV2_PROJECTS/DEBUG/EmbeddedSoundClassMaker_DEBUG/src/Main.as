package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	
	import JM_EXT.org.as3commons.embedd.embeddedSoundClassMaker.EmbeddedSoundClassMaker
	//import JM_EXT.org.as3commons.embedd.embeddedSoundClassMaker.EmbeddedSoundClassMaker;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		//Sound FX assets:
		//[Embed(source = 'ClassicExp.mp3')]      public static var EXPLOSION_SFX       :Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var doMain:String = this.stage.loaderInfo.url;
				
			var doMainArray:Array = doMain.split("/");
			
			if (doMainArray[0] == "file:") 
			{
				trace("Local debug mode.");
			}
			else
			{
				trace("Web host mode");
			}
			
			trace("lets seee here");

		
			var ebcm:EmbeddedSoundClassMaker = new EmbeddedSoundClassMaker();
			ebcm.makeClass("SOUNDY_SOUND", "../src/ClassicExp.mp3");
		
			
			trace("made right?");
		}
		
	}//class
}//package