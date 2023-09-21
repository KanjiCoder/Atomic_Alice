package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.encoding.StringToSeedUtil;
	
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
			
			doStuff();
		}
		
		private function doStuff():void
		{
			/*
			StringToSeedUtil.convertStringToSeedUsingBitLimit("AAA", 3, false);
			StringToSeedUtil.convertStringToSeedUsingBitLimit("ABCDEFG", 12, false);
			StringToSeedUtil.convertStringToSeedUsingBitLimit("ABCDEFG", 14, false);
			StringToSeedUtil.convertStringToSeedUsingBitLimit("AABBCCD", 4 , false);
			StringToSeedUtil.convertStringToSeedUsingBitLimit("AABBCC" , 3 , false);
			*/
			
			var value:uint;
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("JOSHICUS", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("AMANDA", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("JOHN MARK", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("TYLER WOODS", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("MATTY G", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("AB", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("BA", 0x7FFFFFFE, false);
			checkInclusiveRange(value, 1, 0x7FFFFFFE);
			
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("CD", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("DC", 0x7FFFFFFE, false);
			checkInclusiveRange(value, 1, 0x7FFFFFFE);
			
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("EF", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("FG", 0x7FFFFFFE, false);
			checkInclusiveRange(value, 1, 0x7FFFFFFE);
			
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("ALUCARD", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("DRACULA", 0x7FFFFFFE, false);
			checkInclusiveRange(value, 1, 0x7FFFFFFE);
			
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("APPLE", 0x7FFFFFFE, false);
			checkInclusiveRange(value,1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("APPLES", 0x7FFFFFFE, false);
			checkInclusiveRange(value, 1, 0x7FFFFFFE);
			value = StringToSeedUtil.convertStringToSeedUsingBitBlockRange("APPLEN", 0x7FFFFFFE, false);
			checkInclusiveRange(value, 1, 0x7FFFFFFE);
			
			
			
			
			trace("success?");

		}
		
		private function checkInclusiveRange(inValue:uint, inMIN:uint, inMAX:uint):void
		{
			if (inValue < inMIN || inValue > inMAX)
			{
				var inValueAsBin:String = inValue.toString(2);
				var minBits:String = inMIN.toString(2);
				var maxBits:String = inMAX.toString(2);
				throw new Error("!!!ARG");
			}
		}
		
	}//class
}//package