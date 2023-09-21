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
			
			var baseSpeed:Number = 20;
			for (var i:int = 999000; i < 999500; i++)
			{
				var speed2:Number = baseSpeed + i;
				var avg:Number;
				avg = getAverageSpeed(baseSpeed, speed2);
				trace("[" + baseSpeed.toString() 
				+ "]MPH" + "&" + "[" + speed2.toString() + "]==" + avg.toString() );
			}
		}
		
private function doStuff():void
{
	var baseSpeed:Number = 20;
	for (var i:int = 999000; i < 999500; i++)
	{
		var speed2:Number = baseSpeed + i;
		var avg:Number;
		avg = getAverageSpeed(baseSpeed, speed2);
		var b:String = baseSpeed.toString();
		var s:String = speed2.toString();
		var a:String = avg.toString();
		trace("[" + b + "]MPH" + "&" + "[" + s + "]==" + a );
	}
}


private function getAverageSpeed(speed1:Number, speed2:Number):Number
{
	//in previous formula, we proved that the distance there and back scaled proportionately.
	//So I am going to use a distance of 100 for the average speed calculation.
	var dist:Number = 100; 
	
	var time1:Number = dist / speed1;
	var time2:Number = dist / speed2;
	
	var total:Number = time1 + time2;
	var per1:Number = time1 / total;
	var per2:Number = time2 / total;
	
	var part1:Number = per1 * speed1;
	var part2:Number = per2 * speed2;
	
	var avg:Number = part1 + part2;
	return avg;
}
		
	}
}