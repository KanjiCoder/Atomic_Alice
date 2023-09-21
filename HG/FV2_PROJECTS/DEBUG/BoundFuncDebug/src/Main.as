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
			
			//Test scenario: 
			//STEPS:
			//1: If we BIND classWithFunction.doStuffUsing_objectReference to variable BEFORE _objectReference is NON-NULL,
			//2: We set classWithFunction.doStuffUsing_objectReference to NON-NULL within the class.
			//3: We call the doStuffUsing_objectReference
			//4: We see if doStuffUsingObjectReference sees _objectReference as null or not.
			var instClassWithFunction:ClassWithFunction = new ClassWithFunction();
			var instBinderClass      :BinderClass       = new BinderClass(instClassWithFunction);
			
			instClassWithFunction.callThis();
			instClassWithFunction.callThis();
			instBinderClass.callBoundFunction();
			
		}
		
	}
	
}




