package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author 
	 */
	public class Preloader_old extends MovieClip 
	{
		private var _perTF:TextField;
		private var _perTF_Format:TextFormat;
		
		public function Preloader_old() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO show loader
			createAndShowLoaderStuff();
		}
		
		private function createAndShowLoaderStuff():void
		{
			stage.addChild(this);
			
			_perTF = new TextField();
			_perTF.width = 640;
			this.addChild(_perTF);
			
			//GET REFERENCE:
			_perTF_Format = _perTF.defaultTextFormat;
			
			//CONFIGURE REFERENCE:
			_perTF_Format.size = 30;
			_perTF_Format.color = 0x00FFFF;
			
			//SET REFERENCE FOR REFRESH:
			_perTF.defaultTextFormat = _perTF_Format;
		}//createLoaderStuff
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			var finalPercentageText:String;
			
			var perNum:Number = (e.bytesLoaded / e.bytesTotal) * 100;
			var preText:String = perNum.toString();
			var splits:Array = preText.split(".");
			
			if (splits.length == 2)
			{
				var pointsomethings:String = splits[1];
				var afterDecimal:String = pointsomethings.charAt(0) +
										  pointsomethings.charAt(1) +
										  pointsomethings.charAt(2) +
										  pointsomethings.charAt(3) ;
				
				finalPercentageText = splits[0] + "." + afterDecimal;
			}
			else
			{
				finalPercentageText = perNum.toString() + ".0000";
			}
			
			_perTF.text = finalPercentageText + "% loaded of MakeChoice Beta";
		}//progress
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			//return; //DEBUG To see last frame of pre-loader.
			trace("Preloader_old finished!");
			
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			destroyLoaderStuff();
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
		private function destroyLoaderStuff():void
		{
			_perTF.parent.removeChild( _perTF );
			
			//maybe remove this class/object itself as well?
		}
			
		
	}//class
}//package