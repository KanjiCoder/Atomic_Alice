package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import nl.funkyMonkey.drawing.DrawingShapes;
	import JM_LIB.graphics.drawing.VectorDrawingUtil;
	
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
			
			var g:Graphics = this.graphics;
			g.lineStyle(2, 0xFF, 1);
			//DrawingShapes.drawArc(this.graphics, 300, 300, 30, 350);
			
			//DrawingShapes.drawArcWithThickness(this.graphics, 300, 300, 30, 35, 180, 0, false);
			
			//VectorDrawingUtil.drawSolidArc(g, 300, 300, 200, 300, 0, Math.PI);
			
			//VectorDrawingUtil.drawSolidArcUsingDegrees(g, 300, 300, 200, 250, 0, 180);
		    VectorDrawingUtil.drawSolidArc(g, 300, 300, 200, 250, 0, Math.PI);
		}
	}
	
}