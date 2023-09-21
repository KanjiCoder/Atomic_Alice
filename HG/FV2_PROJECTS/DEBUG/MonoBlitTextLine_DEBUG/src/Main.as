package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.UI.components.monoBlitterTextLine.MonoBlitterTextLine;
	import GameSpecificRegistries.Bomber01.FontReg;
	import JM_LIB.plainOldData.EmbeddedFontData;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		public var mb:MonoBlitterTextLine = new MonoBlitterTextLine();
		public var bufferDisp:Bitmap = new Bitmap();
		public var num:int = 0;
		public var numSTR:String;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var efd:EmbeddedFontData = FontReg.DIRTYSTENCIL;
			mb.init(160, 30, efd, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":"], 12);
			//mb.renderTextLine("123456789012");
			//mb.renderTextLine("12:34:56:78");
			mb.renderTextLine("1234");
			
			this.addChild(bufferDisp);
			bufferDisp.bitmapData = mb.getBuffer();
			
			this.addEventListener(Event.ENTER_FRAME, doUpdate);
		}
		
		private function doUpdate(evt:Event):void
		{
			num++;
			numSTR = num.toString();
			mb.renderTextLine(numSTR);
			
		}
	}
	
}