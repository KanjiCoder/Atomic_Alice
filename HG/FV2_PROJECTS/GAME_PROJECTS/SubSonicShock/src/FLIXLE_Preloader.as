package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.flixel.system.*;
	//import org.flixel.system.FlxPreloader;
	import GameSpecificRegistries.Bomber01.FontReg;

	public class Preloader extends FlxPreloader
	{
		
		/** A bitmap buffer used to render onto. **/
		private var _bmBuffer:BitmapData;
		
		/** Visible object used to display _bmBuffer **/
		private var _vsBuffer:Bitmap;
		
		public function Preloader()
		{
			className = "Main";
			super();
		}
		
		
		
		override protected function create():void 
		{
			
			
			_buffer = new Sprite();
			addChild(_buffer);
			//Add stuff to the buffer...
			
			_bmBuffer = new BitmapData(this.stage.stageWidth, this.stage.stageHeight);
			_vsBuffer = new Bitmap( _bmBuffer );
			_buffer.addChild( _vsBuffer );
			
			/*
			//Put the text object on the very top. Above the buffer... Try that.
			_text = new TextField();
			_text.selectable = false;
			_text.embedFonts = true;
			var tform:TextFormat = _text.defaultTextFormat;
			tform.font = FontReg.DIRTYSTENCIL.fName;
			tform.size = 32;
			_text.defaultTextFormat = tform;
			_buffer.addChild(_text);
			*/
		}
		
		override protected function update(Percent:Number):void 
		{
			//Update the graphics...
			var rad:Number = (this.stage.stageHeight*0.5) * Percent;
			var xp:Number = this.stage.stageWidth / 2;
			var yp:Number = this.stage.stageHeight / 2;
			//_text.text = Percent.toString();
			
			/*
			_buffer.graphics.beginFill(0x00FFFF, 0.02);
			_buffer.graphics.drawCircle(xp, yp, rad);
			_buffer.graphics.endFill();
			*/
			_bmBuffer.fillRect(_bmBuffer.rect, 0xFF0000 * Percent);
			
			
		}
		
		
		
	}//class
}//package
