package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.hires.debug.Stats;
	import flash.system.System;
	import JM_LIB.MEM;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source = "IMG_01.png")]public static var IMG_01:Class;
		[Embed(source = "IMG_02.png")]public static var IMG_02:Class;
		[Embed(source = "IMG_03.png")]public static var IMG_03:Class;
		[Embed(source = "IMG_04.png")]public static var IMG_04:Class;
		[Embed(source = "IMG_05.png")]public static var IMG_05:Class;
		[Embed(source = "IMG_06.png")]public static var IMG_06:Class;
		[Embed(source = "IMG_07.png")]public static var IMG_07:Class;
		[Embed(source = "IMG_08.png")]public static var IMG_08:Class;
		[Embed(source = "IMG_09.png")]public static var IMG_09:Class;
		[Embed(source = "IMG_10.png")]public static var IMG_10:Class;
		
		
		private var _stats:Stats = new Stats();
		private var _bmVec:Vector.<BitmapData> = new Vector.<BitmapData>(0);
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			this.addChild(_stats);
			
			MEM.doMemoryTrace();
			
			_bmVec.push( new IMG_01().bitmapData );
			_bmVec.push( new IMG_02().bitmapData );
			_bmVec.push( new IMG_03().bitmapData );
			_bmVec.push( new IMG_04().bitmapData );
			_bmVec.push( new IMG_05().bitmapData );
			_bmVec.push( new IMG_06().bitmapData );
			_bmVec.push( new IMG_07().bitmapData );
			_bmVec.push( new IMG_08().bitmapData );
			_bmVec.push( new IMG_09().bitmapData );
			_bmVec.push( new IMG_10().bitmapData );
			
			MEM.doMemoryTrace();
			
		}
		
	}//class
}//package