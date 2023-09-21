package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.toolSystems.directoryPNGLoader.DirectoryPNGLoader;
	
	/**
	 * ...
	 * @author JMim
	 */
	public class Main extends Sprite 
	{
		public var _pngLoader:DirectoryPNGLoader;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_pngLoader = new DirectoryPNGLoader();
			_pngLoader.setBaseFolderName("devLevels");
			//_pngLoader.loadLocalPNGFiles(["level00", "DoesNotExistTest", "level01"], DirectoryPNGLoader.defaultNotify);
			
			//_pngLoader.loadLocalPNGFiles(["ThePNG", "DoesNotExistTest"], DirectoryPNGLoader.defaultNotify);
			
			_pngLoader.loadSequentialPNGFiles("level", 2, 1, DirectoryPNGLoader.defaultNotify);
			
		}
		
	}
	
}