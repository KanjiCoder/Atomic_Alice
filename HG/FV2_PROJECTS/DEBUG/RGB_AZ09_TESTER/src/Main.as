package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.abstract.RGB_AZ09;
	
	/**
	 * ...
	 * @author JMim
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
			
			var color:uint = RGB_AZ09.word4_to_bits32("0002");
			trace(color.toString(16));
			
		}
		
	}
	
}

//Name Chart:
//"KEYS" == ff8b3aac
//"NAME" == ffb757f3
//"TOPP" == ffbb4aeb
//"ACTS" == ffd67bac  //For "ACTIONS"
//"MOVE" == ff7f4773  //For "MOVEMENT"
//"BOTT" == ff834bae
//"ONLY" == ffd2d96a
//"MIDD" == ff7f1c30  //as in.. MIDDLE of screen.

//"0000" == ff ff ff ff
//"0001" == ff ff ff fe
//"0002" == ff ff ff fd
