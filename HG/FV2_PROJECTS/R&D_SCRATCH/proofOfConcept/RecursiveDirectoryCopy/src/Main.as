package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	 
	
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
		}
		
		private function copyInto(directoryToCopy:File, locationCopyingTo:File):void
		{
		  var directory:Array = directoryToCopy.getDirectoryListing();

		  for each (var f:File in directory)
		  {
			if (f.isDirectory)
			  copyInto(f, locationCopyingTo.resolvePath(f.name));
			else
			  f.copyTo(locationCopyingTo.resolvePath(f.name), true);
		  }
		  
		  //How do I impliment a site lock using:
		  //1: URL TO LOCK TO:
		  //2: Date range to lock to?

		}//directory copy.
		
		
	}
	
}