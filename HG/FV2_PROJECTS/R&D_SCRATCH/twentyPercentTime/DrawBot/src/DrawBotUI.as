package  
{
	import com.bit101.components.Component;
	import com.bit101.components.PushButton;
	import com.bit101.components.Label;
	import com.bit101.components.InputText;
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.UI.components.sprite.SetSizeSprite;
	import com.bit101.components.NumericStepper;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class DrawBotUI extends SetSizeSprite
	{
		/** Takes sides and radius as input. **/
		private var _botCommandFN:Function;
		
		private var _sides:NumericStepper;
		private var _radius:NumericStepper;
		private var _doItBTN:PushButton;
		
		private var _sidesLBL:Label;
		private var _radiusLBL:Label;
		private var _doItBTNLBL:Label;
		
		public function DrawBotUI(inWid:int, inHig:int, inBotCMDFunc:Function) 
		{
			this.setSize(inWid, inHig);
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(0, 0, inWid, inHig);
			this.graphics.endFill();
			
			var cmp:Vector.<Component> = new Vector.<Component>(0);
			
			_botCommandFN = inBotCMDFunc;
			var hh:int = inHig / 2;
			var w3:int = inWid / 3;
			
			_doItBTN = new PushButton(this, 0, 0, "PLOT!", onPlotButtonPressed);
			_sides = new NumericStepper(this, 0, 0, null);
			_radius = new NumericStepper(this, 0, 0, null);
			
			_sidesLBL = new Label(this, 0, 0, "# SIDES");
			_radiusLBL = new Label(this, 0, 0, "RADIUS:");
			_doItBTNLBL = new Label(this, 0, 0, "Give Robot Command");
			
			var a:Array = [ _doItBTN, _sides, _radius, _sidesLBL, _radiusLBL, _doItBTNLBL ];
			var c:Component;
			for each (  c in a)
			{
				c.setSize(w3, hh);
			}
			
			var lab:Label;
			for (var l:int = 3; l <= 5; l++)
			{
				lab = a[l];
				
				if (l > 3)
				{
					lab.x = a[l - 1].x + a[l - 1].width;
				}
			}
		
			
			_radius.x = _sides.x + _sides.width;
			_doItBTN.x = _radius.x + _radius.width;
			
			_sides.y = hh;
			_radius.y = hh;
			_doItBTN.y = hh;
			
			_sides.value = 4;
			_radius.value = 30;
			
			
			
			
		}
		
		private function onPlotButtonPressed(evt:Event):void
		{
			_botCommandFN(_sides.value, _radius.value);
		}
		
		
	}//class
}//package