package 
{
	
	import com.snipplr.users.rivaledsouls.utils.color.RGB;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	import flash.events.*;
	import JM_GAME_LIBS.flixelBasedGames.subSonicShock.registries.LevelReg;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import JM_LIB.graphics.particles.RGBParticle;
	import JM_LIB.utils.strings.StringSaverUtil;
	import JM_LIB.utils.VectorUtil;
	
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
			var a:Vector.<String> = VectorUtil.arrayToStringVector(["A", "B", "C"]);
			trace("hhi");
		}

		

	}//class
}//package



