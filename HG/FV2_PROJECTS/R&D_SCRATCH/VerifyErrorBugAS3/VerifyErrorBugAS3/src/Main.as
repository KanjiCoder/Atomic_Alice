package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import JM_LIB.graphics.bitmapParser.regionRecExtractor.BitmapParser_RegRec;
	
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		//var _parser:BitmapParser_RegRec = new BitmapParser_RegRec();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//handleStringGOOD(1, "DATADATA", 4);
			//handleStringCRASH(1, "DATADATA", 4);
			//handleStringCRASHEDIT01(1, "DATADATA", 4);
			
			//handleStringCRASHEDIT02(1, "DATADATA", 4);
			//stackDump();
			//stackDumpFIXED();
			//stackDumpFIXED02();
			stackDumpFIXED03();
			//BitmapParser_RegRec.stackDumpTest();
		}
		
		
		private static function stackDumpFIXED03():void
		{	
			//obj can be an object, dictionary, vector, array.
			//probably anything that can be accessed using bracket notation.
			var obj:Array = [1, 2];
			var dex:int = 0;
			var tf:Boolean;

		
			while (true)
			{
				if (dex > 10) { break; }
				
				LOOP_TARGET:if (true)
				{
					obj[dex++] = 0;
					tf = (dex & 1) == 0 ? true : false;
					if (tf) { break LOOP_TARGET; }; //<<HACK: use break as a continue statement by putting all of your logic into an if(true) block.
					trace("dex ==" + dex);
				}
				
				
			}
		}
		
		
		private static function stackDumpFIXED02():void
		{	
			//obj can be an object, dictionary, vector, array.
			//probably anything that can be accessed using bracket notation.
			var obj:Array = [1, 2];
			var dex:int = 0;

			//if you access an object,vector,array,or dictionary using a nested incrimentor operator
			//followed by a continue statement, you will get a stack dump.
			//The loop can be a for, while, or do loop.
			while (false)
			{
				LOOP_TARGET:if (true)
				{
					obj[dex++] = 0;
					break LOOP_TARGET; //<<HACK: use break as a continue statement by putting all of your logic into an if(true) block.
				}
				
			}
		}
		
		
		private static function stackDumpFIXED():void
		{	
			//obj can be an object, dictionary, vector, array.
			//probably anything that can be accessed using bracket notation.
			var obj:Array = [1, 2];
			var dex:int = 0;

			//if you access an object,vector,array,or dictionary using a nested incrimentor operator
			//followed by a continue statement, you will get a stack dump.
			//The loop can be a for, while, or do loop.
			while (false)
			{
				dex++;
				obj[dex] = 0;
				continue;
			}
		}
		
		//[Fault] exception, information=VerifyError: Error #1068: int and * cannot be reconciled.
		private static function stackDump():void
		{
				
			//obj can be an object, dictionary, vector, array.
			//probably anything that can be accessed using bracket notation.
			var obj:Array = [1, 2];
			var dex:int = 0;
		
			//if you access an object,vector,array,or dictionary using a nested incrimentor operator
			//followed by a continue statement, you will get a stack dump.
			//The loop can be a for, while, or do loop.
			while (false)
			{
				obj[dex++] = 0;
				continue;
			}

		}//end stackDump
		
	
		private static function handleStringCRASHEDIT01(i:int, data:String, e:int):String 
		{
			
				var rtn:Array = new Array(e - i - 1);
				var inx:int = 0;
				var iN:Boolean = false;
				var c:int = 0;
				var end:int = data.charCodeAt(i);
				
				
				while (true) {
					if (true) //<<Must be TRUE, or a conditional.
					{
						//These two statements are vital to causing crash:
						//rtn[inx++];
						//continue;
						
						
						//rtn[inx++] = c;
						//inx++; rtn[inx] = c; //<<replacing rtn[inx++] with this will stop crash.
						
						rtn[inx++];
						continue;
					}
			
					break;
				}
				//return inx?String.fromCharCode.apply(String, rtn):"";
				
				return null;
		}//handle string
		
		
	
		//http://www.kongregate.com/forums/4-programming/topics/96607-as3-warning-stack-dump-verifyerror-error-1068-int-and-cannot-be-reconciled
		/** This one will throw error. **/
		private static function handleStringCRASH(i:int, data:String, e:int):String 
		{
				var rtn:Array = new Array(e - i - 1);
				var inx:int = 0;
				var iN:Boolean = false;
				var c:int = 0;
				var end:int = data.charCodeAt(i);
				
				while (i != e) {
					c = data.charCodeAt(++i);
					if (iN) {
						rtn[inx++] = c;
						iN = false;
						continue;
					}
					if (c == 0x5c) {
						iN = true;
						continue;
					}
					if (c == end) {
						break;
					}
					rtn[inx++] = c;
				}
				return inx?String.fromCharCode.apply(String, rtn):"";
		}//handle string
		
		private static function handleStringGOOD(i:int, data:String, e:int):String {
				var rtn:Array = new Array(e - i - 1);
				var inx:int = 0;
				var iN:Boolean = false;
				var c:int = 0;
				var end:int = data.charCodeAt(i);
				
				while (i != e) {
					c = data.charCodeAt(++i);
					if (iN) {
						//rtn[inx++] = c; //was commented out.
						iN = false;
					} else if (c == 0x5c) {
						iN = true;
						continue;
					} else if (c == end) {
						break;
					}
					rtn[inx++] = c;
				}
				return inx?String.fromCharCode.apply(String, rtn):"";
		}//handle string b.
	
	}//class
}//package


