package 
{
	
	//Benchmark tests to see if I should make an integer based particle system, or a number based one.
	
	//Results:
	//Speed looks about the same at close look.
	//Use a NUMBER based particle system for easier fine tuned calculations
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.utils.Timer;
    import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
	
		//POSITION:        
		public var pX:Number = 0.5; 
		public var pY:Number = 0.5; 
		          
		//VELOCITY:
		public var vX:Number = 0.5; 
		public var vY:Number = 0.5; 
		                   
		//ACCELERATION:
		public var aX:Number = 0.5; 
		public var aY:Number = 0.5; 
		
		
		
		//POSITION:        
		public var p1:int = 1; 
		public var p2:int = 1; 
		          
		//VELOCITY:
		public var v1:int = 1; 
		public var v2:int = 1; 
		                   
		//ACCELERATION:
		public var a1:int = 1; 
		public var a2:int = 1; 
		
		
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//doBenchmark();
			multiplyBenchmark();
		}
		
		
		public function multiplyBenchmark():void
		{
			var t1:Number;
            var t2:Number;
            var tt:Number;
            var counter:int;
            var counterMax:int = 98765;
			
			
			t1 = getTimer();
            counter = 0;
            do
            {
            counter++;
                if (counter > counterMax) { break;}
                
               	//Update Velocity:
				vX *= 0.5;
				vY *= 0.5;
				
				
                
            }while (true);
            t2 = getTimer();
            tt = t2 - t1;
            trace("MULTIPLY number particles:: tt==" + tt);
			
			
			t1 = getTimer();
            counter = 0;
            do
            {
            counter++;
                if (counter > counterMax) { break;}
                
               	//Update Velocity:
				v1 += 0.5;
				v2 += 0.5;
				
			
                
            }while (true);
            t2 = getTimer();
            tt = t2 - t1;
            trace("MULTIPLY integer particles:: tt==" + tt);
			
		}//do benchmark
		
		
		public function doBenchmark():void
		{
			var t1:Number;
            var t2:Number;
            var tt:Number;
            var counter:int;
            var counterMax:int = 98765;
			
			
			
			t1 = getTimer();
            counter = 0;
            do
            {
            counter++;
                if (counter > counterMax) { break;}
                
               	//Update Velocity:
				vX += aX;
				vY += aY;
				
				//Update Position:
				pX += vX;
				pY += vY;
				
				//Update Velocity:
				vX += aX;
				vY += aY;
				
				//Update Position:
				pX += vX;
				pY += vY;
				
				//Update Velocity:
				vX += aX;
				vY += aY;
				
				//Update Position:
				pX += vX;
				pY += vY;
                
            }while (true);
            t2 = getTimer();
            tt = t2 - t1;
            trace("number particles:: tt==" + tt);
			
			
			t1 = getTimer();
            counter = 0;
            do
            {
            counter++;
                if (counter > counterMax) { break;}
                
               	//Update Velocity:
				v1 += a1;
				v2 += a2;
				
				//Update Position:
				p1 += v1;
				p2 += v2;
				
				//Update Velocity:
				v1 += a1;
				v2 += a2;
				
				//Update Position:
				p1 += v1;
				p2 += v2;
				
				//Update Velocity:
				v1 += a1;
				v2 += a2;
				
				//Update Position:
				p1 += v1;
				p2 += v2;
                
            }while (true);
            t2 = getTimer();
            tt = t2 - t1;
            trace("integer particles:: tt==" + tt);
			
		}//do benchmark
		
		
		
	}
	
}