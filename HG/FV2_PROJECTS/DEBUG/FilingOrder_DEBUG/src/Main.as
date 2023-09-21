package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.math.chemistry.SubShellConfiguration;
	import JM_LIB.utils.math.chemistry.SubShellFillingData;
	import JM_LIB.utils.math.chemistry.ElectronFilingMathUtil;
	
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
			
			var results:Number;
			var resObj:SubShellFillingData;
			for (var i:int = 0; i <= 20; i++)
			{
				//results = energyIndexToThickFilingDiagonal(i);
				//results = thickFilingDiagonalToHighestEnergyIndex(i);
				//results = thickFilingIndexToMaxElectronCount(i);
				//trace("i==" + i + "--->" + results);
				
				resObj = ElectronFilingMathUtil.energyIndexToFilingData(i);
				
				trace("hi");
				
			}
			
		}
		
		
		
	}
	
}