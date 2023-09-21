package 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//Mime types:
	/*
    application/octet-stream
    application/x-font
    application/x-font-truetype
    application/x-shockwave-flash
    audio/mpeg
    image/gif
    image/jpeg
    image/png
    image/svg
    image/svg-xml
*/
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		[Embed(source='TwoLayers.svg', mimeType='image/svg')]
		protected const EmbeddedSVG:Class;
		
		[Embed(source='Grouping.svg', mimeType='image/svg')]
		protected const SVG2:Class;
		
		//[Embed(source='Grouping.emf', mimeType='image/emf')]
		//protected const SVG2:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var mySvg:DisplayObjectContainer = new SVG2();
			this.addChild(mySvg);
			trace( mySvg.numChildren);
			
			for (var i:int = 0; i < mySvg.numChildren; i++)
			{
				trace( mySvg.getChildAt(i).name );
			}
		
			
		}
		
	}
	
}