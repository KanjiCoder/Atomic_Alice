/**
 * Copyright i_ze ( http://wonderfl.net/user/i_ze )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/joNX
 */

package 
{

	import net.wonderFL.effects.effectsInMotion.fluidDrawer.FluidDrawer;
	
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageQuality;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.hires.debug.Stats;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * ...
     * @author ze
     */
     [SWF(frameRate='60')]

    public class Main extends Sprite 
    {
        //private var starling:Starling;
        
        public function Main():void 
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            stage.quality = StageQuality.BEST;
            var fd:FluidDrawer = new FluidDrawer(stage);
            addChild(fd);
            var stats:Stats = new Stats();
            addChild(stats);           
        }
        
    }
 }//package