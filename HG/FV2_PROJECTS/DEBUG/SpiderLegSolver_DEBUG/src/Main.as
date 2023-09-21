package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.rigging.SpiderLegSolver;
	
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
			var sls:SpiderLegSolver = new SpiderLegSolver();
			
			//These ones do not throw error. Telling me that it probably has something to do with swapping side values somewhere.
			//sls.init(2, 10, 10);
			//sls.init(10, 2, 10);
			//sls.init(10, 10, 2);
			
			//This does not get an error EITHER. Beginning to think... Rounding errors?
			//sls.init(3, 4, 5); //using a right triangle as input.
			//sls.init(5, 4, 3);
			
			//Try 30 60 90 triangle. No errors with this.
			//sls.init(1, 2, Math.sqrt(3));
			
			sls.init(100, 80, 40); //multiplying all by 10 still gets error... Think it is more than just a rounding error.
			//sls.init(9, 8, 4); //init error on law of sine check.
			//sls.init(10, 8, 4); //init error on law of sine check.
			var dist:Number = sls.angleSlider(0);
			
			/*
			for (var i:int = 0; i <= 100; i++)
			{
				var per:Number = i / 100;
				dist = sls.angleSlider(per);
				trace("per==" + per + ".. dist == " + dist);
			}
			*/
			
		}
		
	}
	
}